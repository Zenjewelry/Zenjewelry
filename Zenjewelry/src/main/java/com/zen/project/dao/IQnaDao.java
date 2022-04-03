package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IQnaDao {

	void getQnaList(HashMap<String, Object> paramMap);
	void getQnaDetail(HashMap<String, Object> paramMap);
	void insertQna(HashMap<String, Object> paramMap);
	void getAllCountQna(HashMap<String, Object> paramMap);

}
