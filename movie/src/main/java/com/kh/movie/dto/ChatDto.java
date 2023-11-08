package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ChatDto {
	private int chatNo;
	private String chatSender, chatContent, chatSenderLevel;
	private Date chatTime;
}
