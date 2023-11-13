package com.kh.movie.vo;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.kh.movie.dto.ActorDto;

import lombok.Data;

//배우 등록을 위해 만든 VO
@Data
public class ActorUploadVO {

	private MultipartFile actorImage;
	
	private String actorName;
	
	@JsonIgnore
	public ActorDto getActorDto() {
		return ActorDto.builder()
				.actorName(actorName)
				.build();
	}
}
