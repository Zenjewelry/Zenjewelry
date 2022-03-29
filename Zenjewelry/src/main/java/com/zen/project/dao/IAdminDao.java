package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	void getAdmin(HashMap<String, Object> paramMap);
	void getAllCountProduct(HashMap<String, Object> paramMap);
	void getProductList(HashMap<String, Object> paramMap);
}
