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

    //최신순 조회
    @Override
    public List<ReviewListVO> findByDateDesc() {
        return sqlSession.selectList("reviewList.findByDateDesc");
    }
    
    //오래된순 조회
    @Override
    public List<ReviewListVO> findByDateAsc() {
        return sqlSession.selectList("reviewList.findByDateAsc");
    }
    
    //좋아요순 조회
    @Override
    public List<ReviewListVO> findByLikeDesc() {
        return sqlSession.selectList("reviewList.findByLikeDesc");
    }
    
    //평점높은순 조회
    @Override
    public List<ReviewListVO> findByRatingDesc() {
        return sqlSession.selectList("reviewList.findByRatingDesc");
    }
    
    //평점낮은순 조회
    @Override
    public List<ReviewListVO> findByRatingAsc() {
        return sqlSession.selectList("reviewList.findByRatingAsc");
    }
}