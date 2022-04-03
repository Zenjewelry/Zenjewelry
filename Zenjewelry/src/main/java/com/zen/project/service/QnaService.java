package com.zen.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.zen.project.dao.IQnaDao;

import java.util.HashMap;

@Service
public class QnaService {

	@Autowired
	IQnaDao qdao;

	public void getQnaList(HashMap<String, Object> paramMap) {
		qdao.getQnaList( paramMap );		
	}
	public void getQnaDetail(HashMap<String, Object> paramMap) {
		qdao.getQnaDetail( paramMap );		
	}
	public void insertQna(HashMap<String, Object> paramMap) {
		qdao.insertQna( paramMap );			
	}
	public void getAllCountQna(HashMap<String, Object> paramMap) {
		qdao.getAllCountQna(paramMap);
	}	
}
