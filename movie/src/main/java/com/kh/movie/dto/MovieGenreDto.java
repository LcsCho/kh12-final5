package com.kh.movie.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieGenreDto {
//	private List<String> genreNames;
	private String genreName;
	
	// jsp 반환을 위한 복수개의 장르
	private String genreNames;
	private int movieNo;
	
	@JsonIgnore 
	@Schema(hidden = true)
	public boolean isEmpty() {
		return movieNo == 0 && genreName == null;
	}
}
