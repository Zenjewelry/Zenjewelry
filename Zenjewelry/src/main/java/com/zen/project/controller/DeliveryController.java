package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zen.project.service.DeliveryService;

@Controller
public class DeliveryController {
	
	@Autowired
	DeliveryService ds;
	
	@RequestMapping(value="/deliveryForm")
	public ModelAndView deliveryForm(HttpServletRequest request, Model model,
			@RequestParam("oseq") String oseq) {
		
		// int oseq1 = Integer.parseInt(oseq);
		System.out.println(oseq);
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String,Object>)session.getAttribute("loginUser");
		
		ModelAndView mav = new ModelAndView();
		
		if(loginUser==null) {
			mav.addObject("member/login");
		} else {
			HashMap<String, Object>paramMap = new HashMap<String,Object>();
			paramMap.put("oseq",oseq);
			paramMap.put("ref_cursor", null);
		
			ds.deliveryList(paramMap);
			
			
			ArrayList< HashMap<String, Object> > list
			= (ArrayList< HashMap<String, Object> >) paramMap.get("ref_cursor");
			
			mav.addObject("orderList",list.get(0));
			
//			int totalPrice = 0;
//			for( HashMap<String, Object> cart : list) {
//				totalPrice += Integer.parseInt(cart.get("QUANTITY").toString() )
//								* Integer.parseInt( cart.get("PRICE2").toString() );
//		}  // 리스트의 내용으로 총금액 계산
//			mav.addObject("totalPrice",totalPrice);
			
			
			mav.setViewName("mypage/deliveryForm");
			
		}
		return mav;
		
		
	}
	
	@RequestMapping(value="/zipUpdate", method=RequestMethod.POST)
	public String memberUpdate(HttpServletRequest request, Model model,
			@RequestParam("address") String address,
			@RequestParam("address2") String address2,
			@RequestParam("oseq") int oseq,
			@RequestParam("zip_num") String zip_num
			) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("oseq", oseq);
		paramMap.put("zip_num", zip_num);
		paramMap.put("address",address);
		paramMap.put("address2",address2);
		
		ds.updateAddress(paramMap);
		
		return "redirect:/orderDetail?oseq="+oseq;
		
	}
	
	

}
