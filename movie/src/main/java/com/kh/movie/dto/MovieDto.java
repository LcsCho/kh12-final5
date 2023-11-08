package com.kh.movie.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieDto {
	private int movieNo;
	private String movieName, movieDirector;
	private Date movieReleaseDate;
	private int movieTime;
	private String movieLevel, movieNation, movieContent;
	
	@JsonIgnore
	public boolean isEmpty() {
		return movieNo == 0 && movieName == null && movieReleaseDate == null
				&& movieDirector == null && movieTime == 0
				&& movieLevel == null && movieNation == null
				&& movieContent == null;
	}
}
