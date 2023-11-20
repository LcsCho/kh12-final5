package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MVCTop10RecommendVO {
	private int movieNo;
	private String movieName;
	private float ratingAvg;
	private int ratingScoreCount;
}
