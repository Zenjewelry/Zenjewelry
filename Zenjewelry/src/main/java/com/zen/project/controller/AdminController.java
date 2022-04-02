package com.zen.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.zen.project.dto.Paging;
import com.zen.project.dto.ProductVO;
import com.zen.project.service.AdminService;
import com.zen.project.service.ProductService;

@Controller
public class AdminController {

	@Autowired
	AdminService as;
	
	@Autowired
	ProductService ps;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping(value="/admin")
	public String admin() {
		return "admin/adminLoginForm";
	}
	
	@RequestMapping(value="/adminLogin")
	public String adminLogin( HttpServletRequest request, Model model, 
			@RequestParam("workId") String workId, 
			@RequestParam("workPwd") String workPwd) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put( "ref_cursor", null );
		paramMap.put("workId", workId);
		as.getAdmin(paramMap);	 // 조회 
		
		ArrayList< HashMap<String,Object> > list 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		if(list.size() == 0) {  // 입력한 아이디 없다면
			model.addAttribute("message" , "아이디가 없어요");
			return "admin/adminLoginForm";
		}
		HashMap<String, Object> resultMap = list.get(0); 
		if(resultMap.get("PWD")==null) {
			model.addAttribute("message" , "관리자에게 문의하세요");
			return "admin/adminLoginForm";
		}else if( workPwd.equals( (String)resultMap.get("PWD") ) ) {
			HttpSession session = request.getSession();
			session.setAttribute("loginAdmin", resultMap);
			return "redirect:/adminproductList";
		}else {
			model.addAttribute("message" , "비번이 안맞아요");
			return "admin/adminLoginForm";
		}
	}
	

	@RequestMapping(value="/adminLogout")
	public String adminlogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginAdmin");
		return "redirect:/admin";
	}
	
	
	
	

	@RequestMapping(value="/adminproductList")
	public ModelAndView product_list(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		if( session.getAttribute("loginAdmin")==null) mav.setViewName("admin/adminLoginForm");
		else {
			int page = 1;
			String key = "";
			if( request.getParameter("first") != null ) {
				session.removeAttribute("page");
				session.removeAttribute("key");
			}
			if( request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			}else if( session.getAttribute("page") != null ) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			if( request.getParameter("key") != null ) {
				key = request.getParameter("key");
				session.setAttribute("key", key);
			} else if( session.getAttribute("key")!= null ) {
				key = (String)session.getAttribute("key");
			} else {
				session.removeAttribute("key");
			}
			Paging paging = new Paging();
			paging.setPage(page);
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put( "cnt", 0 );
			paramMap.put("key", key);
			as.getAllCountProduct( paramMap );
			int cnt = Integer.parseInt( paramMap.get("cnt").toString() );
			paging.setTotalCount( cnt );
			paging.paging();
			
			paramMap.put("startNum" , paging.getStartNum() );
			paramMap.put("endNum", paging.getEndNum() );
			paramMap.put("key", key);
			paramMap.put( "ref_cursor", null );
			as.getProductList( paramMap );
			
			ArrayList< HashMap<String,Object> > list 
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			mav.addObject("productList", list);
			mav.addObject("paging" , paging);
			mav.addObject("key", key);
			mav.setViewName("admin/product/productList");
		}
		return mav;
	}
	
	@RequestMapping("/adminQnaList")
	public ModelAndView adminQnaList(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		int page = 1;
		String key = "";
		
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("adminLoginForm");
		
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
		as.getAllCountAdminQna(paramMap);
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		as.getAdminQnaList(paramMap);
		
		ArrayList<HashMap<String, Object>> qnaList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		mav.addObject("qnaList", qnaList);
		mav.addObject("paging", paging);
		mav.addObject("key", key);
		mav.setViewName("admin/qna/adminQnaList");
		
		return mav;
	}

	@RequestMapping("/adminProductDetail")
	public ModelAndView productDetail(@RequestParam("pseq") int pseq) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pseq", pseq);
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		ps.getProduct(paramMap);
		
		ArrayList<HashMap<String, Object>> productVO
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> product_QnaVO
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		
		mav.addObject("productVO", productVO.get(0));
		mav.addObject("product_QnaVO", product_QnaVO);
		mav.setViewName("admin/product/productDetail");
		
		return mav;
	}
	
	@RequestMapping("/adminQnaDetail")
	public String adminQnaDetail(HttpServletRequest request, Model model,
			@RequestParam("qseq") int qseq) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginAdmin")==null) model.addAttribute("adminLoginForm");
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq", qseq);
		paramMap.put("ref_cursor", null);
		as.getAdminQna(paramMap);
		
		ArrayList<HashMap<String, Object>> qvo
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("qnaVO", qvo.get(0));
		
		return "admin/qna/adminQnaDetail";
	}
	
	@RequestMapping("/adminQnaRepSave")
	public ModelAndView adminQnaRepSave(HttpServletRequest request,
			@RequestParam("qseq") int qseq, @RequestParam("reply") String reply) {
		
		ModelAndView mav = new ModelAndView ();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginAdmin")==null) mav.setViewName("adminLoginForm");
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq", qseq);
		paramMap.put("reply", reply);
		as.insertQnaReply(paramMap);
		
		mav.addObject("qseq", qseq);
		mav.setViewName("redirect:/adminQnaDetail");
		
		return mav;
	}
	
	@RequestMapping(value="/adminProductWriteForm")
	public String product_write_form( HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginAdmin")==null) return "adminLoginForm";
		
		String kindList[] = {"RING", "EARRINGS", "NECKLACE",  "BRACELET"};
		model.addAttribute("kindList", kindList);
		return "admin/product/productWrite";
	}
	
	@RequestMapping("/uploadThumbImg")
	public String uploadThumbImg() {
		return "admin/product/uploadThumbImg";
	}
	
	@RequestMapping("/uploadDetailImg")
	public String uploadDetailImg() {
		return "admin/product/uploadDetailImg";
	}
	
	@RequestMapping(value="/uploadThumbFile", method=RequestMethod.POST)
	public String uploadThumbFile(HttpServletRequest request, Model model) {
		
		String path = context.getRealPath("/product_images");
		
		try {
			MultipartRequest multi
				= new MultipartRequest(request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			model.addAttribute("thumbImage", multi.getFilesystemName("thumbImage"));
		} catch(IOException e) {
			e.printStackTrace();
		}
		return "admin/product/completeThumbImg";
	}
	
	@RequestMapping(value="/uploadDetailFile", method=RequestMethod.POST)
	public String uploadDetailFile(HttpServletRequest request, Model model) {
		
		String path = context.getRealPath("/product_images");
		
		try {
			MultipartRequest multi
				= new MultipartRequest(request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			model.addAttribute("detailImage", multi.getFilesystemName("detailImage"));
		} catch(IOException e) {
			e.printStackTrace();
		}
		return "admin/product/completeDetailImg";
	}
	
	@RequestMapping(value="adminProductWrite" , method = RequestMethod.POST)
	public ModelAndView productWrite(@ModelAttribute("dto") @Valid ProductVO pvo,
			HttpServletRequest request, BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser")==null) mav.setViewName("adminLoginForm");
		
		mav.setViewName("admin/product/productWrite");
		
		if(result.getFieldError("name")!=null) {
			mav.addObject("message", result.getFieldError("name").getDefaultMessage());
			return mav;
		}else if(result.getFieldError("kind")!=null) {
			mav.addObject("message", result.getFieldError("kind").getDefaultMessage());
			return mav;
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("pvo", pvo);
		as.insertProduct(paramMap);
		
		mav.setViewName("redirect:/adminproductList");
		
		return mav;
	}
	
}
