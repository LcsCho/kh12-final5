package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewDetailVO {
	private int movieNo;
	private int reviewNo;
	private String member_nickname;
	private int reviewLikeCount, reviewReplyCount;
	private float ratingScore;
}
