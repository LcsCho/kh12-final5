package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class RatingDto {
	private int ratingNo, movieNo;
	private String memberId;
	private Date ratingDate;
	private float ratingScore;
}
