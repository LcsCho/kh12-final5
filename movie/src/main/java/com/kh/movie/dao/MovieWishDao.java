package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieWishDto;
import com.kh.movie.vo.MovieWishListVO;

public interface MovieWishDao {
	int sequence();
	void insert(MovieWishDto moviewishDto);
	boolean delete(int wishNo);
	List<MovieWishDto> selectList();
	List<MovieWishListVO> selectList(String memberNickname);
	MovieWishDto selectOne(int wishNo);
	boolean check(int wishNo);
	int count(int wishNo);
}
