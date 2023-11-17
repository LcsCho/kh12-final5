package com.kh.movie.dao;

import com.kh.movie.dto.ReviewLikeDto;

public interface ReviewLikeDao {
	void insert(int reviewNo, String memberNickname);//좋아요 등록
	void delete(int reviewNo, String memberNickname);//좋아요 삭제
	
	String findReviewLike(int reviewNo, String memberNickname);//좋아요 체크 여부
}
