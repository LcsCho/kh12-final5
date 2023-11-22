package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.SearchHistoryDto;

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
	public void inputKeyword(String keyword) {
		sqlSession.insert("search.savePopular", keyword);
	}
	
	@Override
	public List<SearchHistoryDto> showPopular() {
		return sqlSession.selectList("search.showPopular");
	}
	
	@Override
	public void delete() {
		sqlSession.delete("search.delete");
	}
	
	@Override
	public void inputKeywordByMember(String keyword, String memberId) {
		Map<Object, String> params = new HashMap<>();
		params.put("keyword", keyword);
		params.put("memberId", memberId);
		sqlSession.insert("search.saveRecent", params);
	}
	
	@Override
	public List<SearchHistoryDto> showRecent(String memberId) {
		return sqlSession.selectList("search.showRecent", memberId);
	}
}
