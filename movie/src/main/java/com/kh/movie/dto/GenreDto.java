package com.kh.movie.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class GenreDto {
	private int genreNo;
	private String genreName;
	
	@JsonIgnore 
	@Schema(hidden = true)
	public boolean isEmpty() {
		return genreNo == 0 && genreName == null;
	}
}
