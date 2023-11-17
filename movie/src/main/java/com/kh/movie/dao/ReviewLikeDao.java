package com.kh.movie.dao;

import java.util.Map;

import com.kh.movie.dto.ReviewLikeDto;

public interface ReviewLikeDao {
	void insert(ReviewLikeDto reviewLikeDto);//좋아요 등록
	void delete(ReviewLikeDto reviewLikeDto);//좋아요 삭제
	
	String findReviewLike(int reivewNo, String memberNickname);//좋아요 체크 여부
}
