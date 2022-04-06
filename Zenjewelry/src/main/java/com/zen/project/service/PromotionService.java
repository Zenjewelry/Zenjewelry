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

	public void insertPromotion(HashMap<String, Object> paramMap) {
		pdao.insertPromotion(paramMap);
	}

	public void insertPromotion_products(HashMap<String, Object> paramMap) {
		pdao.insertPromotion_products(paramMap);
	}

	public void getAllCountPromotion(HashMap<String, Object> paramMap) {
		pdao.getAllCountPromotion(paramMap);
	}

	public void getPromotionList(HashMap<String, Object> paramMap) {
		pdao.getPromotionList(paramMap);
	}

	public void getPromotionDetail(HashMap<String, Object> paramMap) {
		pdao.getPromotionDetail(paramMap);
	}

	public void getSummary(HashMap<String, Object> paramMap) {
		pdao.getSummary(paramMap);
	}
}
