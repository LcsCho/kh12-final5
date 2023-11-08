package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.GenreDto;

public interface GenreDao {
	List<GenreDto> selectList();
	void insert(GenreDto genreDto);
	void delete(int genreNo);
	GenreDto findByGenreNo(int genreNo);
}
