package com.kh.movie.vo;

import lombok.Data;

@Data
public class PaginationVO {
	private int page = 1;//현재 페이지 번호
	private int size = 15;//보여줄 게시글 수(기본값 10)
	private int count;//전체 글 수
	private int navigatorSize = 10;//하단 네빅이터 표시 개수(기본값 10)
	
	//페이지의 시작
	public int getBegin() {
		return (page-1)/navigatorSize*navigatorSize+1;
	}
	
	//페이지의 끝
	public int getEnd() {
		int end = getBegin()+navigatorSize-1;
		return Math.min(getPageCount(), end);
	}
	
	//첫 페이지인지 체크
	public boolean isFirst() {
		return getBegin()==1;
	}
	
	//이전 페이지 가져오기
	public String getprevQueryString() {
		return "page="+(getBegin()-1);
	}
	
	//페이지 갯수 가져오기
	public int getPageCount() {
		return (count-1)/size+1;
	}
	
	//마지막 페이지인지 체크
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	
	//다음 페이지 가져오기
	public String getNextQueryString() {
		return "page="+(getEnd()+1);
	}
	
	//현재 페이지 가져오기
	public String getQueryString(int page) {
		return "page="+page;
	}
	
	//첫 번째 줄
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	
	//마지막 번째 줄
	public int getFinishRow() {
		return page * size;
	}
}
