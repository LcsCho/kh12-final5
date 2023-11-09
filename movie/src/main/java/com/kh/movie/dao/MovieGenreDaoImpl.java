package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieGenreDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieGenreDaoImpl implements MovieGenreDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("movieGenre.sequence");
	}

	@Override
	public void insert(MovieGenreDto movieGenreDto) {
		sqlSession.insert("movieGenre.add", movieGenreDto);
	}

	@Override
	public boolean delete(int movieNo, String genreName) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("genreName", genreName);
		return sqlSession.delete("movieGenre.delete", params) > 0;
	}

	@Override
	public List<MovieGenreDto> selectList() {
		return sqlSession.selectList("movieGenre.findAll");
	}
	
	@Override
	public List<MovieGenreDto> selectListByMovieNo(int movieNo) {
		return sqlSession.selectList("movieGenre.findByMovieNo", movieNo);
	}

	@Override
	public boolean editUnit(int movieNo, String genreName, MovieGenreDto movieGenreDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("genreName", genreName);
		params.put("movieGenreDto", movieGenreDto);
		return sqlSession.update("movieGenre.editUnit", params) > 0;
	}
}
