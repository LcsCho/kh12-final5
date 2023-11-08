package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AlgorithmVO {
	private String movieName, memberNickname, memberGender;
	private float ratingScore;
	private int wishNo, memberAge;
}
