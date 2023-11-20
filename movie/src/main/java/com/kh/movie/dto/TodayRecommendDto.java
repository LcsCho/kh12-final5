package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TodayRecommendDto {
	private int movieNo;
	private String movieName;
	private Date movieReleaseDate;
	private String movieNation;
	private float ratingAvg;
	private int imageNo;
	private int ratingCount;
}
