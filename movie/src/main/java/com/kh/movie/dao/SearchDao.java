package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.SearchHistoryDto;

public interface SearchDao {

	List<String> searchMovieName(String keyword);
	void inputPopularKeyword(String keyword);
	List<String> showPopular();
	void delete();
	void inputKeywordByMember(String keyword, String memberId);
	List<SearchHistoryDto> showRecent(String memberId);

}
