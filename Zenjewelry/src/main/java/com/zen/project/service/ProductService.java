package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IProductDao;

@Service
public class ProductService {

	@Autowired
	IProductDao pdao;

	public void getBestNewProduct(HashMap<String, Object> paramMap) {
		pdao.getBestNewProduct(paramMap);
	}

	public void getProductList(HashMap<String, Object> paramMap) {
		pdao.getProductList(paramMap);
	}

	public void getAllCount(HashMap<String, Object> paramMap) {
		pdao.getAllCount(paramMap);
	}

	public void getBestProductList(HashMap<String, Object> paramMap) {
		pdao.getBestProductList(paramMap);
	}

	public void getBestAllCount(HashMap<String, Object> paramMap) {
		pdao.getBestAllCount(paramMap);
	}

	public void getProduct(HashMap<String, Object> paramMap) {
		pdao.getProduct(paramMap);
	}

	public void insertProductQna(HashMap<String, Object> paramMap) {
		pdao.insertProductQna(paramMap);
	}

	public void getProductQna(HashMap<String, Object> paramMap) {
		pdao.getProductQna(paramMap);
	}

	public void deleteProductQna(int qna_num) {
		pdao.deleteProductQna(qna_num);
	}

	public void getMainPromotionList(HashMap<String, Object> paramMap) {
		pdao.getMainPromotionList(paramMap);
	}
}
