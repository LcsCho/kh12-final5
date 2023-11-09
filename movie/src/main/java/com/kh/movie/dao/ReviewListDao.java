package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.vo.ReviewListVO;

public interface ReviewListDao {
	List<ReviewListVO> findByDateDesc();//최신순
	List<ReviewListVO> findByDateAsc();//오래된순
	List<ReviewListVO> findByLikeDesc();//좋아요순
	List<ReviewListVO> findByRatingDesc();//평점높은순
	List<ReviewListVO> findByRatingAsc();//평점낮은순
}
