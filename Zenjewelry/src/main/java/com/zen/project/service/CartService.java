package com.zen.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.ICartDao;

@Service
public class CartService {
	
	@Autowired
	ICartDao cdao;
}
