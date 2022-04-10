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


	public void productAll(HashMap<String, Object> paramMap) {
		pdao.productAll(paramMap);
		
	}

	public void AllCountProduct(HashMap<String, Object> paramMap) {

		pdao.AllCountProduct(paramMap);		
	}

	public void getMainPromotionList(HashMap<String, Object> paramMap) {
		pdao.getMainPromotionList(paramMap);

	}

	public void getSearchCount(HashMap<String, Object> paramMap) {
		pdao.getSearchCount(paramMap);
	}

	public void getSearchProductList(HashMap<String, Object> paramMap) {
		pdao.getSearchProductList(paramMap);
	}

	public void bestUpList(HashMap<String, Object> paramMap) {
		pdao.bestUpList(paramMap);
		
	}

	public void upBestList(HashMap<String, Object> paramMap) {
		pdao.upBestList(paramMap);
	}

	public void downBestList(HashMap<String, Object> paramMap) {
		pdao.downBestList(paramMap);
		
	}

	public void allUpList(HashMap<String, Object> paramMap) {
		pdao.allUpList(paramMap);
		
	}

	public void allDownList(HashMap<String, Object> paramMap) {
		pdao.allDownList(paramMap);
		
	}

	public void kindUpList(HashMap<String, Object> paramMap) {
		pdao.kindUpList(paramMap);
		
	}

	public void kindDownList(HashMap<String, Object> paramMap) {
		pdao.kindDownList(paramMap);
		
	}

	public void getProductOption(HashMap<String, Object> paramMap) {
		pdao.getProductOption(paramMap);
	}

	public void getDistinctProductOption(HashMap<String, Object> paramMap) {
		pdao.getDistinctProductOption(paramMap);
	}
}
