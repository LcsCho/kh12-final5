package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewListDto {
	private int reviewNo;
	private String reviewContent;
	private int reviewLikeCount;
	private Date reviewDate;
	private String memberNickname;
	private int imageNo;
	private int movieNo;
	private float ratingScore;
}
