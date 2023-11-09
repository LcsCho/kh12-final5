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
    public List<ReviewListVO> findByDateDesc(int movieNo) {
        return sqlSession.selectList("reviewList.findByDateDesc", movieNo);
    }
    
    //오래된순 조회
    @Override
    public List<ReviewListVO> findByDateAsc(int movieNo) {
        return sqlSession.selectList("reviewList.findByDateAsc", movieNo);
    }
    
    //좋아요순 조회
    @Override
    public List<ReviewListVO> findByLikeDesc(int movieNo) {
        return sqlSession.selectList("reviewList.findByLikeDesc", movieNo);
    }
    
    //평점높은순 조회
    @Override
    public List<ReviewListVO> findByRatingDesc(int movieNo) {
        return sqlSession.selectList("reviewList.findByRatingDesc", movieNo);
    }
    
    //평점낮은순 조회
    @Override
    public List<ReviewListVO> findByRatingAsc(int movieNo) {
        return sqlSession.selectList("reviewList.findByRatingAsc", movieNo);
    }
    
}