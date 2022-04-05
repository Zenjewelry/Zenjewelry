package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IPromotionDao;

@Service
public class PromotionService {

	@Autowired
	IPromotionDao pdao;

	public void findProduct(HashMap<String, Object> paramMap) {
		pdao.findProduct(paramMap);
	}
}
