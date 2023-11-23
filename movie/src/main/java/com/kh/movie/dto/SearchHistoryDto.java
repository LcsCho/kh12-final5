package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SearchHistoryDto {
	private int searchHistoryNo;
	private int searchHistoryKeywordCount;
	private Date searchHistoryTime;
	private String searchHistoryKeyword;
	private String searchHistoryMemberId;
}
