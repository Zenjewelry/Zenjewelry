package com.zen.project.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class BoardVO {

	private int num;
	private String userid;
	@NotEmpty(message="제목을 입력하세요.")
	@NotNull(message="제목을 입력하세요.")
	private String title;
	@NotEmpty(message="내용을 입력하세요.")
	@NotNull(message="내용을 입력하세요.")
	private String content;
	private int readcount;
	private Timestamp writedate;
	private String pictureurl;
}
