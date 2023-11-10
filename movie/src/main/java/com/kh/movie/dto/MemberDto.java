package com.kh.movie.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberDto {
	
	private String memberId, memberPw, memberNickname, memberBirth;
	private String memberLevel, memberGender, memberContact;
	private Date memberJoin, memberLastLogin, memberLastUpdate;
	
	@JsonIgnore
	public boolean isEmpty() {
		return memberId == null && memberLevel == null;
	}
	
}
