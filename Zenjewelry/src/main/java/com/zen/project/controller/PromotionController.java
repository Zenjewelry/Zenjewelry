package com.zen.project.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zen.project.dto.PromotionVO;
import com.zen.project.sevice.PromotionService;

@Controller
public class PromotionController {

	@Autowired
	PromotionService ps;
	
	@RequestMapping("/adminPromotionWrite")
	public String adminPromotionWrite(HttpServletRequest request, Model model,
			@ModelAttribute("promotionVO") PromotionVO promotionVO) {
		
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
		model.addAttribute("outnumber_chk", request.getParameter("outnumber_chk"));
		
		return "admin/promotion/writePromotion";
	}
	
	@RequestMapping("/findProduct")
	public String findProduct(@RequestParam("pseq") int pseq, Model model) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pseq", pseq);
		paramMap.put("output", 0);
		paramMap.put("name", null);
		ps.findProduct(paramMap);
		
		model.addAttribute("pseq", (Integer)paramMap.get("output"));
		model.addAttribute("name", (String)paramMap.get("name"));
		
		return "admin/promotion/checkProduct";
	}
}
