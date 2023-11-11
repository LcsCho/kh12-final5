package com.kh.movie.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.kh.movie.dto.MovieDto;

import lombok.Data;


//영화 대표 이미지 등록을 위해 만든 VO
@Data
public class MovieImageUploadVO {
	
	private MultipartFile movieImage;//하나씩 이미지
	
	private List<MultipartFile> movieImageList;//이미지 여러개
	
	private String movieName, movieDirector;
	private Date movieReleaseDate;
	private int movieTime;
	private String movieLevel, movieNation, movieContent;
	
	@JsonIgnore
	public MovieDto getMovieDto() {
		return MovieDto.builder()
					.movieName(movieName)
					.movieDirector(movieDirector)
					.movieReleaseDate(movieReleaseDate)
					.movieTime(movieTime)
					.movieLevel(movieLevel)
					.movieNation(movieNation)
					.movieContent(movieContent)
				.build();
	}
}
