package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.vo.MovieListVO;

public interface SearchDao {

	List<String> searchMovieName(String keyword);

}
