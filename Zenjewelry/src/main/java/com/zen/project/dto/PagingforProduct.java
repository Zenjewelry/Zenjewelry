package com.zen.project.dto;

import lombok.Data;

@Data
public class PagingforProduct {

	private int page = 1;
	private int totalCount;
	private int beginPage;
	private int endPage;
	private int displayRow=8;
	private int displayPage=10;
	private boolean prev;
	private boolean next;
	private int startNum;
	private int endNum;
	
	public void paging() {
		endPage = ((int)Math.ceil(page/(double)displayPage)) * displayPage;
		beginPage = endPage - (displayPage - 1);
		int totalPage = (int)Math.ceil(totalCount / (double)displayRow);
		if(totalPage<endPage) {
			endPage = totalPage;
			next = false;
		}else {
			next = true;
		}
		if(beginPage==1)prev = false;
		else prev = true;
		startNum = (page-1)*displayRow+1;
		endNum = page*displayRow;
	}
}
