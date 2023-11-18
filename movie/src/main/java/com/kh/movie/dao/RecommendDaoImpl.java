package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class RecommendDaoImpl implements RecommendDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MVCTop10RecommendVO> getMVCTop10() {
		return sqlSession.selectList("recommend.mvcTop10");
	}
	
	@Override
	public List<MVCCriticTop10RecommendVO> getMVCCriticTop10() {
		return sqlSession.selectList("recommend.mvcCriticTop10");
	}
}
