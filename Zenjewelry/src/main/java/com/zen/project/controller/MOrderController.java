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

import com.zen.project.service.OrderService;

@Controller
public class MOrderController {
	
	@Autowired
	OrderService os;
	
	@RequestMapping(value="/mmyPage")
	public ModelAndView myPage( HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser
			= (HashMap<String, Object>) session.getAttribute("loginUser");
		
		ModelAndView mav = new ModelAndView();
		
		if(loginUser == null ) {
			mav.setViewName("mobile/member/login"); // session에 저장된 값 없으면 login으로 돌아가기
		} else {
			ArrayList<HashMap<String,Object>> finalList
			= new ArrayList<HashMap<String, Object>>();
			
			// 현재 로그인 중인 유저의 진행중인 주문번호 리스트 조회
			HashMap<String, Object>paramMap1 = new HashMap<String,Object>();
			paramMap1.put("id",loginUser.get("ID"));
			paramMap1.put("ref_cursor",null); 
			// System.out.println(paramMap1);
			os.listOrderByIdIng(paramMap1);  // 현재 로그인 유저의 진행중인 주문들의 "주문번호들 조회"
			
			ArrayList<HashMap<String,Object>> oseqList
			= (ArrayList<HashMap<String,Object>>) paramMap1.get("ref_cursor");
			// 부분번호별 주문내역을 조회
			for( HashMap<String, Object> result : oseqList) {
				int oseq = Integer.parseInt(result.get("OSEQ").toString()); // 주문번호 1개 추출
				
				HashMap<String, Object>paramMap2 = new HashMap<String,Object>();
				paramMap2.put("oseq",oseq);
				paramMap2.put("reg_cursor",null); 
				os.listOrderByOseq(paramMap2); // 추출할 주문번호를 이용하여 주문 내역(상품들)조회
				// System.out.println(paramMap2);
				ArrayList<HashMap<String, Object>> orderListByOseq
				= (ArrayList<HashMap<String, Object>>) paramMap2.get("ref_cursor");
				
				HashMap<String,Object> orderFirst = orderListByOseq.get(0);  // 주문 상품들 중 첫번째 주문 추출
				orderFirst.put("PNAME",(String)orderFirst.get("PNAME")+" 포함" + orderListByOseq.size()+"건");
//				// 추출한 첫번째 상품의 상품명을 "XXX 포함 X건"이라고 수정
//				int totalPrice = 0;
//				for( HashMap<String, Object> order : orderListByOseq ) {
//					totalPrice += Integer.parseInt( order.get("QUANTITY").toString())
//									* Integer.parseInt( order.get("SELLPRICE").toString());
//				}
//				orderFirst.put("totalPrice",totalPrice); // 추출한 첫번째 상품의 가격을 총 가격으로 수정
//				//  주변 번호별 대표 상품 (첫번째 상품)을 별도의 리스트로 모아서 model 에 저장
				finalList.add(orderFirst);
			}
			mav.addObject("orderList",finalList);
		}
		
		mav.addObject("title", "진행중인 주문내역");
		mav.setViewName("mobile/mypage/mypage");
		return mav;
	}
	
	@RequestMapping(value="/morderInsert")
	public String orderInsert (HttpServletRequest request) {
		int oseq =0;
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser
			= (HashMap<String,Object>) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			return ("mobile/member/login");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", loginUser.get("ID"));
			paramMap.put("address", loginUser.get("ADDRESS"));
			paramMap.put("zip_num", loginUser.get("ZIP_NUM"));
			paramMap.put("address2", loginUser.get("ADDRESS2"));

			paramMap.put("oseq", 0);  // OUT 변수로 적용되어서 돌아올 방금 주문한 주문의 주문번호
			os.insertOrder(paramMap);
			// 아이디로 카트 검색 
			// 검색내용으로 orders 와 order_detail 테이블에 레코드 추가 
			// oseq 에 주문번호를 넣어 갖고 되돌아옵니다. 
			
			oseq = Integer.parseInt(paramMap.get("oseq").toString());

			return "redirect:/morderList?oseq="+oseq;
		}
	}	
	@RequestMapping(value="/morderList")
	public ModelAndView orderList (HttpServletRequest request, Model model,
			@RequestParam("oseq") int oseq) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser
			= (HashMap<String,Object>) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			mav.setViewName("mobile/member/login");
		} else {
			HashMap<String,Object> paramMap = new HashMap<String, Object>();
			paramMap.put("oseq", oseq);
			paramMap.put("ref_cursor", null);
			
			os.listOrderByOseq(paramMap); // 주문번호에 의한 주문목록 조회

			ArrayList<HashMap<String,Object>> list
			 = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			mav.addObject("orderList",list);
			mav.addObject("orderList11",list.get(0));
			
			int totalPrice = 0;
			
			for( HashMap<String,Object> cart : list) {
				totalPrice += Integer.parseInt(cart.get("SELLPRICE").toString());
			}  // 리스트의 내용으로 총금액 계산
			mav.addObject("totalPrice",totalPrice);
			mav.setViewName("mobile/mypage/orderList");
		}
		return mav;
	}
	
	@RequestMapping(value="/morderAll")
	public ModelAndView orderAll(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser
			= (HashMap<String,Object>) session.getAttribute("loginUser");
		
		ModelAndView mav = new ModelAndView();
		
		if(loginUser == null) {
			mav.setViewName("mobile/member/login");
		} else {
			ArrayList<HashMap<String, Object>> finalList
			= new ArrayList<HashMap<String, Object>> ();
			
			// 현재 로그인 중인 유저의 진행중인 주문번호 리스트 조회
			HashMap<String, Object> paramMap1 = new HashMap<String, Object>();
			paramMap1.put("id", loginUser.get("ID"));
			paramMap1.put("ref_cursor", null);
			
			os.listOrderByIdAll(paramMap1); // 현재 로그인 유저의 진행중인 주문들의 "주문번호들 조회"
			
			ArrayList<HashMap<String, Object>> oseqList
			= (ArrayList<HashMap<String,Object>>) paramMap1.get("ref_cursor");
			// 주문번호별 주문내역을 조회
			for( HashMap<String, Object> result : oseqList) {
			int oseq = Integer.parseInt( result.get("OSEQ").toString());  // 주문번호 1개 추출
			HashMap<String,Object> paramMap2 = new HashMap<String,Object>();
			paramMap2.put("oseq", oseq);
			paramMap2.put("reg_cursor", null);
			os.listOrderByOseq(paramMap2);
			
			ArrayList<HashMap<String, Object>> orderListByOseq
			= (ArrayList<HashMap<String, Object>>) paramMap2.get("ref_cursor");
			HashMap<String,Object> orderFirst = orderListByOseq.get(0);  // 주문 상품들 중 첫번째 주문 추출
			orderFirst.put("PNAME",(String)orderFirst.get("PNAME")+"포함" + orderListByOseq.size()+"건");
			// 추출한 첫번째 상품의 상품명을 "XXX 포함 X건"이라고 수정
			int totalPrice = 0;
			for( HashMap<String, Object> order : orderListByOseq ) {
				totalPrice += Integer.parseInt( order.get("QUANTITY").toString())
								* Integer.parseInt( order.get("SELLPRICE").toString());
			}
			orderFirst.put("SELLPRICE",totalPrice); // 추출한 첫번째 상품의 가격을 총 가격으로 수정
			//  주변 번호별 대표 상품 (첫번째 상품)을 별도의 리스트로 모아서 model 에 저장
			finalList.add(orderFirst);
		}
	mav.addObject("orderList",finalList);
	mav.addObject("title", "전체 주문내역");
	mav.setViewName("mobile/mypage/mypage");
	}
	return mav;
}
	
	
	@RequestMapping(value="/morderDetail")
	public ModelAndView orderAll (HttpServletRequest request, Model model, 
			@RequestParam("oseq") int oseq) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		HashMap<String, Object> loginUser
		= (HashMap<String, Object> ) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			mav.setViewName("mobile/member/login");
		} else {
			HashMap<String, Object> paramMap	= new HashMap<String, Object> ();
			paramMap.put("oseq", oseq);
			paramMap.put("ref_cursor", null);
			os.listOrderByOseq(paramMap);
			
			ArrayList<HashMap<String, Object>> orderListByOseq
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			int totalPrice = 0;
			int odseq = 0;
			for( HashMap<String, Object> order : orderListByOseq ) {
				totalPrice += Integer.parseInt( order.get("SELLPRICE").toString());
				odseq = Integer.parseInt(order.get("ODSEQ").toString()); 
				}
			
				mav.addObject("totalPrice",totalPrice);
				mav.addObject("orderList",orderListByOseq);
				mav.addObject("orderDetail",orderListByOseq.get(0));
				mav.setViewName("mobile/mypage/orderDetailList");
			
		}
		return mav;
		
	}
	
	@RequestMapping(value="/morderOne")
	public String orderInsertOne(HttpServletRequest request, 
			@RequestParam("pseq") int pseq,
			@RequestParam("quantity") int quantity,
			@RequestParam("sellprice") int sellprice,
			@RequestParam("option1") String option1,
			@RequestParam("option2") String option2,
			@RequestParam("option3") String option3
			) {
		
		int oseq = 0;
		
		HttpSession session = request.getSession();
		HashMap<String, Object> loginUser
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "mobile/member/login";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", loginUser.get("ID"));
			paramMap.put("address", loginUser.get("ADDRESS"));
			paramMap.put("zip_num", loginUser.get("ZIP_NUM"));
			paramMap.put("address2", loginUser.get("ADDRESS2"));
			paramMap.put("oseq", 0);
			paramMap.put("sellprice", sellprice * quantity);
			paramMap.put("option1", option1);
			paramMap.put("option2", option2);
			paramMap.put("option3", option3);
			paramMap.put("pseq", pseq);
			paramMap.put("quantity", quantity);
			
			os.insertOrderOne(paramMap);
			
			oseq = Integer.parseInt(paramMap.get("oseq").toString());
			
		}
		return "redirect:/morderList?oseq="+oseq;
		
	}
	
	
//		@RequestMapping(value="/deleteOrder")
//		public ModelAndView deleteOrder(@RequestParam(value="odseq", required=false) String odseq) {
//			
//			ModelAndView mav = new ModelAndView();
//			mav.setViewName("redirect:/deleteOrderPassWord?odseq" + odseq );
//			return mav;
//		}
	
	
	
	@RequestMapping(value="/mdeleteOrderPassWord")
	public String deleteOrderPassWord(HttpServletRequest request, 
			 Model model,
			@RequestParam("oseq") int oseq) {
		
		HttpSession session = request.getSession();
		
		HashMap<String, Object> loginUser
			= (HashMap<String, Object>)session.getAttribute("loginUser");
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("oseq", oseq);
		
		if(loginUser==null) return "mobile/member/login";
		
		return "mobile/mypage/deleteOrder";
		
//		model.addAttribute("oseq", oseq);
//		if(repassword == "" || repassword == null ) {
//			model.addAttribute("message", "비밀번호를 입력해주세요");
//			return "mypage/deleteOrder";
//		}else if(!repassword.equals(loginUser.get("PWD").toString())){
//			model.addAttribute("message", "비밀번호가 다릅니다.");
//			return "mypage/deleteOrder";
//		}
//		
//		os.deleteOrder(oseq);
//		
//		return "mypage/completeDeleteOrder";
	}
	
	@RequestMapping("/mdeleteOrder")
	public String deleteOrder(HttpServletRequest request, Model model,
			@RequestParam("oseq") int oseq) {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser")==null) return "mobile/member/login";
		
		os.deleteOrder(oseq);
		
		return "redirect:/mmyPage";
	}
		
		
}