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
import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieVO;

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
		model.addAttribute(mvcTop10RecommendList);

		// MVC 평론가 Top 10 영화 추천
		List<MVCCriticTop10RecommendVO> mvcCriticTop10RecommendVO = recommendDao.getMVCCriticTop10();

		// 회원 로그인 했을 때 출력
		if (session != null) {
			// 세션에서 사용자 아이디를 가져와서 memberId에 저장
			String memberId = (String) session.getAttribute("name");

			// memberId를 모델에 추가
			model.addAttribute("memberId", memberId);
			// log.debug("memberId = {}", memberId);
			MemberDto memberDto = memberDao.selectOne(memberId);
			// log.debug("memberDto = {}", memberDto);

		}

		return "main";
	}

}
