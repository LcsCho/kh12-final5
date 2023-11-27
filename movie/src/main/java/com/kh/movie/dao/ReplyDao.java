package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ReplyDto;

public interface ReplyDao {
	int sequence();
	void insert(ReplyDto replyDto);//등록
	boolean delete(int replyNo);//삭제
	List<ReplyDto> findAll(int reviewNo);//댓글 목록 조회
	ReplyDto findByReplyNo(int replyNo);//댓글 상세 조회
	int findReplyCount(int reviewNo);//댓글 수 조회
}
