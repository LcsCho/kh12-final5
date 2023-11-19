package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.RatingDto;
import com.kh.movie.vo.MovieRatingAvgVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class RatingDaoImpl implements RatingDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("rating.sequence");
	}

	//등록
	@Override
	public void insert(RatingDto ratingDto) {
		sqlSession.insert("rating.add", ratingDto);
	}

	//삭제
	@Override
	public boolean delete(int ratingNo) {
		return sqlSession.delete("rating.delete", ratingNo) > 0;
	}

	@Override
	public List<RatingDto> selectList() {
		return sqlSession.selectList("rating.findAll");
	}
	
	@Override
	public RatingDto findByRatingNo(int ratingNo) {
		return sqlSession.selectOne("rating.findByRatingNo", ratingNo);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("rating.count");
	}

	//회원 아이디로 평점 번호 조회
	@Override
	public int findRatingNoByMemberId(String memberId) {
		return sqlSession.selectOne("rating.findRatingNoByMemberId", memberId);
	}
	
	@Override
	public MovieRatingAvgVO getRatingAvg(int movieNo) {
		return sqlSession.selectOne("rating.avgByMovieNo", movieNo);
	}
}
