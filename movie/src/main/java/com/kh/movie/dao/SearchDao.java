package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.SearchHistoryDto;

public interface SearchDao {
	// 영화 제목 검색
	List<String> searchMovieName(String keyword);
	// 인기 검색어 입출력
	void inputPopularKeyword(String keyword);
	List<String> showPopular();
	// 최근 검색어 입출력 및 삭제(개별, 전체)
	void inputRecentKeyword(String keyword, String memberId);
	List<String> showRecent(String memberId);
	void deleteAll(String memberId);
	void deleteEach(String memberId, String keyword);

}
