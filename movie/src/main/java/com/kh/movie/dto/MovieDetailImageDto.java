package com.kh.movie.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieDetailImageDto {
	private int imageNo, movieNo;
}
