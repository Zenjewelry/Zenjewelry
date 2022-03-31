package com.zen.project.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class Product_QnaVO {
	
	private int qna_num;
	private String id;
	@NotNull(message="비밀번호 입력은 필수입니다.")
	@NotEmpty(message="비밀번호 입력은 필수입니다.")
	private String pwd;
	private int pseq;
	@NotNull(message="제목을 입력해주세요.")
	@NotEmpty(message="제목을 입력해주세요.")
	private String subject;
	@NotNull(message="내용을 입력해주세요.")
	@NotEmpty(message="내용을 입력해주세요.")
	private String content;
	private String reply;
	private String rep;
	private Timestamp indate;

}
