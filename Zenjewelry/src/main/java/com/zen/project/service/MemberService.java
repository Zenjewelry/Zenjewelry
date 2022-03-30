package com.zen.project.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IMemberDao;

@Service
public class MemberService {

	@Autowired
	IMemberDao mdao;

	public void getMember(HashMap<String, Object> paramMap) {
		mdao.getMember( paramMap );
		
	}

	public void selectAddressByDong(HashMap<String, Object> paramMap) {
		mdao.selectAddressByDong( paramMap );
		
	}

	public void insertMember(HashMap<String, Object> paramMap) {
		mdao.insertMember( paramMap );
		
	}
}
