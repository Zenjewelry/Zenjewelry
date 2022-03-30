package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IDeliveryDao {

	void deliveryList(HashMap<String, Object> paramMap);

	void updateAddress(HashMap<String, Object> paramMap);

}
