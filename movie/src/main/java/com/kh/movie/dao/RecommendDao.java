package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MovieGenreDto;
import com.kh.movie.dto.RatingDto;
import com.kh.movie.dto.TodayRecommendDto;
import com.kh.movie.vo.AgeGroupGenderRecommendVO;
import com.kh.movie.vo.AgeGroupRecommendVO;
import com.kh.movie.vo.GenderRecommendVO;
import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;
import com.kh.movie.vo.PreferGenreByMemberRecommendVO;
import com.kh.movie.vo.TodayMovieListVO;
import com.kh.movie.vo.WishMovieRecommendVO;

public interface RecommendDao {

	// MVC Top 10
	List<MVCTop10RecommendVO> getMVCTop10();
	// MVC 평론가 Top 10
	List<MVCCriticTop10RecommendVO> getMVCCriticTop10();
	// 연령별 추천
	List<AgeGroupRecommendVO> getAgeGroup(String memberBirth);
	// 성별별 추천
	List<GenderRecommendVO> getGender(String memberGender);
	// 연령 + 성별 추천
	List<AgeGroupGenderRecommendVO> getAgeGroupGender(String memberGender, String memberBirth);
	// 회원별 선호 장르 추천
	List<PreferGenreByMemberRecommendVO> getPreferGenreByMember(String memberNickname);
	// 찜목록 추천
	List<WishMovieRecommendVO> getWishMovie(String memberId);
	// 다시보기 추천
	List<RatingDto> selectList(String memberId);
	// 오늘의 영화 추천
	List<TodayMovieListVO> getTodayList();
	void deleteRandom();
	void saveRandom(TodayRecommendDto todayRecommendDto);
	List<TodayRecommendDto> getRandomList();
	// 계절별 영화 추천
	List<Integer> getSpringMovies();
	List<Integer> getSummerMovies();
	List<Integer> getFallMovies();
	List<Integer> getWinterMovies();

}
