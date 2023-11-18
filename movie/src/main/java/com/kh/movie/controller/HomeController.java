package com.kh.movie.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.RecommendDao;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.vo.AgeGroupRecommendVO;
import com.kh.movie.vo.GenderRecommendVO;
import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieVO;
import com.kh.movie.vo.PreferGenreByMemberRecommendVO;

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
	public String main(Model model, HttpSession session) {
		List<MovieListVO> movieList = movieDao.findAllMovieList();
		int ratingCount = ratingDao.getCount();
		model.addAttribute("movieList", movieList);
		model.addAttribute("ratingCount", ratingCount);

//		log.debug("movieList = {}", movieList);

		// 여기서부터 영화 추천 코드 - 건들지 말 것!

		// MVC Top 10 영화 추천
		List<MVCTop10RecommendVO> mvcTop10RecommendVO = recommendDao.getMVCTop10();
//		log.debug("mvcTop10RecommendVo = {}", mvcTop10RecommendVO);
		List<MovieListVO> mvcTop10RecommendList = new ArrayList<>(); // 리스트 초기화

		for (MVCTop10RecommendVO mvcTop10Recommend : mvcTop10RecommendVO) {
			int movieNo = mvcTop10Recommend.getMovieNo();
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

		log.debug("session = {}", session);
		// 회원 로그인 했을 때 출력
		if (session.getAttribute("name") != null) {
			// 세션에서 사용자 아이디를 가져와서 memberId에 저장
			String memberId = (String) session.getAttribute("name");

			// memberId를 모델에 추가
			model.addAttribute("memberId", memberId);
			MemberDto memberDto = memberDao.selectOne(memberId);
			String memberNickname = memberDto.getMemberNickname();
			String memberGender = memberDto.getMemberGender();
			String memberBirth = memberDto.getMemberBirth();
			
			
			// 회원별 선호 장르 추천
			List<PreferGenreByMemberRecommendVO> preferGenreByMemberRecommendVO
			= movieDao.getPreferGenreByMember(memberNickname);
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
			List<AgeGroupRecommendVO> ageGroupRecommendVO
			= movieDao.getAgeGroup(memberBirth);
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
			List<GenderRecommendVO> genderRecommendVO = movieDao.getGender(memberGender);
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
		}

		return "main";
	}

}
