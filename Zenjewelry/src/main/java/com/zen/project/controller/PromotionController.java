package com.zen.project.controller;

import java.io.IOException;
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
		
//		int sYear = Integer.parseInt(request.getParameter("sYear"));
//		int sMonth = Integer.parseInt(request.getParameter("sMonth"));
//		int sDay = Integer.parseInt(request.getParameter("sDay"));
//		int eYear = Integer.parseInt(request.getParameter("eYear"));
//		int eMonth = Integer.parseInt(request.getParameter("eMonth"));
//		int eDay = Integer.parseInt(request.getParameter("eDay"));
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
			String sDate = request.getParameter("sYear") + "-" + request.getParameter("sMonth") + "-" + request.getParameter("sDay");
			String eDate = request.getParameter("eYear") + "-" + request.getParameter("eMonth") + "-" + request.getParameter("eDay");
			System.out.println(sDate);
			System.out.println(eDate);
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
	
}
