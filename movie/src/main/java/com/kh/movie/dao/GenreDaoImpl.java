package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.GenreDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class GenreDaoImpl implements GenreDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("genre.sequence");
	}

	@Override
	public void insert(GenreDto genreDto) {
		sqlSession.insert("genre.add", genreDto);
	}

	@Override
	public boolean delete(int genreNo) {
		return sqlSession.delete("genre.delete", genreNo) > 0;
	}

	@Override
	public List<GenreDto> selectList() {
		return sqlSession.selectList("genre.findAll");
	}

	@Override
	public GenreDto selectOne(int genreNo) {
		return sqlSession.selectOne("genre.findByGenreNo",genreNo);
	}

	@Override
	public boolean edit(int genreNo, GenreDto genreDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("genreNo", genreNo);
		params.put("genreDto", genreDto);
		return sqlSession.update("genre.edit", params) > 0;
	}
	
	@Override
	public boolean editUnit(int genreNo, GenreDto genreDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("genreNo", genreNo);
		params.put("genreDto", genreDto);
		return sqlSession.update("genre.editUnit", params) > 0;
	}

}
