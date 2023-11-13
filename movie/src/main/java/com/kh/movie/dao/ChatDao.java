package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ChatDto;

public interface ChatDao {
	void insert(ChatDto chatDto);
	List<ChatDto> selectList();
}
