package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieWishDto;
import com.kh.movie.vo.MovieWishListVO;

public interface MovieWishDao {
	int sequence();
	void insert(MovieWishDto movieWishDto);
	boolean delete(MovieWishDto movieWishDto);
	List<MovieWishDto> selectList();
	List<MovieWishListVO> selectList(String memberNickname);
	MovieWishDto selectOne(int wishNo);
	boolean check(MovieWishDto movieWishDto);
	int count(String memberId);
}
