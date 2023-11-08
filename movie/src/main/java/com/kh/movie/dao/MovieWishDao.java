package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieWishDto;

public interface MovieWishDao {
	int sequence();
	void insert(MovieWishDto moviewishDto);
	boolean delete(int wishNo);
	List<MovieWishDto> selectList();
	MovieWishDto selectOne(int wishNo);
}
