package com.kh.movie.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.RecommendDao;
import com.kh.movie.dao.SearchDao;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.dto.RatingDto;
import com.kh.movie.dto.TodayRecommendDto;
import com.kh.movie.vo.AgeGroupGenderRecommendVO;
import com.kh.movie.vo.AgeGroupRecommendVO;
import com.kh.movie.vo.GenderRecommendVO;
import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;
import com.kh.movie.vo.MemberAgeGroupRecommendVO;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieVO;
import com.kh.movie.vo.PreferGenreByMemberRecommendVO;
import com.kh.movie.vo.WishMovieRecommendVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private RatingDao ratingDao;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private RecommendDao recommendDao;
	

	@RequestMapping("/")
	public String main(Model model, HttpSession session, @RequestParam(required = false) String movieName) {
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		String memberId = (String) session.getAttribute("name");
		model.addAttribute("memberId",memberId);
		
		// 영화 검색 구문
		boolean isSearch = movieName != null;
		if (isSearch) {
			List<MovieListVO> movieList = movieDao.searchMovieList(movieName);
			model.addAttribute("movieName", movieName);
			model.addAttribute("movieList", movieList);
//			log.debug("movieList = {}", movieList);
		}
//		log.debug("movieList = {}", movieList);

		
		
		// 여기서부터 영화 추천 코드 - 건들지 말 것!

		// MVC Top 10 영화 추천
		List<MVCTop10RecommendVO> mvcTop10RecommendVO = recommendDao.getMVCTop10();
//		log.debug("mvcTop10RecommendVo = {}", mvcTop10RecommendVO);
		List<MovieListVO> mvcTop10RecommendList = new ArrayList<>(); // 리스트 초기화

		for (MVCTop10RecommendVO mvcTop10Recommend : mvcTop10RecommendVO) {
			int movieNo = mvcTop10Recommend.getMovieNo();
//			log.debug("movieNo = {}", movieNo);
			MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);
//		    log.debug("movieVO = {}", movieVO);

			// MovieListVO 객체 생성
			MovieListVO mvcTop10RecommendMovie = new MovieListVO();
			BeanUtils.copyProperties(movieVO, mvcTop10RecommendMovie);

			// 리스트에 추가
			mvcTop10RecommendList.add(mvcTop10RecommendMovie);
		}
//		log.debug("mvcTop10RecommendList = {}", mvcTop10RecommendList);
		model.addAttribute("mvcTop10RecommendList", mvcTop10RecommendList);

		////////////////////////////////////////////////////////////////////

		// MVC 평론가 Top 10 영화 추천
		List<MVCCriticTop10RecommendVO> mvcCriticTop10RecommendVO = recommendDao.getMVCCriticTop10();
		List<MovieListVO> mvcCriticTop10RecommendList = new ArrayList<>(); // 리스트 초기화

		for (MVCCriticTop10RecommendVO mvcCriticTop10Recommend : mvcCriticTop10RecommendVO) {
			int movieNo = mvcCriticTop10Recommend.getMovieNo();
			MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

			// MovieListVO 객체 생성
			MovieListVO mvcCriticTop10RecommendMovie = new MovieListVO();
			BeanUtils.copyProperties(movieVO, mvcCriticTop10RecommendMovie);

			// 리스트에 추가
			mvcCriticTop10RecommendList.add(mvcCriticTop10RecommendMovie);
		}
//		log.debug("mvcCriticTop10RecommendList = {}", mvcCriticTop10RecommendList);
		model.addAttribute("mvcCriticTop10RecommendList", mvcCriticTop10RecommendList);

		///////////////////////////////////////////////

		// 오늘의 영화 추천
		List<TodayRecommendDto> todayMovieList = recommendDao.getRandomList();
		model.addAttribute("todayMovieList", todayMovieList);

		/////////////////////////////

		// 계절별 영화 추천
		// 현재 날짜
		LocalDate now = LocalDate.now();
		
		// 오늘 날짜의 월을 가져오기 (1월부터 12월까지의 값)
		int currentMonth = now.getMonthValue();
		model.addAttribute("currentMonth", currentMonth);
		List<MovieListVO> seasonMovieList = new ArrayList<>(); // 리스트 초기화
		List<Integer> movieListBySeason = new ArrayList<>();
		if (currentMonth >= 3 && currentMonth <= 5) {
		    // 봄
		    movieListBySeason = recommendDao.getSpringMovies();
		} else if (currentMonth >= 6 && currentMonth <= 8) {
		    // 여름
		    movieListBySeason = recommendDao.getSummerMovies();
		} else if (currentMonth >= 9 && currentMonth <= 11) {
		    // 가을
		    movieListBySeason = recommendDao.getFallMovies();
		} else {
		    // 겨울 (12월, 1월, 2월)
		    movieListBySeason = recommendDao.getWinterMovies();
		}

		for (Integer movieNo : movieListBySeason) {
			MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);
			// MovieListVO 객체 생성
			MovieListVO seasonMovie = new MovieListVO();
			BeanUtils.copyProperties(movieVO, seasonMovie);

			// 리스트에 추가
			seasonMovieList.add(seasonMovie);
		}
		model.addAttribute("seasonMovieList", seasonMovieList);

		// 회원 로그인 했을 때 출력
		if (session.getAttribute("name") != null) {
			// 세션에서 사용자 아이디를 가져와서 memberId에 저장
//			String memberId = (String) session.getAttribute("name");

//			log.debug("memberId = {}", memberId);
			MemberDto memberDto = memberDao.selectOne(memberId);
			String memberNickname = memberDto.getMemberNickname();
			String memberGender = memberDto.getMemberGender();
			String memberBirth = memberDto.getMemberBirth();

			// 회원의 연령대 계산
			MemberAgeGroupRecommendVO memberGroupAgeVO = memberDao.getAgeGroup(memberId);
			int ageGroup = memberGroupAgeVO.getAgeGroup();

			// 회원의 닉네임, 성별, 연령을 jsp로 보내기
			model.addAttribute("memberNickname", memberNickname);
			model.addAttribute("memberGender", memberGender);
			model.addAttribute("ageGroup", ageGroup);

			// 회원별 선호 장르 추천
			List<PreferGenreByMemberRecommendVO> preferGenreByMemberRecommendVO = recommendDao
					.getPreferGenreByMember(memberNickname);
			List<MovieListVO> preferGenreByMemberRecommendList = new ArrayList<>();

			for (PreferGenreByMemberRecommendVO preferGenreByMemberRecommend : preferGenreByMemberRecommendVO) {
				int movieNo = preferGenreByMemberRecommend.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

				// MovieListVO 객체 생성
				MovieListVO preferGenreByMemberRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, preferGenreByMemberRecommendMovie);

				// 리스트에 추가
				preferGenreByMemberRecommendList.add(preferGenreByMemberRecommendMovie);

			}
//			log.debug("preferGenreByMemberRecommendList = {}", preferGenreByMemberRecommendList);
			model.addAttribute("preferGenreByMemberRecommendList", preferGenreByMemberRecommendList);
			///////////////////////////////////////

			// 회원 연령별 영화 추천
			List<AgeGroupRecommendVO> ageGroupRecommendVO = recommendDao.getAgeGroup(memberBirth);
			List<MovieListVO> ageGroupRecommendList = new ArrayList<>();
			for (AgeGroupRecommendVO ageGroupRecommend : ageGroupRecommendVO) {
				int movieNo = ageGroupRecommend.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);
				// MovieListVO 객체 생성
				MovieListVO ageGroupRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, ageGroupRecommendMovie);

				// 리스트에 추가
				ageGroupRecommendList.add(ageGroupRecommendMovie);
			}
//			log.debug("ageGroupRecommendList = {}", ageGroupRecommendList);
			model.addAttribute("ageGroupRecommendList", ageGroupRecommendList);
			/////////////////////////////////

			// 회원 성별별 영화 추천
			List<GenderRecommendVO> genderRecommendVO = recommendDao.getGender(memberGender);
			List<MovieListVO> genderRecommendList = new ArrayList<>();

			for (GenderRecommendVO genderRecommend : genderRecommendVO) {
				int movieNo = genderRecommend.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

				// MovieListVO 객체 생성
				MovieListVO genderRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, genderRecommendMovie);

				// 리스트에 추가
				genderRecommendList.add(genderRecommendMovie);

			}
//			log.debug("genderRecommendList = {}", genderRecommendList);
			model.addAttribute("genderRecommendList", genderRecommendList);

			/////////////////////////////////////

			// 회원 성별 + 연령별 영화 추천
			List<AgeGroupGenderRecommendVO> ageGroupGenderRecommendVO = recommendDao.getAgeGroupGender(memberGender,
					memberBirth);
			List<MovieListVO> ageGroupGenderRecommendList = new ArrayList<>();

//			log.debug("ageGroupGenderRecommendVO = {}", ageGroupGenderRecommendVO);
			for (AgeGroupGenderRecommendVO ageGroupGenderRecommend : ageGroupGenderRecommendVO) {
				int movieNo = ageGroupGenderRecommend.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

				// MovieListVO 객체 생성
				MovieListVO ageGroupGenderRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, ageGroupGenderRecommendMovie);

				// 리스트에 추가
				ageGroupGenderRecommendList.add(ageGroupGenderRecommendMovie);
			}
//			log.debug("ageGroupGenderRecommendList = {}", ageGroupGenderRecommendList);
			model.addAttribute("ageGroupGenderRecommendList", ageGroupGenderRecommendList);

			//////////////////////////////////////////

			// 회원 찜목록 영화 추천
			List<WishMovieRecommendVO> wishMovieRecommendVO = recommendDao.getWishMovie(memberId);
			List<MovieListVO> wishMovieList = new ArrayList<>();

			for (WishMovieRecommendVO wishMovieRecommend : wishMovieRecommendVO) {
				int movieNo = wishMovieRecommend.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

				// MovieListVO 객체 생성
				MovieListVO wishMovieRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, wishMovieRecommendMovie);

				// 리스트에 추가
				wishMovieList.add(wishMovieRecommendMovie);
			}
//			log.debug("wishMovieList = {}", wishMovieList);
			model.addAttribute("wishMovieList", wishMovieList);

			// 다시보기 추천
			List<RatingDto> ratingList = recommendDao.selectList(memberId);
			List<MovieListVO> againRecommendList = new ArrayList<>();

			for (RatingDto rating : ratingList) {
				int movieNo = rating.getMovieNo();
				MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);

				// MovieListVO 객체 생성
				MovieListVO againRecommendMovie = new MovieListVO();
				BeanUtils.copyProperties(movieVO, againRecommendMovie);

				// 리스트에 추가
				againRecommendList.add(againRecommendMovie);
			}
//			log.debug("againRecommendList = {}", againRecommendList);
			model.addAttribute("againRecommendList", againRecommendList);

			///////////////////////////////////////////////////

			// 영화 검색 구문
		}

		return "main";
	}

}
