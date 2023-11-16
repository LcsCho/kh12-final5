package com.kh.movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AdminReviewListVO {
	private int reviewNo;
	private String reviewContent;
	private Date reviewDate;
	private String memberNickname;
	private String movieName;
}
