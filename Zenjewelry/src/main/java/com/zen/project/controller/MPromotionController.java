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
public class MPromotionController {


	@Autowired
	PromotionService ps;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/mpromotionDetail")
	public ModelAndView promotionDetail(@RequestParam("prmseq") int prmseq,
			HttpServletRequest request, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
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
		mav.addObject("outnumber", summary.size());
		mav.setViewName("mobile/promotion/promotionDetail");
		
		return mav;
	}
	
}
