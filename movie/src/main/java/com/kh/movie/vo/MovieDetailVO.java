package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MovieDetailVO {
	private int movieNo, mainImgNo, detailImgNo;
}
