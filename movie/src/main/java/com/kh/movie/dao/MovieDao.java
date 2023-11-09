package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieDto;
import com.kh.movie.vo.AdminMovieListVO;

public interface MovieDao {
	int sequence();
	List<MovieDto> selectList();
	List<AdminMovieListVO> selectAdminMovieList();
	List<MovieDto> selectList(String movieName);
	void insert(MovieDto movieDto);
	boolean delete(int movieNo);
	boolean edit(int movieNo, MovieDto movieDto);
	boolean editUnit(int movieNo, MovieDto movieDto);
	void connectMainImage(int movieNo, int imageNo);
	int getCount();

}
