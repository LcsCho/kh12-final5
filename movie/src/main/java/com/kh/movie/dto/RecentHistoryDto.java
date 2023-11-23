package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RecentHistoryDto {
	private int recentHistoryNo;
	private Date recentHistoryTime;
	private String recentHistoryKeyword, recentHistoryId;
}
