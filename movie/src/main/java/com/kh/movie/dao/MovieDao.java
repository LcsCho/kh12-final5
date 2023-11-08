package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieDto;

public interface MovieDao {

	List<MovieDto> selectList();
	List<MovieDto> selectList(String movieName);
	void insert(MovieDto movieDto);
	boolean delete(int movieNo);
	boolean edit(int movieNo, MovieDto movieDto);
	boolean editUnit(int movieNo, MovieDto movieDto);
	void connectMainImage(int movieNo, int imageNo);

}
