package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IDeliveryDao;

@Service
public class DeliveryService {
	
	@Autowired
	IDeliveryDao ddao;

	public void deliveryList(HashMap<String, Object> paramMap) {
		ddao.deliveryList(paramMap);
		
	}

}
