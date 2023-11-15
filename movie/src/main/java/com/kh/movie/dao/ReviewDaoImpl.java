package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ReviewDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("review.sequence");
	}

	@Override
	public void insert(ReviewDto reviewDto) {
		sqlSession.insert("review.save", reviewDto);
	}

	@Override
	public boolean delete(int reviewNo) {
		return sqlSession.delete("review.delete",reviewNo) > 0;
	}

	@Override
	public boolean edit(int reviewNo, String reviewContent) {
		Map<String, Object> params = new HashMap<>();
		params.put("reviewNo", reviewNo);
		params.put("reviewContent", reviewContent);
		return sqlSession.update("review.edit",params) > 0;
	}

	@Override
	public List<ReviewDto> selectList(int movieNo) {
		return sqlSession.selectList("review.findAllByMovieNo", movieNo);
	}
}
