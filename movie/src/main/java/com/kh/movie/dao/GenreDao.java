package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.GenreDto;

public interface GenreDao {
	int sequence();
	void insert(GenreDto genreDto);
	boolean delete(int genreNo);
	List<GenreDto> selectList();
	GenreDto selectOne(int genreNo);
	boolean edit(int genreNo, GenreDto genreDto);
	boolean editUnit(int genreNo, GenreDto genreDto);
}
