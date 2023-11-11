package com.kh.movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ActorViewVO {
	private int actorNo, imageNo;
	private long imageSize;
	private String actorName, imageName, imageType;
	private Date imageTime;
}
