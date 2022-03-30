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
	
		
}	
	


