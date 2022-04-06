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

	public void updateMember(HashMap<String, Object> paramMap) {
		mdao.updateMember( paramMap );
	}

	public void findId(HashMap<String, Object> paramMap) {
		mdao.findId( paramMap );
	}

	public void findPwd(HashMap<String, Object> paramMap) {
		mdao.findPwd( paramMap );
		
	}

	public void selectMember(HashMap<String, Object> paramMap) {
		mdao.selectMember( paramMap );
		
	}

	public void selectPwd(HashMap<String, Object> paramMap) {
		mdao.selectPwd(paramMap);
	}

	public void getEmail(HashMap<String, Object> paramMap) {
		mdao.getEmail(paramMap);
		
	}
}
