package com.kh.movie.dao;

import java.util.List;

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
	public List<GenreDto> selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(GenreDto genreDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int genreNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public GenreDto findByGenreNo(int genreNo) {
		// TODO Auto-generated method stub
		return null;
	}
}
