package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IOrderDao {

	void listOrderByIdIng(HashMap<String, Object> paramMap);

	void listOrderByOseq(HashMap<String, Object> paramMap);

	void insertOrder(HashMap<String, Object> paramMap);

	void listOrderByIdAll(HashMap<String, Object> paramMap1);

	void insertOrderOne(HashMap<String, Object> paramMap);

}
