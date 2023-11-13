package com.kh.movie.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.kh.movie.dto.MovieActorRoleDto;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.dto.MovieGenreDto;

import lombok.Data;


//영화 대표 이미지 등록을 위해 만든 VO
@Data
public class MovieUploadVO {
	
	private MultipartFile movieImage;//하나씩 이미지
	
	private List<MultipartFile> movieImageList;//이미지 여러개
	
	private String movieName, movieDirector;
	private Date movieReleaseDate;
	private int movieTime;
	private String movieLevel, movieNation, movieContent;
	
//	private String genreName;
	// 장르 리스트
	private List<String> genreNameList; // 여러 장르를 저장하는 리스트
	
	// 배우 리스트
	private List<Integer> actorNoList; // 배우 번호 저장하는 리스트
	private List<String> actorRoleList; // 여러 배우를 저장하는 리스트
	
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
	

    @JsonIgnore
    public List<MovieGenreDto> getMovieGenreDtoList() {
        return genreNameList.stream()
                .map(genreName -> MovieGenreDto.builder()
                        .genreName(genreName)
                        .build())
                .toList();
    }
    
    @JsonIgnore
    public List<MovieActorRoleDto> getMovieActorRoleDtoList() {
        List<MovieActorRoleDto> actorRoleDtoList = new ArrayList<>();

        for (int i = 0; i < actorNoList.size(); i++) {
            int actorNo = actorNoList.get(i);
            String actorRole = actorRoleList.get(i);

            MovieActorRoleDto actorRoleDto = MovieActorRoleDto.builder()
                    .movieNo(getMovieDto().getMovieNo())
                    .actorNo(actorNo)
                    .actorRole(actorRole)
                    .build();

            actorRoleDtoList.add(actorRoleDto);
        }

        return actorRoleDtoList;
    }
    
}
