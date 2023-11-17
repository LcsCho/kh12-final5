package com.kh.movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieListVO {
	private int movieNo;
	private String movieName;
	private Date movieReleaseDate;
	private String movieNation;
	private float ratingAvg;
	private int imageNo;
}
