package com.kh.movie.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieDto {
	private int movieNo;
	private String movieName, movieReleaseDate, movieDirector;
	private int movieTime;
	private String movieLevel, movieNation, movieContent;
}
