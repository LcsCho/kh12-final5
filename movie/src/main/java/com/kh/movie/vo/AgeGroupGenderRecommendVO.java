package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AgeGroupGenderRecommendVO {
	private String memberGender;
	private float ratingAvg;
	private int movieNo;
	private String movieName;
	private int ratingScoreCount;
	private int ageGroup;
}
