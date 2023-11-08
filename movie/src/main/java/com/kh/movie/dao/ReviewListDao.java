package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.vo.ReviewListVO;

public interface ReviewListDao {
	List<ReviewListVO> findByDateDesc();
	List<ReviewListVO> findByDateAsc();
	List<ReviewListVO> findByLikeDesc();
	List<ReviewListVO> findByRatingDesc();
	List<ReviewListVO> findByRatingAesc();
}
