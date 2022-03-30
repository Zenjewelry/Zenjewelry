package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberDao {

	void getMember(HashMap<String, Object> paramMap);
	void selectAddressByDong(HashMap<String, Object> paramMap);
	void insertMember(HashMap<String, Object> paramMap);

}