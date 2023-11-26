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
import com.kh.movie.vo.PaginationVO;
import com.kh.movie.vo.ReviewListVO;

@Repository
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("review.sequence");
	}

	//리뷰 등록
	@Override
	public void insert(ReviewDto reviewDto) {
		sqlSession.insert("review.save", reviewDto);
	}
	
	//리뷰 삭제
	@Override
	public boolean delete(int reviewNo) {
		return sqlSession.delete("review.deleteByReviewNo", reviewNo) > 0;
	}
	//리뷰에 달린 평점 삭제

	//리뷰 수정
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
		return sqlSession.selectList("review.adminReviewList");
	}
	
	//리뷰 상세 조회
	@Override
	public ReviewListVO findByReviewNo(int reviewNo,int movieNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("reviewNo", reviewNo);
		params.put("movieNo",movieNo);
		return sqlSession.selectOne("review.findByReviewNo", params);
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
    
    // 영화에 달린 리뷰 조회
    public List<ReviewListVO> findReviewNoByMovie(int movieNo) {
        return sqlSession.selectList("review.findReviewNoByMovie", movieNo);
    }
    
  //좋아요 개수 조회
  	@Override
  	public int findReviewLikeCount(int reviewNo) {
  		return sqlSession.selectOne("review.findReviewLikeCount", reviewNo);
  	}
  	
  	//리뷰 번호로 회원 아이디 검색
  	@Override
  	public String findMemberIdByReviewNo(int reviewNo) {
  		return sqlSession.selectOne("review.findMemberIdByReviewNo", reviewNo);
  	}
  	
  	//리뷰 갯수
  	@Override
  	public int countList(PaginationVO paginationVO) {
  		return sqlSession.selectOne("review.countList");
  	}
  	
  	@Override
  	public int reviewCountByMemberId(String memberId) {
  		return sqlSession.selectOne("review.reviewCountByMemberId", memberId);
  	}
  	
  	@Override
  	public int reviewCount() {
  		return sqlSession.selectOne("review.countList");
  	}
  	
  	@Override
  	public List<AdminReviewListVO> adminReviewListByPage(int currentPage, int pageSize) {
  		int end = currentPage * pageSize;
		int begin = end - (pageSize-1);
		Map params = Map.of("begin", begin, "end", end);
  		return sqlSession.selectList("review.adminReviewListByPage", params);
  	}

}
