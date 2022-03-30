package com.zen.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.zen.project.dto.Paging;
import com.zen.project.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	BoardService bs;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("boardList")
	public ModelAndView boardList(@RequestParam(value="sub", required=false) String sub, HttpServletRequest request) {
		
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
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		if(request.getParameter("key") != null) {
			key = request.getParameter("key");
			session.setAttribute("key", key);
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
			paramMap.put("boardnum", Integer.parseInt(list.get("NUM").toString()));
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
	
	@RequestMapping("boardDetail")
	public ModelAndView boardDetail(@RequestParam("num") int num) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("num", num);
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		bs.getBoard(paramMap);
		
		ArrayList<HashMap<String, Object>> boardVO
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> replyVO
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		
		mav.addObject("boardVO", boardVO.get(0));
		mav.addObject("replyVO", replyVO);
		mav.setViewName("board/boardDetail");
		
		return mav;
	}
	
	@RequestMapping(value = "deleteBoard", method = RequestMethod.POST)
	public String deleteBoard(@RequestParam("num") int num) {
		
		bs.deleteBoard(num);
		
		return "redirect:/boardList";
	}
	
	@RequestMapping("writeBoardForm")
	public String writeBoardForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") == null) return "member/login";
		else return "board/writeBoard";
	}
	
	@RequestMapping("/uploadImg")
	public String uploadImg() {
		return "board/uploadImg";
	}
	
	@RequestMapping(value="/uploadFile", method=RequestMethod.POST)
	public String uploadFile(HttpServletRequest request, Model model) {
		
		String path = context.getRealPath("/board_images");
		
		try {
			MultipartRequest multi
				= new MultipartRequest(request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			model.addAttribute("image", multi.getFilesystemName("image"));
		} catch(IOException e) {
			e.printStackTrace();
		}
		return "board/completeImg";
	}
	
}
