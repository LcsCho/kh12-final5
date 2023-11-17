package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.RatingDto;

public interface RatingDao {
	int getCount();
	
	int sequence();
	void insert (RatingDto ratingDto);
	boolean delete(int ratingNo);
	List<RatingDto> selectList();
	RatingDto findByRatingNo(int ratingNo);
}
