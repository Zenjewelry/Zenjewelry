package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
		return "main";
	}
}
