package com.zen.project.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.zen.project.dto.Paging;
import com.zen.project.dto.PromotionVO;
import com.zen.project.service.PromotionService;

@Controller
public class PromotionController {

	@Autowired
	PromotionService ps;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/adminPromotionWrite")
	public String adminPromotionWrite(HttpServletRequest request, Model model,
			@ModelAttribute("promotionVO") PromotionVO promotionVO,
			@RequestParam(value="outnumber", required=false) String outnumber) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginAdmin") == null) return "admin/adminLoginForm";
		
		model.addAttribute("sYear", request.getParameter("sYear"));
		model.addAttribute("sMonth", request.getParameter("sMonth"));
		model.addAttribute("sDay", request.getParameter("sDay"));
		model.addAttribute("eYear", request.getParameter("eYear"));
		model.addAttribute("eMonth", request.getParameter("eMonth"));
		model.addAttribute("eDay", request.getParameter("eDay"));
		model.addAttribute("outnumber", request.getParameter("outnumber"));
		
		return "admin/promotion/writePromotion";
	}
	
	@RequestMapping("/findProduct")
	public String findProduct(@RequestParam("pseq") int pseq,
			@RequestParam("outnum") int outnum, Model model) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pseq", pseq);
		paramMap.put("ref_cursor", null);
		ps.findProduct(paramMap);
		
		ArrayList<HashMap<String, Object>> output
		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		model.addAttribute("output", output.get(0));
		model.addAttribute("outnum", outnum);
		
		return "admin/promotion/checkProduct";
	}
	
	@RequestMapping("/uploadPromotionImg")
	public String uploadPromotionImg(@RequestParam(value="where", required=false) String where, Model model) {
		model.addAttribute("where", where);
		return "admin/promotion/uploadImg";
	}
	
	@RequestMapping(value="/uploadPromotionFile", method=RequestMethod.POST)
	public String uploadPromotionFile(HttpServletRequest request, Model model,
			@RequestParam(value="where", required=false) String where) {
		
		String path = context.getRealPath("/promotion_images");
		
		try {
			MultipartRequest multi
				= new MultipartRequest(request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			model.addAttribute("image", multi.getFilesystemName("image"));
			model.addAttribute("where", where);
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return "admin/promotion/completeImg";
	}
	
	@RequestMapping(value="/insertPromotion", method=RequestMethod.POST)
	public ModelAndView insertPromotion(HttpServletRequest request,
			@ModelAttribute("promotionVO") PromotionVO promotionVO) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("admin/adminLoginForm");
		else {
			String startDate = request.getParameter("sYear") + "-" + request.getParameter("sMonth") + "-" + request.getParameter("sDay") + " 00:00:00";
			String endDate = request.getParameter("eYear") + "-" + request.getParameter("eMonth") + "-" + request.getParameter("eDay") + " 23:59:59";
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date ssDate = null;
			Date eeDate = null;
			java.sql.Date sDate = null;
			java.sql.Date eDate = null;
			try {
				ssDate = sdf.parse(startDate);
				eeDate = sdf.parse(endDate);
				sDate = new java.sql.Date(ssDate.getTime());
				eDate = new java.sql.Date(eeDate.getTime());
				System.out.println(sDate + ", " + eDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("prmVO", promotionVO);
			paramMap.put("prmseq", null);
			paramMap.put("sDate", sDate);
			paramMap.put("eDate", eDate);
			
			ps.insertPromotion(paramMap);
			
			for(int i=1; i<=promotionVO.getOutnumber(); i++) {
				String pseq = "pseq" + i;
				String [] pseqArr = request.getParameterValues(pseq);
				
				String price2 = "price2" + i;
				String [] price2Arr = request.getParameterValues(price2);
				
				String summary = "Summary" + i;
				paramMap.put("summaryImg", request.getParameter(summary));
				
				paramMap.put("outnumber", i);
				for(int j=0; j<pseqArr.length; j++) {
					paramMap.put("pseq", pseqArr[j]);
					paramMap.put("price2", price2Arr[j]);
					ps.insertPromotion_products(paramMap);
				}
			}
			mav.setViewName("redirect:/promotionList");
		}
		return mav;
	}
	
	@RequestMapping("/promotionList")
	public ModelAndView promotionList(HttpServletRequest request,
			@RequestParam(value="sub", required=false) String sub) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("admin/adminLoginForm");
		else {
			
			if(sub!=null) {
				session.removeAttribute("page");
				session.removeAttribute("key");
			}
			
			int page = 1;
			String key = "";
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			}else if(session.getAttribute("page") != null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			if(request.getParameter("key") != null) {
				key = request.getParameter("key");
				session.setAttribute("key", key);
			}else if(session.getAttribute("key") != null) {
				key = (String)session.getAttribute("key");
			}else {
				session.removeAttribute("key");
			}
			
			Paging paging = new Paging();
			paging.setPage(page);
			paramMap.put("key", key);
			paramMap.put("count", 0);
			ps.getAllCountPromotion(paramMap);
			paging.setTotalCount((Integer)paramMap.get("count"));
			paging.paging();
			paramMap.put("startNum", paging.getStartNum());
			paramMap.put("endNum", paging.getEndNum());
			paramMap.put("ref_cursor", null);
			ps.getPromotionList(paramMap);
			
			ArrayList< HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			mav.addObject("promotionList", list);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.setViewName("admin/promotion/promotionList");
		}
		return mav;
	}
	
	@RequestMapping("/editPromotion")
	public ModelAndView editPromotion(HttpServletRequest request,
			@RequestParam("prmseq") String prmseq) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("admin/adminLoginForm");
		else {
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("prmseq", prmseq);
			paramMap.put("ref_cursor1", null);
			paramMap.put("ref_cursor2", null);
			
			ps.getPromotionDetail(paramMap);
			
			paramMap.put("summary", null);
			ps.getSummary(paramMap);

			ArrayList<HashMap<String, Object>> promotionView
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
			
			ArrayList<HashMap<String, Object>> promotionProductList
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
			
			ArrayList<HashMap<String, Object>> summary
			= (ArrayList<HashMap<String, Object>>)paramMap.get("summary");
			
			mav.addObject("promotionView", promotionView.get(0));
			mav.addObject("promotionProductList", promotionProductList);
			mav.addObject("summary", summary);
			mav.setViewName("admin/promotion/editPromotion");
		}
		return mav;
	}
	
	@RequestMapping(value="/updatePromotion", method=RequestMethod.POST)
	public ModelAndView updatePromotion(HttpServletRequest request,
			@ModelAttribute("promotionVO") PromotionVO promotionVO) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("admin/adminLoginForm");
		else {
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("prmVO", promotionVO);
			
			ps.updatePromotion(paramMap);
			
			for(int i=1; i<=promotionVO.getOutnumber(); i++) {
				String pseq = "pseq" + i;
				String [] pseqArr = request.getParameterValues(pseq);
				
				String price2 = "price2" + i;
				String [] price2Arr = request.getParameterValues(price2);
				
				String summary = "Summary" + i;
				paramMap.put("summaryImg", request.getParameter(summary));
				
				paramMap.put("outnumber", i);
				for(int j=0; j<pseqArr.length; j++) {
					paramMap.put("pseq", pseqArr[j]);
					paramMap.put("price2", price2Arr[j]);
					ps.insertPromotion_products(paramMap);
				}
			}
			mav.setViewName("redirect:/promotionList");
		}
		return mav;
	}
	
}
