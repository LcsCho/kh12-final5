package com.kh.movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieDetailVO {
	private int movieNo;
	private String movieName;
	private Date movieReleaseDate;
	private String movieNation;
	private int movieTime;
	private String movieLevel;
	private String movieContent;
	private String genreName;
	private float ratingAvg;
	private float ratingScore;
}
