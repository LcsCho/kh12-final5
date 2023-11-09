package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.PreferGenreDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PreferGenreDaoImpl implements PreferGenreDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("preferGenre.sequence");
	}

	@Override
	public void insert(PreferGenreDto preferGenreDto) {
		sqlSession.insert("preferGenre.add", preferGenreDto);
	}

	@Override
	public boolean delete(String memberNickname, String genreName) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberNickname", memberNickname);
		params.put("genreName", genreName);
		return sqlSession.delete("preferGenre.delete", params) > 0;
	}

	@Override
	public List<PreferGenreDto> selectList() {
		return sqlSession.selectList("preferGenre.findAll");
	}

	@Override
	public List<PreferGenreDto> selectListByMemberNickname(String memberNickname) {
		return sqlSession.selectList("preferGenre.findByMemberNickname", memberNickname);
	}
	
}
