package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.zen.project.dao.IAdminDao;

@Controller
public class AdminService {

	@Autowired
	IAdminDao adao;
	
	
	public void getAdmin(HashMap<String, Object> paramMap) {
		adao.getAdmin( paramMap );		
	}	
	public void getAllCountProduct(HashMap<String, Object> paramMap) {
		adao.getAllCountProduct( paramMap );		
	}
	public void getProductList(HashMap<String, Object> paramMap) {
		adao.getProductList( paramMap );		
	}
	public void insertProduct(HashMap<String, Object> paramMap) {
		adao.insertProduct( paramMap );
	}
	public void getAllCountAdminQna(HashMap<String, Object> paramMap) {
		adao.getAllCountAdminQna(paramMap);
	}
	public void getAdminQnaList(HashMap<String, Object> paramMap) {
		adao.getAdminQnaList(paramMap);
	}
	public void getAdminQna(HashMap<String, Object> paramMap) {
		adao.getAdminQna(paramMap);
	}
	public void insertQnaReply(HashMap<String, Object> paramMap) {
		adao.insertQnaReply(paramMap);
	}
	public void updateProduct(HashMap<String, Object> paramMap) {
		adao.updateProduct(paramMap);
	}
	public void getAllCountAdminProductQna(HashMap<String, Object> paramMap) {
		adao.getAllCountAdminProductQna(paramMap);
	}
	public void getProductQnaList(HashMap<String, Object> paramMap) {
		adao.getProductQnaList(paramMap);
	}
	public void getProductQnaDetail(HashMap<String, Object> paramMap) {
		adao.getProductQnaDetail(paramMap);
	}
	public void adminProductQnaReplySave(HashMap<String, Object> paramMap) {
		adao.adminProductQnaReplySave(paramMap);
	}
	public void deleteProductQna(int qnum) {
		adao.deleteProductQna(qnum);
	}
	public void deleteProduct(int pseq) {
		adao.deleteProduct(pseq);
	}
	public void getAllCountMember(HashMap<String, Object> paramMap) {
		adao.getAllCountMember(paramMap);
	}
	public void getMemberList(HashMap<String, Object> paramMap) {
		adao.getMemberList(paramMap);
	}
	public void getAllCountOrder(HashMap<String, Object> paramMap) {
		adao.getAllCountOrder(paramMap);
	}
	public void getOrderList(HashMap<String, Object> paramMap) {
		adao.getOrderList(paramMap);
	}
	public void saveOrder(int odseq) {
		adao.saveOrder(odseq);
	}
	public void deleteMember(String id) {
		adao.deleteMember(id);
	}
	public void saveOptionMember(HashMap<String, Object> paramMap) {
		adao.saveOptionMember( paramMap );
		
	}
	
	
		
}	
	


