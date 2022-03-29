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
import org.springframework.web.bind.annotation.RequestMethod;

import com.zen.project.dto.MemberVO;
import com.zen.project.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService ms;
	
	@RequestMapping(value="/loginForm")
	public String loginForm() {
		return "member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login( @ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result, 
			HttpServletRequest request,
			Model model) {
		System.out.println(membervo.getUserid());
		if( result.getFieldError("id") != null ) {
			model.addAttribute("message" , "아이디를 입력하세요");
			return "member/login";
		}else if( result.getFieldError("pwd") != null ) {
			model.addAttribute("message" , "패스워드를 입력하세요");
			return "member/login";
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", membervo.getUserid() );
			paramMap.put("ref_cursor", null);
			ms.getMember(paramMap);
			ArrayList< HashMap<String,Object> > list 
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			if(list.size() == 0) {  // 입력한 아이디 없다면
				model.addAttribute("message" , "아이디가 없어요");
				return "member/login";
			}
			HashMap<String, Object> mvo = list.get(0);
			if(mvo.get("PWD")==null) {
				model.addAttribute("message" , "관리자에게 문의하세요");
				return "member/login";
			}else if( membervo.getPwd().equals( (String)mvo.get("PWD") ) ) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", mvo);
				return "redirect:/";
			}else {
				model.addAttribute("message" , "비번이 안맞아요");
				return "member/login";
			}
		}
	}
}
