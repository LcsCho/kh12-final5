package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ReviewDto;

public interface ReviewDao {
	int sequence();
	void insert(ReviewDto reviewDto);
	boolean delete(int reviewNo);
	boolean edit(int reviewNo, String reviewContent);
	List<ReviewDto> selectList(int movieNo);
}
