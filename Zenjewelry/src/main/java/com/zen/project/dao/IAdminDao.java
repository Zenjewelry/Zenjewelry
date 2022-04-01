package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	void getAdmin(HashMap<String, Object> paramMap);
	void getAllCountProduct(HashMap<String, Object> paramMap);
	void getProductList(HashMap<String, Object> paramMap);
	void insertProduct(HashMap<String, Object> paramMap);
	void getAllCountAdminQna(HashMap<String, Object> paramMap);
	void getAdminQnaList(HashMap<String, Object> paramMap);
	void getAdminQna(HashMap<String, Object> paramMap);
	void insertQnaReply(HashMap<String, Object> paramMap);
	
}
