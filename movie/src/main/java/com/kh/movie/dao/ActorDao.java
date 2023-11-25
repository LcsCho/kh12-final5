package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ActorDto;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.vo.ActorViewVO;

public interface ActorDao {
	int sequence();
	int getCount();
	int searchCount(String actorName);
	List<ActorDto> selectList();
	void insert(ActorDto actorDto);
	boolean delete(int actorNo);
	List<ActorDto> findListByActorName(String actorName);
	boolean edit(int actorNo, ActorDto actorDto);
	boolean editUnit(int actorNo, ActorDto actorDto);
	void connectActorImage(int actorNo, int imageNo);
	ImageDto findActorImage(int actorNo);
	ActorDto findByActorNo(int actorNo);
//	List<ActorDto> selectList(String actorName);
	List<Integer> findImageNoByActorName(String actorName);
	List<ActorViewVO> selectActorList();
	List<ActorViewVO> selectListByPage(int currentPage, int pageSize);
	List<ActorDto> selectList(String actorName, int searchCurrentPage, int searchPageSize);

}
