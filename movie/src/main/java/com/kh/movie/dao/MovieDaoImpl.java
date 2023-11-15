package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.vo.AdminMovieListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieDaoImpl implements MovieDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("movie.sequence");
	}
	
	@Override
	public MovieDto findByMovieNo(int movieNo) {
		return sqlSession.selectOne("movie.findByMovieNo", movieNo);
	}
	
	@Override
	public List<MovieDto> selectList() {
		return sqlSession.selectList("movie.findAll");
	}
	
	@Override
	public List<AdminMovieListVO> selectAdminMovieList() {
		return sqlSession.selectList("movie.adminMovieList");
	}

	@Override
	public List<MovieDto> selectList(String movieName) {
		return sqlSession.selectList("movie.findByMovieName", movieName);
	}

	@Override
	public void insert(MovieDto movieDto) {
		sqlSession.insert("movie.save", movieDto);
	}


	@Override
	public boolean delete(int movieNo) {
		return sqlSession.delete("movie.deleteByMovieNo", movieNo) > 0;
	}

	@Override
	public boolean edit(int movieNo, MovieDto movieDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("dto", movieDto);
		return sqlSession.update("movie.edit", params) > 0;
	}
	
	@Override
	public boolean editUnit(int movieNo, MovieDto movieDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("dto", movieDto);
		return sqlSession.update("movie.editUnit", params) > 0;
	}
	
	//영화 대표 이미지 연결
	@Override
	public void connectMainImage(int movieNo, int imageNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("imageNo", imageNo);
		sqlSession.insert("movie.connectMainImage",params);
		
	}
	
	//영화 상세 이미지 연결
	@Override
	public void connectDetailImage(int movieNo, int imageNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("movieNo", movieNo);
		params.put("imageNo", imageNo);
		sqlSession.insert("movie.connectDetailImage",params);
		
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("movie.count");
	}
	
	//메인 이미지 찾기(이미지 다운로드를 위해 만들음)
	@Override
	public ImageDto findMainImage(int movieNo) {	
		return sqlSession.selectOne("movie.findMainImage",movieNo);
	}
	
	@Override
	public ImageDto findImage(int ImageNo) {
		
		return sqlSession.selectOne("movie.findImage",ImageNo);
	}

	@Override
	public List<AdminMovieListVO> selectAdminMovieList(String movieName) {
		return sqlSession.selectList("movie.adminSearch", movieName);
	}
	@Override
	public List<Integer> findDetailImageNoByMovieNo(int movieNo) {
		return sqlSession.selectList("movie.findImageNoByMovieNo",movieNo);
	}

}
