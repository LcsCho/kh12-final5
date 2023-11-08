package com.kh.movie.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieMainImageDaoImpl implements MovieMainImageDao{

	@Autowired
	private SqlSession sqlSession;
}
