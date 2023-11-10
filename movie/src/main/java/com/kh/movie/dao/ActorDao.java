package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.ActorDto;

public interface ActorDao {
	int sequence();
	List<ActorDto> selectList();
	void insert(ActorDto actorDto);
	boolean delete(int actorNo);
	List<ActorDto> selectList(String actorName);
	boolean edit(int actorNo, ActorDto actorDto);
	boolean editUnit(int actorNo, ActorDto actorDto);
	void connectActorImage(int actorNo, int imageNo);

}
