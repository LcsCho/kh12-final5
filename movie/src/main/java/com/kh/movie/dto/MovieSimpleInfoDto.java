package com.kh.movie.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MovieSimpleInfoDto {
	private int movieNo, movieTime, ImageNo;
	private String movieName, movieReleaseYear, genreName, movieNation, movieLevel;
}
