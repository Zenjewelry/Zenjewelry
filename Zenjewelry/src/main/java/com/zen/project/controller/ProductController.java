package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zen.project.dto.Paging;
import com.zen.project.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	ProductService ps;
	
	@RequestMapping("/")
	public String main(Model model) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		ps.getBestNewProduct(paramMap);
		
		ArrayList<HashMap<String, Object>> bestList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		
		ArrayList<HashMap<String, Object>> newList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		
		model.addAttribute("newList", newList);
		model.addAttribute("bestList", bestList);
		model.addAttribute("newListSize", newList.size()*320);
		model.addAttribute("bestListSize", bestList.size()*320);
		
		return "main";
	}
	

}
