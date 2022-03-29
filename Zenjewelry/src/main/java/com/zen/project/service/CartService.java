package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.ICartDao;

@Service
public class CartService {
	
	@Autowired
	ICartDao cdao;

	public void listCart(HashMap<String, Object> paramMap) {
		cdao.listCart(paramMap);
		
	}
}
