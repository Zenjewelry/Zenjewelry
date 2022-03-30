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

import com.zen.project.dto.QnasVO;
import com.zen.project.service.QnaService;



@Controller
public class QnaController {


	@Autowired
	QnaService qs;
	
	@RequestMapping(value="/qnaList")
	public ModelAndView qna_list(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> id 
			= (HashMap<String, Object>)session.getAttribute("id");
		if( id == null ) {

			mav.setViewName("member/login");

		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id.get("id") );
			paramMap.put("ref_cursor", null);
			qs.listQna( paramMap );

			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			mav.addObject("qnaList", list);
			mav.setViewName("qnas/qnaList");
		}
		return mav;
	}
		@RequestMapping(value="/qnaView")
		public ModelAndView qna_view(Model model, HttpServletRequest request,
				@RequestParam("qseq") int qseq) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			HashMap<String, Object> id 
				= (HashMap<String, Object>)session.getAttribute("id");
			if( id == null ) {
				mav.setViewName("member/login");
			}else {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("qseq", qseq );
				paramMap.put("ref_cursor", null);
				qs.getQna( paramMap );
				
				ArrayList<HashMap<String, Object>> list 
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_curser");

				mav.addObject("QnasVO", list.get(0) );		
				mav.setViewName("qnas/qnaView");
			}
			return mav;
}
		@RequestMapping(value="/qnaWriteForm")
		public String qna_writre_form( HttpServletRequest request) {
			HttpSession session = request.getSession();
			HashMap<String, Object> id
				= (HashMap<String, Object>)session.getAttribute("id");
			if( id == null ) return "member/login";
			
		    return "Qnas/QnaWrite";
		}

		@RequestMapping("QnaWrite")
		public ModelAndView qna_write( @ModelAttribute("dto") @Valid QnasVO qnasvo,
				BindingResult result,  HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			HashMap<String, Object> id 
				= (HashMap<String, Object>) session.getAttribute("id");
		    if (id == null) 
		    	mav.setViewName("member/login");
		    else {
				if(result.getFieldError("subject") != null ) {
					mav.addObject("message", result.getFieldError("subject").getDefaultMessage() );
					mav.setViewName("qnas/qnaWrite");
					return mav;
				}else if(result.getFieldError("content") != null ) {
					mav.addObject("message", result.getFieldError("content").getDefaultMessage());
					mav.setViewName("qnas/qnaWrite");
					return mav;
				}
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("id", id.get("id") );
				paramMap.put("subject", qnasvo.getSubject() );
				paramMap.put("content", qnasvo.getContent() );
				qs.insertQna( paramMap );
				mav.setViewName("redirect:/qnaList");
		    }
			return mav;
		}

}
