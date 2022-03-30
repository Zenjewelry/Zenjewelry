package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.zen.project.dto.BoardVO;

@Mapper
public interface IBoardDao {

	void getAllCount(HashMap<String, Object> paramMap);
	void getBoardList(HashMap<String, Object> paramMap);
	void getReplyCnt(HashMap<String, Object> paramMap);
	void getBoard(HashMap<String, Object> paramMap);
	void deleteBoard(int num);
	void insertBoard(BoardVO dto);
	void plusCount(HashMap<String, Object> paramMap);
}
