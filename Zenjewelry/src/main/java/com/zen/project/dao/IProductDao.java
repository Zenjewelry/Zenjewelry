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

}
