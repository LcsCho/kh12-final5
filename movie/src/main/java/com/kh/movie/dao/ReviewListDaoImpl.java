package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewListDaoImpl implements ReviewListDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
    public List<ReviewListVO> complexSearch(String sortType) {
        return sqlSession.selectList("reviewList.complexSearch", sortType);
    }
	
}
