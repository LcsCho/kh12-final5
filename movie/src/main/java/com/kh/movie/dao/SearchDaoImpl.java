package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	@Override
	public void inputPopularKeyword(String keyword) {
		sqlSession.insert("popular.save", keyword);
	}
	
	@Override
	public List<String> showPopular() {
		return sqlSession.selectList("popular.show");
	}
	
	@Override
	public void inputRecentKeyword(String keyword, String memberId) {
		Map<Object, String> params = new HashMap<>();
		params.put("keyword", keyword);
		params.put("memberId", memberId);
		sqlSession.insert("recent.save", params);
	}
	
	@Override
	public List<String> showRecent(String memberId) {
		return sqlSession.selectList("recent.show", memberId);
	}
	
	@Override
	public void deleteAll(String memberId) {
		sqlSession.delete("recent.deleteAll", memberId);
	}
	
	@Override
	public void deleteEach(String memberId, String keyword) {
		Map<Object, String> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("keyword", keyword);
		sqlSession.delete("recent.deleteEach", params);
	}
}
