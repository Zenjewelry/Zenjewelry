package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IBoardDao;
import com.zen.project.dto.BoardVO;

@Service
public class BoardService {

	@Autowired
	IBoardDao bdao;

	public void getAllCount(HashMap<String, Object> paramMap) {
		bdao.getAllCount(paramMap);
	}

	public void getBoardList(HashMap<String, Object> paramMap) {
		bdao.getBoardList(paramMap);
	}

	public void getReplyCnt(HashMap<String, Object> paramMap) {
		bdao.getReplyCnt(paramMap);
	}

	public void getBoard(HashMap<String, Object> paramMap) {
		bdao.plusCount(paramMap);
		bdao.getBoard(paramMap);
	}

	public void deleteBoard(int num) {
		bdao.deleteBoard(num);
	}

	public void insertBoard(BoardVO dto) {
		bdao.insertBoard(dto);
	}

	public void getBoardWithoutCount(HashMap<String, Object> paramMap) {
		bdao.getBoard(paramMap);
	}

	public void editBoard(HashMap<String, Object> paramMap) {
		bdao.editBoard(paramMap);
	}


}
