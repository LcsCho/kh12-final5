package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.RatingDto;
import com.kh.movie.vo.AgeGroupGenderRecommendVO;
import com.kh.movie.vo.AgeGroupRecommendVO;
import com.kh.movie.vo.GenderRecommendVO;
import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;
import com.kh.movie.vo.PreferGenreByMemberRecommendVO;
import com.kh.movie.vo.WishMovieRecommendVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
// 영화 추천 관련 코드
public class RecommendDaoImpl implements RecommendDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	// MVC Top 10
	@Override
	public List<MVCTop10RecommendVO> getMVCTop10() {
		return sqlSession.selectList("recommend.mvcTop10");
	}
	
	// MVC 평론가 Top 10
	@Override
	public List<MVCCriticTop10RecommendVO> getMVCCriticTop10() {
		return sqlSession.selectList("recommend.mvcCriticTop10");
	}
	
	// 회원별 선호장르 추천
	@Override
	public List<PreferGenreByMemberRecommendVO> getPreferGenreByMember(String memberNickname) {
		return sqlSession.selectList("recommend.preferGenreByMember", memberNickname);
	}
	
	// 연령별 추천
	@Override
	public List<AgeGroupRecommendVO> getAgeGroup(String memberBirth) {
		return sqlSession.selectList("recommend.ageGroup", memberBirth);
	}
	
	// 성별별 추천
	@Override
	public List<GenderRecommendVO> getGender(String memberGender) {
		return sqlSession.selectList("recommend.gender", memberGender);
	}
	
	// 연령 + 성별별 추천
	@Override
	public List<AgeGroupGenderRecommendVO> getAgeGroupGender(String memberGender, String memberBirth) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberGender", memberGender);
	    params.put("memberBirth", memberBirth);
		return sqlSession.selectList("recommend.ageGroupGender", params);
	}
	
	// 찜목록 추천
	@Override
	public List<WishMovieRecommendVO> getWishMovie(String memberId) {
		return sqlSession.selectList("recommend.wishMovie", memberId);
	}
	
	@Override
	public List<RatingDto> selectList(String memberId) {
		return sqlSession.selectList("recommend.again", memberId);
	}
	
}
