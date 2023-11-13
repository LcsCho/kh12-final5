package com.kh.movie.dao;

import com.kh.movie.dto.MovieActorRoleDto;

public interface MovieActorRoleDao {

	void insert(MovieActorRoleDto movieActorRoleDto);
	boolean editUnit(int movieNo, int actorNo, MovieActorRoleDto movieActorRoleDto);
	int sequence();

}
