package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.vo.ReviewListVO;

public interface ReviewListDao {
	List<ReviewListVO> findByDateDesc(int movieNo);//최신순
	List<ReviewListVO> findByDateAsc(int movieNo);//오래된순
	List<ReviewListVO> findByLikeDesc(int movieNo);//좋아요순
	List<ReviewListVO> findByRatingDesc(int movieNo);//평점높은순
	List<ReviewListVO> findByRatingAsc(int movieNo);//평점낮은순
	
	List<MovieSimpleInfoDto> findAll(int movieNo);//영화 정보 조회
	List<ReviewListVO> findReviewNoByMovie(int movieNo);//영화에 달린 리뷰 조회
	int findReviewLikeCount(int reviewNo);//좋아요 개수 조회
}
