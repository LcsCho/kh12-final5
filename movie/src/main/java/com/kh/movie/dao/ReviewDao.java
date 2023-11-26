package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.dto.ReviewDto;
import com.kh.movie.vo.AdminReviewListVO;
import com.kh.movie.vo.PaginationVO;
import com.kh.movie.vo.ReviewListVO;

public interface ReviewDao {
	int sequence();
	void insert(ReviewDto reviewDto);
	boolean delete(int reviewNo);
	boolean edit(int reviewNo, String reviewContent);
	List<ReviewListVO> selectList(int movieNo);
	List<AdminReviewListVO> selectAdminReviewList();
	ReviewListVO findByReviewNo(int reviewNo,int movieNo); //리뷰 상세 조회
	
	List<ReviewListVO> findByDateDesc(int movieNo);//최신순
	List<ReviewListVO> findByDateAsc(int movieNo);//오래된순
	List<ReviewListVO> findByLikeDesc(int movieNo);//좋아요순
	List<ReviewListVO> findByRatingDesc(int movieNo);//평점높은순
	List<ReviewListVO> findByRatingAsc(int movieNo);//평점낮은순
	
	List<MovieSimpleInfoDto> findAll(int movieNo);//영화 정보 조회
	List<ReviewListVO> findReviewNoByMovie(int movieNo);//영화에 달린 리뷰 조회
	int findReviewLikeCount(int reviewNo);
	
	String findMemberIdByReviewNo(int reviewNo);//리뷰 번호로 회원 아이디 검색
	int countList(PaginationVO paginationVO);//리뷰 갯수
	int reviewCountByMemberId(String memberId);
	
	//리액트 페이지네이션
	int reviewCount();
	List<AdminReviewListVO> adminReviewListByPage(int currentPage, int pageSize);
	List<ReviewListVO> getListByMemberNickname(String memberNickname);
}
