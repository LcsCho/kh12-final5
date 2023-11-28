package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.RatingDto;
import com.kh.movie.vo.MovieRatingAvgVO;

public interface RatingDao {
	int getCount();
	
	int sequence();
	void insert (RatingDto ratingDto);//등록
	List<RatingDto> selectList();
	RatingDto findByRatingNo(int ratingNo);
	
	int findRatingNoByMemberId(String memberId);//회원 아이디로 평점 번호 검색
	boolean delete(int ratingNo);//삭제

	MovieRatingAvgVO getRatingAvg(int movieNo);

	boolean update(int ratingNo, float ratingScore);

	RatingDto findDtoByMovieNoAndMemberId(int movieNo, String memberId);
	
	int ratingCountByMemberId(String memberId);

	List<Integer> getRatingListByMemberId(String memberId);
	void deleteRating(String memberId, int movieNo);

	boolean existsByMovieNoAndMemberId(int movieNo, String memberId);
}
