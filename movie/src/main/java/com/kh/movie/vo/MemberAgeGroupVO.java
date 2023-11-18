package com.kh.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberAgeGroupVO {
	private int ageGroup;
	private String memberBirth;
	private String memberId;
}
