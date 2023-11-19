package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.RatingDto;

public interface RatingDao {
	int getCount();
	
	int sequence();
	void insert (RatingDto ratingDto);//등록
	List<RatingDto> selectList();
	RatingDto findByRatingNo(int ratingNo);
	
	int findRatingNoByMemberId(String memberId);//회원 아이디로 평점 번호 검색
	boolean delete(int ratingNo);//삭제
}
