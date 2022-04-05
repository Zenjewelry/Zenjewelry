package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
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
				
				if(mvo.get("USEYN").equals("블랙")){
					model.addAttribute("message" , "블랙리스트 회원입니다 관리자에게 문의하세요");
					return "member/login";
				}else {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", mvo);
				return "redirect:/";}
				
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
		paramMap.put("address2", membervo.getAddress2() );
		
		ms.insertMember( paramMap );
		
		model.addAttribute("message", "회원가입이 완료되었어요. 로그인하세요");
		return "member/login";
	}
	
	@RequestMapping(value = "/editForm")
	public String memberEditForm( HttpServletRequest request, Model model ) {
		
		MemberVO dto = new MemberVO();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser 
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		dto.setId( (String)loginUser.get("ID") );
		dto.setName( (String)loginUser.get("NAME") );
		dto.setEmail( (String)loginUser.get("EMAIL") );
		dto.setPhone( (String)loginUser.get("PHONE") );
		dto.setZip_num( (String)loginUser.get("ZIP_NUM") );
		dto.setAddress( (String)loginUser.get("ADDRESS") );
		dto.setAddress2( (String)loginUser.get("ADDRESS2") );
		
		model.addAttribute("dto" , dto);
		
		return "member/memberUpdateForm";
	}
	
	@RequestMapping(value = "/memberUpdate", method=RequestMethod.POST)
	public String memberUpdate( @ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result,
			@RequestParam(value="pwdCheck", required=false) String pwdCheck,
			HttpServletRequest request,
			Model model ) {
		
		if( result.getFieldError("pwd") != null ) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage() );
			return "member/memberUpdateForm";
		} else if( result.getFieldError("name") != null ) {
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage() );
			return "member/memberUpdateForm";
		} else if( result.getFieldError("email") != null ) {
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage() );
			return "member/memberUpdateForm";
		} else if( result.getFieldError("phone") != null ) {
			model.addAttribute("message", result.getFieldError("phone").getDefaultMessage() );
			return "member/memberUpdateForm";
		} else if( pwdCheck == null || (  pwdCheck != null && !pwdCheck.equals(membervo.getPwd() ) ) ) {
			model.addAttribute("message", "비밀번호 확인 일치하지 않습니다");
			return "member/memberUpdateForm";
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ID", membervo.getId() );
		paramMap.put("PWD", membervo.getPwd() );
		paramMap.put("NAME", membervo.getName() );
		paramMap.put("EMAIL", membervo.getEmail() );
		paramMap.put("PHONE", membervo.getPhone() );
		paramMap.put("ZIP_NUM", membervo.getZip_num() );
		paramMap.put("ADDRESS", membervo.getAddress() );
		paramMap.put("ADDRESS2", membervo.getAddress2() );
		
		ms.updateMember( paramMap );
		
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", paramMap);

		return "redirect:/";
	}
	
	@RequestMapping(value="/findAccount")
	public String findAccount() {
		return "member/findAccount";
	}
	
	@RequestMapping(value="/findIdForm")
	public String findIdForm() {
		return "member/findIdForm";
	}
	
	@RequestMapping(value="/findIdStep1")
	
	public String findIdStep1( @RequestParam("name") String name, 
			@RequestParam("phone") String phone,
			@RequestParam("email") String email,
			Model model
			)  throws Exception{
		
		int result=0;
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("name",name);
			paramMap.put("phone",phone);
			paramMap.put("email",email);
			paramMap.put("ref_cursor", null);
			ms.selectMember(paramMap);
			ArrayList< HashMap<String,Object> > list
				= ( ArrayList< HashMap<String,Object> >)paramMap.get("ref_cursor");
			if(list.size()==0) {
				model.addAttribute("message" , "해당 정보의 아이디가 없어요");
				return "member/findIdForm";
			}else {
			Random random = new Random();
			int checkNum = random.nextInt(888888) + 111111;
			
	
			String recipient = email; // 인증받을 이메일
	        int code = checkNum; // 인증번호 난수넣기
	 
	        if(checkNum !=0) result = 1;
	
	       	model.addAttribute("result", result);
	        model.addAttribute("email", email);
	        model.addAttribute("name", name);
	        model.addAttribute("phone", phone);
	        model.addAttribute("checkNum", checkNum);
	        
	        // 1. 발신자의 메일 계정과 비밀번호 설정
	        final String user = "dangadang97@gmail.com";
	        final String password = "vmfhwprxm";
	 
	        // 2. Property에 SMTP 서버 정보 설정
	        Properties prop = new Properties();
	        prop.put("mail.smtp.host", "smtp.gmail.com");
	        prop.put("mail.smtp.port", 465);
	        prop.put("mail.smtp.auth", "true");
	        prop.put("mail.smtp.ssl.enable", "true");
	        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	 
	        // 3. SMTP 서버정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
	        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(user, password);
	            }
	        });
	 
	        // 4. Message 클래스의 객체를 사용하여 수신자와 내용, 제목의 메시지를 작성한다.
	        // 5. Transport 클래스를 사용하여 작성한 메세지를 전달한다.
	 
	        MimeMessage message = new MimeMessage(session);
	        try {
	            message.setFrom(new InternetAddress(user));
	 
	            // 수신자 메일 주소
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
	 
	            // 제목
	            message.setSubject("PLAYDDIT verification code");
	 
	            // 내용
	            message.setText("Welcome to playddit. your code is ["+code+"]");
	 
	            Transport.send(message);    // send message
	 
	 
	        } catch (AddressException e) {
	            e.printStackTrace();
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
		
        return "member/findIdForm";		}	
    }
	@RequestMapping(value="/ID")
	public String ID(@RequestParam("email") String email, 
			@RequestParam("name") String name,
			@RequestParam("phone") String phone,
			@RequestParam("checkNum") int checkNum,
			@RequestParam("numCheck") int numCheck,
			Model model) {
		
		HashMap<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("phone", phone);
		
		paramMap.put("ref_cursor", null);
		
		ms.findId(paramMap);
		
		ArrayList <HashMap<String,Object>> list
			= (ArrayList <HashMap<String,Object>>) paramMap.get("ref_cursor");
		model.addAttribute("findId", list.get(0));
		
		return "member/ID";
	}
	
	@RequestMapping(value="/findPwForm")
	public String findPwForm() {
		return "member/findPwForm";
	}
	
	@RequestMapping(value="/findPwStep1")
	
	public String findPwStep1( @RequestParam("email") String email, 
			@RequestParam("name") String name,
			@RequestParam("id") String id,
			Model model
			)  throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("email",email);
		paramMap.put("name",name);
		paramMap.put("id",id);
		paramMap.put("ref_cursor", null);
		ms.selectPwd(paramMap);
		ArrayList< HashMap<String,Object> > list
			= ( ArrayList< HashMap<String,Object> >)paramMap.get("ref_cursor");
		if(list.size()==0) {
			model.addAttribute("message" , "해당 정보의 아이디가 없어요");
			return "member/findPwForm";
		}else {
		
		
		int result=0;
		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		

		String recipient = email; // 인증받을 이메일
        int code = checkNum; // 인증번호 난수넣기
 
        if(checkNum !=0) result = 1;

       	model.addAttribute("result", result);
        model.addAttribute("email", email);
        model.addAttribute("name", name);
        model.addAttribute("id", id);
        model.addAttribute("checkNum", checkNum);
        
        // 1. 발신자의 메일 계정과 비밀번호 설정
        final String user = "dangadang97@gmail.com";
        final String password = "vmfhwprxm";
 
        // 2. Property에 SMTP 서버 정보 설정
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", 465);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
 
        // 3. SMTP 서버정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
 
        // 4. Message 클래스의 객체를 사용하여 수신자와 내용, 제목의 메시지를 작성한다.
        // 5. Transport 클래스를 사용하여 작성한 메세지를 전달한다.
 
        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(user));
 
            // 수신자 메일 주소
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
 
            // 제목
            message.setSubject("PLAYDDIT verification code");
 
            // 내용
            message.setText("Welcome to playddit. your code is ["+code+"]");
 
            Transport.send(message);    // send message
 
 
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        
        return "member/findPwForm";	}	
    }
	

	@RequestMapping(value="/change_Pwd")
	public String PWD(@RequestParam("name") String name,
			@RequestParam("id") String id,
			Model model)
	{
		model.addAttribute("name", name);
        model.addAttribute("id", id);
		
		return "member/PWD";
	}
	
	@RequestMapping(value="/PWD")
	public String PWD(@RequestParam("name") String name,
			@RequestParam("id") String id,
			@RequestParam("pwd") String pwd,
			Model model) {
		
				
		HashMap<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("id", id);
		paramMap.put("pwd", pwd);
		
		System.out.println(paramMap);

		ms.findPwd(paramMap);
		
		return "member/login";
	}
	
}
