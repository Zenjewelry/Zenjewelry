package com.zen.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zen.project.dto.PagingforProduct;
import com.zen.project.dto.Product_QnaVO;
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
		
		paramMap.put("promotion", null);
		ps.getMainPromotionList(paramMap);
		
		ArrayList<HashMap<String, Object>> bestList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		
		ArrayList<HashMap<String, Object>> newList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		
		ArrayList<HashMap<String, Object>> promotionList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("promotion");
		
		model.addAttribute("newList", newList);
		model.addAttribute("bestList", bestList);
		model.addAttribute("newListSize", newList.size()*320);
		model.addAttribute("bestListSize", bestList.size()*320);
		model.addAttribute("promotionList", promotionList);
		model.addAttribute("promotionListSize", promotionList.size());
		
		return "main";
	}
	
	@RequestMapping("/productList")
	public String productList(@RequestParam(value="kind", required=false) int kind,
			Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		model.addAttribute("kind", kind);
		
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
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		if(key==null || key.equals("")) {
			paramMap.put("command", kind);
			ps.getAllCount(paramMap);
		}else {
			paramMap.put("command", key);
			ps.getSearchCount(paramMap);
		}
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		
		if(key==null || key.equals("")) ps.getProductList(paramMap);
		else ps.getSearchProductList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		model.addAttribute("key", key);
		
		return "product/productList";
	}
	
	@RequestMapping("/bestProductList")
	public String bestProductList(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		model.addAttribute("best", "y");
		
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
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		ps.getBestAllCount(paramMap);
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.getBestProductList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		model.addAttribute("key", key);
		
		return "product/productList";
	}
	
	@RequestMapping("/productDetail")
	public ModelAndView productDetail(HttpServletRequest request, @RequestParam("pseq") int pseq) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pseq", pseq);
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		ps.getProduct(paramMap);
		
		paramMap.put("options", null);
		ps.getProductOption(paramMap);
		
		ArrayList<HashMap<String, Object>> productVO
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> product_QnaVO
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		ArrayList<HashMap<String, Object>> options
		= (ArrayList<HashMap<String, Object>>)paramMap.get("options");
		
		
		if(request.getParameter("prmprice") != null)
			mav.addObject("prmprice", request.getParameter("prmprice"));
		
		mav.addObject("productVO", productVO.get(0));
		mav.addObject("product_QnaVO", product_QnaVO);
		mav.addObject("options", options);
		mav.setViewName("product/productDetail");
		
		return mav;
	}
	
	@RequestMapping("writeProductqna")
	public String writeProductqna(@ModelAttribute("product_QnaVO") Product_QnaVO pqvo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser = (HashMap<String, Object>)session.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "member/login";
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pqvo", pqvo);
		paramMap.put("id", loginUser.get("ID"));
		ps.insertProductQna(paramMap);
		
		return "redirect:/productDetail?pseq=" + pqvo.getPseq();
	}
	
	@RequestMapping("/productQnaView")
	public ModelAndView productQnaView(@RequestParam("qna_num") int qna_num) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qna_num", qna_num);
		paramMap.put("ref_cursor", null);
		ps.getProductQna(paramMap);
		
		ArrayList<HashMap<String, Object>> pqvo
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		mav.addObject("product_QnaVO", pqvo.get(0));
		mav.setViewName("product/product_qna_view");
		return mav;
	}
	
	@RequestMapping("/deleteProductQna")
	public ModelAndView deleteProductQna(@RequestParam("qna_num") int qna_num,
			@RequestParam("pseq") int pseq, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println(pseq);
		System.out.println(qna_num);
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) mav.setViewName("member/login");
		
		ps.deleteProductQna(qna_num);
		
		mav.addObject("pseq", pseq);
		mav.setViewName("redirect:/productDetail");
		
		return mav;
	}
	
	@RequestMapping("/productAll")
	public String productAll(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		model.addAttribute("all", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
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
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		ps.AllCountProduct(paramMap);
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.productAll(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		return "product/productList";
	}
	

	@RequestMapping("/bestUpList")
	public String bestUplist(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		model.addAttribute("bestUpList", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");}
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		
		paramMap.put("key", key);
		paramMap.put("count", 0);
		ps.bestUpList(paramMap);
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.upBestList(paramMap);

		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		return "product/productList";
	}

	@RequestMapping("/bestDownList")
	public String bestDownList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		model.addAttribute("bestDownList", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}

		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		
		paramMap.put("key", key);
		paramMap.put("count", 0);
		ps.bestUpList(paramMap);
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.downBestList(paramMap);

		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		return "product/productList";
	}

	@RequestMapping("/allUpList")
	public String allUpList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		model.addAttribute("all", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		ps.AllCountProduct(paramMap);
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.allUpList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		return "product/productList";
	}
	@RequestMapping("/allDownList")
	public String allDownList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		model.addAttribute("all", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		ps.AllCountProduct(paramMap);
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		ps.allDownList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		return "product/productList";
	}
	
	@RequestMapping("/kindUpList")
	public String kindUpList(@RequestParam(value="kind", required=false) int kind,
			Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		model.addAttribute("kindUpList", "y");
		
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		model.addAttribute("kind", kind);
		
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
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		paramMap.put("command", kind);
		ps.getAllCount(paramMap);
	
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("command", kind);
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		
		ps.kindUpList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		model.addAttribute("key", key);
		
		return "product/productList";
	}
	
	@RequestMapping("/kindDownList")
	public String kindDownList(@RequestParam(value="kind", required=false) int kind,
			Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		model.addAttribute("kindDownList", "y");
		if(request.getParameter("sub")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
		int page = 1;
		String key = "";
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		model.addAttribute("kind", kind);
		
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
		
		PagingforProduct paging = new PagingforProduct();
		paging.setPage(page);
		paramMap.put("count", 0);
		paramMap.put("command", kind);
		ps.getAllCount(paramMap);
	
		
		paging.setTotalCount((Integer)paramMap.get("count"));
		paging.paging();
		paramMap.put("command", kind);
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		paramMap.put("ref_cursor", null);
		
		ps.kindDownList(paramMap);
		
		ArrayList<HashMap<String, Object>> productList
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("productList", productList);
		model.addAttribute("paging", paging);
		model.addAttribute("key", key);
		
		return "product/productList";
	}
}
