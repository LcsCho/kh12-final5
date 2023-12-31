package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.vo.ActorDetailVO;
import com.kh.movie.vo.AdminMovieListVO;
import com.kh.movie.vo.AgeGroupGenderRecommendVO;
import com.kh.movie.vo.AgeGroupRecommendVO;
import com.kh.movie.vo.GenderRecommendVO;
import com.kh.movie.vo.MovieDetailActorVO;
import com.kh.movie.vo.MovieDetailVO;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieVO;
import com.kh.movie.vo.PreferGenreByMemberRecommendVO;

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
	public List<AdminMovieListVO> adminMovieList() {
		return sqlSession.selectList("movie.adminMovieList");
	}
	
	@Override
	public List<AdminMovieListVO> selectAdminMovieListByPage(int currentPage, int pageSize) {
		int end = currentPage * pageSize;
		int begin = end - (pageSize-1);
		Map params = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("movie.movieListByPage", params);
	}
	
	@Override
	public List<AdminMovieListVO> selectAdminSearchListByPage(
			String movieName, int searchCurrentPage, int searchPageSize) {
		int end = searchCurrentPage * searchPageSize;
		int begin = end - (searchPageSize-1);
		Map<String, Object> params = Map.of("movieName", movieName, "begin", begin, "end", end);
		return sqlSession.selectList("movie.adminSearchListByPage", params);
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
	public int getCount() {
		return sqlSession.selectOne("movie.count");
	}
	
	@Override
	public int movieListCount() {
		return sqlSession.selectOne("movie.movieListCount");
	}
	
	@Override
	public int searchCount(String movieName) {
		return sqlSession.selectOne("movie.searchCount", movieName);
	}

	@Override
	public List<Integer> findDetailImageNoByMovieNo(int movieNo) {
		return sqlSession.selectList("movie.findDetailImageNoByMovieNo",movieNo);
	}
	@Override
	public List<MovieDetailActorVO> findActorListByMovieNo(int movieNo) {
//		return sqlSession.selectList("movie.findActorListByMovieNo",movieNo);
		return sqlSession.selectList("movie.findActorByMovieNo",movieNo);
	}

	@Override
	public List<MovieListVO> findAllMovieList() {
		return sqlSession.selectList("movie.findAllMovieList");
	}
	
	@Override
	public List<MovieListVO> getMovieSearch(String movieName) {
		return sqlSession.selectList("movie.findMovieByMovieName", movieName);
	}
	
	
	@Override
	public MovieVO findByMovieNoVO(int movieNo) {
		return sqlSession.selectOne("movie.findByMovieNoVO", movieNo);
	}
	
	@Override
	public List<MovieDetailVO> getImgs(int movieNo) {
		return sqlSession.selectList("image.imgNo", movieNo);
	}
	
	@Override
	public List<ActorDetailVO> getActor(int movieNo) {
		return sqlSession.selectList("movie.findActorByMovieNo", movieNo);
	}
	
	@Override
	public List<MovieListVO> searchMovieList(String keyword) {
		return sqlSession.selectList("movie.searchMovieList", keyword);
	}
	
	@Override
	public List<String> findMovieNameList(String keyword) {
		return sqlSession.selectList("movie.findMovieNameList", keyword);
	}
	
}
