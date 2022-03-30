package com.zen.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.zen.project.dao.IQnaDao;

import java.util.HashMap;

@Service
public class QnaService {

	@Autowired
	IQnaDao qdao;

	public void listQna(HashMap<String, Object> paramMap) {
		qdao.listQna( paramMap );		
	}
	public void getQna(HashMap<String, Object> paramMap) {
		qdao.getQna( paramMap );		
	}
	public void insertQna(HashMap<String, Object> paramMap) {
		qdao.insertQna( paramMap );			
	}	
}
