package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICartDao {

	void listCart(HashMap<String, Object> paramMap);

	void insertCart(HashMap<String, Object> paramMap);

	void deleteCart(HashMap<String, Object> paramMap);

}
