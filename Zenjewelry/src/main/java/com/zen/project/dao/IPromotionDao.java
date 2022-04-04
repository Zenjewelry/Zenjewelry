package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IPromotionDao {

	void findProduct(HashMap<String, Object> paramMap);
	
}
