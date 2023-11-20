package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MovieRatingAvgVO {
	private int movieNo;
	private float ratingAvg;
	private String movieName;
}
