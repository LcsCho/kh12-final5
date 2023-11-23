package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieWishDto;
import com.kh.movie.vo.MovieWishListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieWishDaoImpl implements MovieWishDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("movieWish.sequence");
	}

	@Override
	public void insert(MovieWishDto movieWishDto) {
		sqlSession.insert("movieWish.add", movieWishDto);
	}

	@Override
	public boolean delete(MovieWishDto movieWishDto) {
		return sqlSession.delete("movieWish.delete", movieWishDto) > 0;
	}

	@Override
	public List<MovieWishDto> selectList() {
		return sqlSession.selectList("movieWish.findAll");
	}
	
	@Override
	public List<MovieWishListVO> selectList(String memberNickname) {
		return sqlSession.selectList("movieWish.findAllList", memberNickname);
	}

	@Override
	public MovieWishDto selectOne(int wishNo) {
		return sqlSession.selectOne("movieWish.findByWishNo", wishNo);
	}
	
	@Override
	public boolean check(MovieWishDto movieWishDto) {
	    return sqlSession.selectOne("movieWish.findByWishNo", movieWishDto) != null;
	}
	
	@Override
	public int count(int wishNo) {
		return sqlSession.selectOne("movieWish.count", wishNo);
	}
	
	@Override
	public int wishCountByMemberId(String memberId) {
		return sqlSession.selectOne("movieWish.wishCountByMemberId", memberId);
	}
	
	@Override
	public int count(String memberId) {
		// TODO Auto-generated method stub
		return 0;
	}
}
