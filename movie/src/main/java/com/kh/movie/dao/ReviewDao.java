package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ReviewDto;
import com.kh.movie.vo.AdminReviewListVO;

public interface ReviewDao {
	int sequence();
	void insert(ReviewDto reviewDto);
	boolean delete(int reviewNo);
	boolean edit(int reviewNo, String reviewContent);
	List<ReviewDto> selectList(int movieNo);
	List<AdminReviewListVO> selectAdminReviewList();
}
