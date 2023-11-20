package com.kh.movie.restcontroller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.SearchDao;
import com.kh.movie.vo.MovieListVO;

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
	
	@PostMapping("/movieName")
	public List<String> searchMovieName(@RequestParam String movieName) {
		List<MovieListVO> searchNameList = searchDao.searchMovieName(movieName);
	    // MovieListVO에서 MovieName만 추출하여 리스트로 변환
	    List<String> movieNames = searchNameList.stream()
	                                            .map(MovieListVO::getMovieName)
	                                            .collect(Collectors.toList());
	    return movieNames;
		
	}
}
