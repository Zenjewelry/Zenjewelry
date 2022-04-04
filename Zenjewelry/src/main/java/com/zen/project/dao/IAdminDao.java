package com.zen.project.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao {

	void getAdmin(HashMap<String, Object> paramMap);
	void getAllCountProduct(HashMap<String, Object> paramMap);
	void getProductList(HashMap<String, Object> paramMap);
	void insertProduct(HashMap<String, Object> paramMap);
	void getAllCountAdminQna(HashMap<String, Object> paramMap);
	void getAdminQnaList(HashMap<String, Object> paramMap);
	void getAdminQna(HashMap<String, Object> paramMap);
	void insertQnaReply(HashMap<String, Object> paramMap);
	void updateProduct(HashMap<String, Object> paramMap);
	void getAllCountAdminProductQna(HashMap<String, Object> paramMap);
	void getProductQnaList(HashMap<String, Object> paramMap);
	void getProductQnaDetail(HashMap<String, Object> paramMap);
	void adminProductQnaReplySave(HashMap<String, Object> paramMap);
	void deleteProductQna(int qnum);
	void deleteProduct(int pseq);
	void getAllCountMember(HashMap<String, Object> paramMap);
	void getMemberList(HashMap<String, Object> paramMap);
	void getAllCountOrder(HashMap<String, Object> paramMap);
	void getOrderList(HashMap<String, Object> paramMap);
	void saveOrder(int odseq);
	void deleteMember(String id);
	
	
}
