package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.PreferGenreDto;

public interface PreferGenreDao {
	int sequence();
	void insert(PreferGenreDto preferGenreDto);
	boolean delete(String memberNickname, String genreName);
	List<PreferGenreDto> selectList();
	List<PreferGenreDto> selectListByMemberNickname(String memberNickname);
}
