package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zen.project.dto.Paging;
import com.zen.project.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	BoardService bs;
	
	@RequestMapping("boardList")
	public ModelAndView boardList(@RequestParam("sub") String sub, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		String url = "";
		int page = 1;
		String key = "";
		HttpSession session = request.getSession();
		
		if(sub != null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		
		if(request.getParameter("page") != null) {
			session.setAttribute("page", page);
			page = Integer.parseInt(request.getParameter("page"));
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		if(request.getParameter("key") != null) {
			session.setAttribute("key", key);
			key = request.getParameter("key");
		}else if(session.getAttribute("key") != null) {
			key = (String)session.getAttribute("key");
		}else {
			session.removeAttribute("key");
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("key", key);
		paramMap.put("count", 0);
		bs.getAllCount(paramMap);
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		bs.getBoardList(paramMap);
		
		ArrayList<HashMap<String, Object>> boardList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		for(HashMap<String, Object> list : boardList) {
			System.out.println(0);
			System.out.println(list.get("num"));
			System.out.println(1);
			paramMap.put("boardnum", (int)list.get("num"));
			paramMap.put("replycnt", 0);
			bs.getReplyCnt(paramMap);
			list.put("REPLYCOUNT", paramMap.get("replycnt"));
		}
		
		mav.addObject("boardList", boardList);
		mav.addObject("paging", paging);
		mav.addObject("key", key);
		mav.setViewName("board/boardList");
		
		return mav;
	}
}
