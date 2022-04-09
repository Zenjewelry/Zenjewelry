package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IProductDao {

	void getBestNewProduct(HashMap<String, Object> paramMap);
	void getProductList(HashMap<String, Object> paramMap);
	void getAllCount(HashMap<String, Object> paramMap);
	void getBestProductList(HashMap<String, Object> paramMap);
	void getBestAllCount(HashMap<String, Object> paramMap);
	void getProduct(HashMap<String, Object> paramMap);
	void insertProductQna(HashMap<String, Object> paramMap);
	void getProductQna(HashMap<String, Object> paramMap);
	void deleteProductQna(int qna_num);

	void productAll(HashMap<String, Object> paramMap);
	void AllCountProduct(HashMap<String, Object> paramMap);

	void getMainPromotionList(HashMap<String, Object> paramMap);
	void getSearchCount(HashMap<String, Object> paramMap);
	void getSearchProductList(HashMap<String, Object> paramMap);
	
	void bestUpList(HashMap<String, Object> paramMap);
	void upBestList(HashMap<String, Object> paramMap);
	void downBestList(HashMap<String, Object> paramMap);
	void allUpList(HashMap<String, Object> paramMap);
	void allDownList(HashMap<String, Object> paramMap);
	void kindUpList(HashMap<String, Object> paramMap);
	void kindDownList(HashMap<String, Object> paramMap);


}
