package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.vo.ReviewListVO;

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
    
    
    //영화 정보 조회
    @Override
    public List<MovieSimpleInfoDto> findAll(int movieNo) {
    	return sqlSession.selectList("movieSimpleInfo.findAll", movieNo);
    }
    
    // 영화에 달린 리뷰 조회
    public List<ReviewListVO> findReviewNoByMovie(int movieNo) {
        return sqlSession.selectList("reviewList.findReviewNoByMovie", movieNo);
    }
    
  //좋아요 개수 조회
  	@Override
  	public int findReviewLikeCount(int reviewNo) {
  		return sqlSession.selectOne("reviewList.findReviewLikeCount", reviewNo);
  	}
}