package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ReplyDto;
import com.kh.movie.vo.ReviewListVO;

public interface ReviewDetailDao {
	List<ReviewListVO> findByReviewNo(int reviewNo);//리뷰 상세 조회
}
