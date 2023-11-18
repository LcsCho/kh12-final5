package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AgeGroupRecommendVO {
	private int ageGroup;
	private float ratingAvg;
	private int movieNo;
	private String movieName;
	private int ratingScoreCount;
}
