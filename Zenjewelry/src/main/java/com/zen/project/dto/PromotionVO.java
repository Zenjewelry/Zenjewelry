package com.zen.project.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PromotionVO {

	private int prmseq;
	private String banner;
	private String main_subject;
	private String sub_subject;
	private Timestamp sdate;
	private Timestamp edate;
	private int outnumber;
	private String summary;

}
