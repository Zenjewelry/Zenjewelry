package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IPromotionDao {

	void findProduct(HashMap<String, Object> paramMap);
	void insertPromotion(HashMap<String, Object> paramMap);
	void insertPromotion_products(HashMap<String, Object> paramMap);
	void getAllCountPromotion(HashMap<String, Object> paramMap);
	void getPromotionList(HashMap<String, Object> paramMap);
	void getPromotionDetail(HashMap<String, Object> paramMap);
	
}
