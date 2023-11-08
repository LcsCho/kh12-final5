package com.kh.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ImageDto {
	private int imageNo; 
	private long imageSize;
	private String imageName, imageType;
	private Date imageTime;
}
