package com.kh.movie.dao;

import java.util.List;

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
import com.kh.movie.vo.WishMovieRecommendVO;

public interface MovieDao {
	int sequence();
	MovieDto findByMovieNo(int movieNo);
	List<MovieDto> selectList();
	List<AdminMovieListVO> selectAdminMovieList();
	List<MovieDto> selectList(String movieName);
	void insert(MovieDto movieDto);
	boolean delete(int movieNo);
	boolean edit(int movieNo, MovieDto movieDto);
	boolean editUnit(int movieNo, MovieDto movieDto);
	void connectMainImage(int movieNo, int imageNo);
	void connectDetailImage(int movieNo, int imageNo);
	int getCount();
	ImageDto findMainImage(int movieNo);
	ImageDto findImage(int ImageNo);
	List<AdminMovieListVO> selectAdminMovieList(String movieName);
	List<Integer> findDetailImageNoByMovieNo(int movieNo);
	List<MovieDetailActorVO> findActorListByMovieNo(int movieNo);
	List<MovieListVO> findAllMovieList();
	List<MovieListVO> getMovieSearch(String movieName);
	
	// 영화 추천 관련 코드
	MovieVO findByMovieNoVO(int movieNo);
	
	// 영화 상세 코드
	List<MovieDetailVO> getImgs(int movieNo);
	List<ActorDetailVO> getActor(int movieNo);
	
	// 영화 검색
	List<MovieListVO> searchMovieName(String keyword);

}
