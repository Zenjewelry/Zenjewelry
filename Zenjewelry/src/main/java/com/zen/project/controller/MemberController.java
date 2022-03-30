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
import org.springframework.web.bind.annotation.RequestParam;

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
		System.out.println(membervo.getId());
		if( result.getFieldError("id") != null ) {
			model.addAttribute("message" , "아이디를 입력하세요");
			return "member/login";
		}else if( result.getFieldError("pwd") != null ) {
			model.addAttribute("message" , "패스워드를 입력하세요");
			return "member/login";
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", membervo.getId() );
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
	
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@RequestMapping(value="/contract")
	public String contract() {
		return "member/contract";
	}
	
	@RequestMapping(value="/joinForm", method=RequestMethod.POST)
	public String join_form() {
		return "member/joinForm";
	}
	
	@RequestMapping("/idCheckForm")
	public String id_check_form( @RequestParam("id") String id,
			Model model, HttpServletRequest request ) {
		 
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put( "ref_cursor", null );
		paramMap.put("id", id);
		
		ms.getMember(paramMap);	 
		
		ArrayList< HashMap<String,Object> > list 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		if(list.size() == 0) model.addAttribute("result", -1);
		else model.addAttribute("result", 1);
		
		model.addAttribute("id", id);
		return "member/idcheck";
	}
	
	@RequestMapping(value="/findZipNum")
	public String find_zip( HttpServletRequest request , Model model) {
		String dong=request.getParameter("dong");
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(dong != null && dong.trim().equals("")==false){			
			paramMap.put( "ref_cursor", null );
			paramMap.put("dong", dong);
			// System.out.println(paramMap);

			ms.selectAddressByDong(paramMap);
			
			ArrayList< HashMap<String,Object> > list 
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			//System.out.println(list.size() + dong);
			
			model.addAttribute("addressList" , list);
		}
		return "member/findZipNum";
	}
	
	@RequestMapping(value = "/join", method=RequestMethod.POST)
	public String join( @ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result,
			@RequestParam(value="reid", required=false) String reid,
			@RequestParam(value="pwdCheck", required=false) String pwdCheck,
			HttpServletRequest request,
			Model model ) {
		
		model.addAttribute("reid", reid);
				
		if( result.getFieldError("id") != null ) {
			model.addAttribute("message", result.getFieldError("id").getDefaultMessage() );
			return "member/joinForm";
		} else if( result.getFieldError("pwd") != null ) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
			return "member/joinForm";
		} else if( result.getFieldError("name") != null ) {
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
			return "member/joinForm";
		} else if( result.getFieldError("email") != null ) {
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage() );
			return "member/joinForm";
		} else if( result.getFieldError("phone") != null ) {
			model.addAttribute("message", result.getFieldError("phone").getDefaultMessage() );
			return "member/joinForm";
		} else if( reid == null || (   reid != null && !reid.equals(membervo.getId() )  )  ) {
			model.addAttribute("message", "아이디 중복체크를 하지 않으셨습니다");
			return "member/joinForm";
		} else if( pwdCheck == null || (  pwdCheck != null && !pwdCheck.equals(membervo.getPwd() ) ) ) {
			model.addAttribute("message", "비밀번호 확인 일치하지 않습니다");
			return "member/joinForm";
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", membervo.getId() );
		paramMap.put("pwd", membervo.getPwd() );
		paramMap.put("name", membervo.getName() );
		paramMap.put("email", membervo.getEmail() );
		paramMap.put("phone", membervo.getPhone() );
		paramMap.put("zip_num", membervo.getZip_num() );
		paramMap.put("address", membervo.getAddress() );
		
		ms.insertMember( paramMap );
		
		model.addAttribute("message", "회원가입이 완료되었어요. 로그인하세요");
		return "member/login";
	}
	
}
