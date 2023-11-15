package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ReplyDto;

public interface ReplyDao {
	List<ReplyDto> findAll(int reviewNo);//댓글 조회
}
