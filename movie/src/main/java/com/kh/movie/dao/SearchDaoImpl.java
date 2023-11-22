package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.MovieListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class SearchDaoImpl implements SearchDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<String> searchMovieName(String keyword) {
		return sqlSession.selectList("movie.searchMovieName", keyword);
	}
}
