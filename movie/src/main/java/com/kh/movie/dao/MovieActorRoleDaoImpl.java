package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieActorRoleDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieActorRoleDaoImpl implements MovieActorRoleDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(MovieActorRoleDto movieActorRoleDto) {
		sqlSession.insert("movieActorRole.add", movieActorRoleDto);
	}

	@Override
	public boolean editUnit(int movieNo, int actorNo, MovieActorRoleDto movieActorRoleDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("actorNo", actorNo);
		params.put("movieActorRoleDto", movieActorRoleDto);
		
		return sqlSession.update("movieActorRole.editUnit", params) > 0;
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("movieActorRole.sequence");
	}
	
	@Override
	public List<MovieActorRoleDto> findByMovieNo(int movieNo) {
		return sqlSession.selectList("movieActorRole.findByMovieNo", movieNo);
	}

}
