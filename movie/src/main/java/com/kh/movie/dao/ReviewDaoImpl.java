package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.dto.ReviewDto;
import com.kh.movie.vo.AdminReviewListVO;
import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("review.sequence");
	}

	@Override
	public void insert(ReviewDto reviewDto) {
		sqlSession.insert("review.save", reviewDto);
	}

	@Override
	public boolean delete(int reviewNo) {
		return sqlSession.delete("review.deleteByReviewNo", reviewNo) > 0;
	}

	@Override
	public boolean edit(int reviewNo, String reviewContent) {
		Map<String, Object> params = new HashMap<>();
		params.put("reviewNo", reviewNo);
		params.put("reviewContent", reviewContent);
		return sqlSession.update("review.edit",params) > 0;
	}

	@Override
	public List<ReviewDto> selectList(int movieNo) {
		return sqlSession.selectList("review.findAllByMovieNo", movieNo);
	}

	@Override
	public List<AdminReviewListVO> selectAdminReviewList() {
		return sqlSession.selectList("reviewList.adminReviewList");
	}
	
	//리뷰 상세 조회
	@Override
	public List<ReviewListVO> findByReviewNo(int reviewNo) {
		return sqlSession.selectList("review.findByReviewNo", reviewNo);
	}
	
	//최신순 조회
    @Override
    public List<ReviewListVO> findByDateDesc(int movieNo) {
        return sqlSession.selectList("review.findByDateDesc", movieNo);
    }
    
    //오래된순 조회
    @Override
    public List<ReviewListVO> findByDateAsc(int movieNo) {
        return sqlSession.selectList("review.findByDateAsc", movieNo);
    }
    
    //좋아요순 조회
    @Override
    public List<ReviewListVO> findByLikeDesc(int movieNo) {
        return sqlSession.selectList("review.findByLikeDesc", movieNo);
    }
    
    //평점높은순 조회
    @Override
    public List<ReviewListVO> findByRatingDesc(int movieNo) {
        return sqlSession.selectList("review.findByRatingDesc", movieNo);
    }
    
    //평점낮은순 조회
    @Override
    public List<ReviewListVO> findByRatingAsc(int movieNo) {
        return sqlSession.selectList("review.findByRatingAsc", movieNo);
    }
    
    //영화 정보 조회
    @Override
    public List<MovieSimpleInfoDto> findAll(int movieNo) {
    	return sqlSession.selectList("movieSimpleInfo.findAll", movieNo);
    }
    
    //영화에 달린 리뷰 조희
    public int findReviewNoByMovie(int movieNo) {
    	return sqlSession.selectOne("review.findReviewNoByMovie", movieNo);
    }
}
