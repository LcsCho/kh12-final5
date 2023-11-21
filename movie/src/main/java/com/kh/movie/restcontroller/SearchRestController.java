package com.kh.movie.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.SearchDao;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieNoAndNameVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "검색 관리", description = "검색 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/search")
public class SearchRestController {
	
	@Autowired
	private SearchDao searchDao;
	
//	@PostMapping("/")
//	public void insert(@PathVariable String keyword) {
//		movieDao.getMovieSearch(keyword);
//	}
	
	@GetMapping("/movieName")
	public List<MovieNoAndNameVO> searchMovieName(@RequestParam String keyword) {
	    List<MovieListVO> searchMovieList = searchDao.searchMovieName(keyword);
	    List<MovieNoAndNameVO> movieInfoList = new ArrayList<>();

	    for (MovieListVO movie : searchMovieList) {
	        MovieNoAndNameVO movieInfo = new MovieNoAndNameVO();
	        movieInfo.setMovieName(movie.getMovieName());
	        movieInfo.setMovieNo(movie.getMovieNo());
	        
	        movieInfoList.add(movieInfo);
	    }

	    return movieInfoList;
	}
}
