package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewDto {
	private int reviewNo, movieNo, reviewLikeCount, reviewReplyCount;
	private String memberNickname, reviewContent;
	private Date reviewDate;
}
