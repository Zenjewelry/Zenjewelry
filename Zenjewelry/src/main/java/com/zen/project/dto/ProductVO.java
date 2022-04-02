package com.zen.project.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class ProductVO {
	private Integer pseq;
	@NotNull(message="상품명은 공란일 수 없습니다.")
	@NotEmpty(message="상품명은 공란일 수 없습니다.")
	private String name;
	@NotNull(message="카테고리는 필수입니다.")
	@NotEmpty(message="카테고리는 필수입니다.")
	private String kind;
	private Integer price1;
	private Integer price2;
	private String content;
	private String image;
	private String detail_image;
	private String newyn;
	private String bestyn;
	private Timestamp indate;
	
}
