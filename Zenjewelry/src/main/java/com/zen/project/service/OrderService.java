package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IOrderDao;

@Service
public class OrderService {
	
	@Autowired
	IOrderDao odao;

	public void listOrderByIdIng(HashMap<String, Object> paramMap) {
		odao.listOrderByIdIng(paramMap);
		
	}

	public void listOrderByOseq(HashMap<String, Object> paramMap) {
		odao.listOrderByOseq(paramMap);
		
	}

	public void insertOrder(HashMap<String, Object> paramMap) {
		odao.insertOrder(paramMap);
		
	}

	public void listOrderByIdAll(HashMap<String, Object> paramMap1) {
		odao.listOrderByIdAll(paramMap1);
		
	}

	public void insertOrderOne(HashMap<String, Object> paramMap) {
		odao.insertOrderOne(paramMap);
		
	}

}
