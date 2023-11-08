package com.kh.movie.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ActorDto {
	private int actorNo, movieNo;
	private String actorName, actorRole;
	
	@JsonIgnore
	public boolean isEmpty() {
		return actorNo == 0 && actorName == null
				&& actorRole == null;
	}
}
