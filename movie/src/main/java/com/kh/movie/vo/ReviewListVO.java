package com.kh.movie.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewListVO {
	private int reviewNo;
	private String reviewContent;
	private int reviewLikeCount;
	private Date reviewDate;
	private String memberNickname;
	private int imageNo;
	private int movieNo;
	private float ratingScore;
	private List<String> orderList;
}
