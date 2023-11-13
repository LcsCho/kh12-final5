package com.kh.movie.dao;

import com.kh.movie.dto.ReviewLikeDto;

public interface ReviewLikeDao {
	boolean check(ReviewLikeDto reviewLikeDto);
	int count(int reviewNo);
	void insert(ReviewLikeDto reviewLikeDto);
	void delete(ReviewLikeDto reviewLikeDto);
}
