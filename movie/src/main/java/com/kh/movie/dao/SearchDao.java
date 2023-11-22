package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.SearchHistoryDto;

public interface SearchDao {

	List<String> searchMovieName(String keyword);
	void inputKeyword(String keyword);
	List<SearchHistoryDto> showPopular();

}
