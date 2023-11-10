package com.kh.movie.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MovieActorRole {
	private int movieNo, actorNo;
	private String actorRole;
	
	@JsonIgnore
	public boolean isEmpty() {
		return actorNo == 0 && movieNo == 0 && actorRole == null;
	}
}
