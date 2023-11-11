package com.kh.movie.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ImageDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ImageDaoImpl implements ImageDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("image.sequence");
	}
	
	@Override
	public void insert(ImageDto imageDto) {
		sqlSession.insert("image.add",imageDto);
		
	}
	@Override
	public ImageDto selectOne(int imageNo) {
		return sqlSession.selectOne("image.find",imageNo);
	}
	@Override
	public boolean delete(int imageNo) {
		return sqlSession.delete("image.delete", imageNo)>0;
	}

	@Override
	public boolean deleteImageByActorNo(int actorNo) {
		return sqlSession.delete("image.deleteImageByActorNo", actorNo) > 0;
	}
}
