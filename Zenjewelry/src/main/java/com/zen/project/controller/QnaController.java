
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

import com.zen.project.dto.Paging;
import com.zen.project.dto.QnasVO;
import com.zen.project.service.QnaService;



@Controller
public class QnaController {


	@Autowired
	QnaService qs;
	
	@RequestMapping(value="/qnaList")
	public ModelAndView qna_list(Model model, HttpServletRequest request,
			@RequestParam(value="sub", required=false) String sub) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>)session.getAttribute("loginUser");
		
		if( loginUser == null ) mav.setViewName("member/login");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			if(sub != null) {
				session.removeAttribute("page");
			}
			
			int page = 1;
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			}else if(session.getAttribute("page") != null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			Paging paging = new Paging();
			paging.setPage(page);
			paramMap.put("id", loginUser.get("ID"));
			paramMap.put("count", 0);
			qs.getAllCountQna(paramMap);
			paging.setTotalCount((Integer)paramMap.get("count"));
			paging.paging();
			paramMap.put("startNum", paging.getStartNum());
			paramMap.put("endNum", paging.getEndNum());
			paramMap.put("ref_cursor", null);
			qs.getQnaList(paramMap);
			
			ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("qnaList", list);
			mav.addObject("paging", paging);
			mav.setViewName("qna/qnaList");
		}
		return mav;
	}
	
	@RequestMapping("/qnaView")
	public ModelAndView qna_view(Model model, HttpServletRequest request,
			@RequestParam("qseq") int qseq) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>)session.getAttribute("loginUser");
		
		if( loginUser == null ) mav.setViewName("member/login");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", qseq );
			paramMap.put("ref_cursor", null);
			qs.getQnaDetail( paramMap );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");

			mav.addObject("qnaVO", list.get(0));
			mav.setViewName("qna/qnaView");
		}
		return mav;
	}
	
	@RequestMapping("/qnaWriteForm")
	public String qna_writre_form( HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		if( session.getAttribute("loginUser") == null ) return "member/login";
		
	    return "Qna/qnaWrite";
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

