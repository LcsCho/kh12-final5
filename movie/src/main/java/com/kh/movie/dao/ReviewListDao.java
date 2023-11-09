package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.vo.ReviewListVO;

public interface ReviewListDao {

	List<ReviewListVO> complexSearch(String sortType);
}
