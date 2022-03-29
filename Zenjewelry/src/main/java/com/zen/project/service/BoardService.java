package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IBoardDao;

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

}
