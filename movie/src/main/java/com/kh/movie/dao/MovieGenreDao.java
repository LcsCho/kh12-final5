package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieGenreDto;

public interface MovieGenreDao {
	int sequence();
	void insert(MovieGenreDto movieGenreDto);
	boolean delete(int movieNo, String genreName);
	List<MovieGenreDto> selectList();
	List<MovieGenreDto> selectListByMovieNo(int movieNo);
	boolean editUnit(int movieNo, String genreName, MovieGenreDto movieGenreDto);
}
