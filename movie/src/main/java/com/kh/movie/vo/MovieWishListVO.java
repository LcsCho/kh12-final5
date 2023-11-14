package com.kh.movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MovieWishListVO {
	private int wishNo;
	private String movieName, memberNickname;
	private Date wishDate;
}
