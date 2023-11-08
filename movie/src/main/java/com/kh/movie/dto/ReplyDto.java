package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReplyDto {
	private int replyNo, reviewNo;
	private String memberNickname, replyContent;
	private Date replyDate;
}
