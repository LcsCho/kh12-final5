package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.SearchDao;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "검색 관리", description = "검색 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/search")
public class SearchRestController {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private SearchDao searchDao;

//	@PostMapping("/")
//	public void insert(@PathVariable String keyword) {
//		movieDao.getMovieSearch(keyword);
//	}

	@GetMapping("/movieName")
	public List<String> searchMovieName(@RequestParam String keyword) {
		List<String> searchMovieList = movieDao.findMovieNameList(keyword);
//	    List<String> movieInfoList = new ArrayList<>();

//	    for (MovieListVO movie : searchMovieList) {
//	        MovieNoAndNameVO movieInfo = new MovieNoAndNameVO();
//	        movieInfo.setMovieName(movie.getMovieName());
//	        movieInfo.setMovieNo(movie.getMovieNo());
//	        
//	        movieInfoList.add(movieInfo);
//	    }

		return searchMovieList;
	}

	@PostMapping("/inputPopularKeyword")
	public void inputPopularKeyword(@RequestParam String keyword) {
		searchDao.inputPopularKeyword(keyword);
	}

	@GetMapping("/showPopular")
	public List<String> showPopularList() {
		return searchDao.showPopular();
	}
	
	@PostMapping("/inputRecentKeyword")
	public void inputRecentKeyword(
			@RequestParam String keyword,
			@RequestParam String memberId) {
		searchDao.inputRecentKeyword(keyword, memberId);
	}
	
	@GetMapping("/showRecent")
	public List<String> showRecentList(@RequestParam String memberId) {
		return searchDao.showRecent(memberId);
	}
	
	@DeleteMapping("/deleteAll")
	public void deleteAll(@RequestParam String memberId) {
		searchDao.deleteAll(memberId);
	}
	
	@DeleteMapping("/deleteEach")
	public void deleteEach(@RequestParam String memberId, @RequestParam String keyword) {
		searchDao.deleteEach(memberId, keyword);
	}
	
	
}
