package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AdminMovieListVO {
	private int movieNo;
	private String movieName, movieDirector, movieNation;
	private String genreName, actorName;
}
