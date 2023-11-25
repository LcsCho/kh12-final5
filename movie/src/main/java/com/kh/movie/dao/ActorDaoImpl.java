package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ActorDto;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.vo.ActorViewVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ActorDaoImpl implements ActorDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("actor.sequence");
	}
	
	@Override
	public List<ActorDto> selectList() {
		return sqlSession.selectList("actor.findAll");
	}

	@Override
	public List<ActorDto> findListByActorName(String actorName) {
		return sqlSession.selectList("actor.findListByActorName", actorName);
	}
	
	@Override
	public ActorDto findByActorNo(int actorNo) {
		
		return sqlSession.selectOne("actor.findByActorNo",actorNo);
	}
	
	@Override
	public List<ActorViewVO> selectActorList() {
		return sqlSession.selectList("actor.actorList");
	}
	
	@Override
	public void insert(ActorDto actorDto) {
		sqlSession.insert("actor.save", actorDto);
	}

	@Override
	public boolean delete(int actorNo) {
		return sqlSession.delete("actor.deleteByActorNo", actorNo) > 0;
	}


	@Override
	public boolean edit(int actorNo, ActorDto actorDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("actorNo", actorNo);
		params.put("dto", actorDto);
		return sqlSession.update("actor.edit", params) > 0;
	}

	@Override
	public boolean editUnit(int actorNo, ActorDto actorDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("actorNo", actorNo);
		params.put("dto", actorDto);
		return sqlSession.update("actor.editUnit", params) > 0;
	}
	
	@Override
	public void connectActorImage(int actorNo, int imageNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("actorNo", actorNo);
		params.put("imageNo", imageNo);
		sqlSession.insert("actor.connectActorImage",params);
		
	}
	@Override
	public ImageDto findActorImage(int actorNo) {
		return sqlSession.selectOne("actor.findActorImage",actorNo);
	}
	
	@Override
	public List<Integer> findImageNoByActorName(String actorName) {
		return sqlSession.selectList("actor.findImageNoByActorName",actorName);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("actor.count");
	}
	
	@Override
	public int searchCount(String actorName) {
		return sqlSession.selectOne("actor.searchCount", actorName);
	}
	
	@Override
	public List<ActorViewVO> selectListByPage(int currentPage, int pageSize) {
		int end = currentPage * pageSize;
		int begin = end - (pageSize-1);
		Map params = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("actor.actorListByPage", params);
	}
	
	@Override
	public List<ActorDto> selectList(String actorName, int searchCurrentPage, int searchPageSize) {
		int end = searchCurrentPage * searchPageSize;
		int begin = end - (searchPageSize-1);
		Map<String, Object> params = Map.of("actorName", actorName, "begin", begin, "end", end);
		return sqlSession.selectList("actor.adminSearchListByPage", params);
	}

}
