package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.movie.configuration.FileUploadProperties;
import com.kh.movie.dao.ImageDao;
import com.kh.movie.dao.MovieActorRoleDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.MovieGenreDao;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.dto.MovieActorRoleDto;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.dto.MovieGenreDto;
import com.kh.movie.vo.AdminMovieListVO;
import com.kh.movie.vo.MovieDetailActorVO;
import com.kh.movie.vo.MovieUploadVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "영화 관리", description = "영화 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/movie")
public class MovieRestController {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private MovieGenreDao movieGenreDao;
	
	@Autowired
	private MovieActorRoleDao movieActorRoleDao;

	@Autowired
	private ImageDao imageDao;

	// 프로필 업로드 & 다운로드 기능

	// 초기 디렉터리 설정
	@Autowired
	private FileUploadProperties props;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}

	@GetMapping("/")
	public List<MovieDto> list() {
		return movieDao.selectList();
	}

	@GetMapping("/movieCount")
	public int count() {
		return movieDao.getCount();
	}
	
	@GetMapping("/movieListCount")
	public int movieListCount() {
		return movieDao.movieListCount();
	}
	
	@GetMapping("/searchCount/{movieName}")
	public int searchCount(String movieName) {
		return movieDao.searchCount(movieName);
	}

//	@PostMapping("/")
//	public void insert(@RequestBody MovieDto movieDto) {
//		movieDao.insert(movieDto);
//	}

	@DeleteMapping("/{movieNo}")
	public ResponseEntity<String> delete(@PathVariable int movieNo) {
		boolean result = movieDao.delete(movieNo);
		if (result)
			return ResponseEntity.status(200).build();
		else
			return ResponseEntity.status(404).build();
	}

	@GetMapping("/{movieName}")
	public List<MovieDto> find(@PathVariable String movieName) {
		return movieDao.selectList(movieName);
	}
	
	@GetMapping("/movieNo/{movieNo}")
	public ResponseEntity<MovieDto> findByMovieNo(@PathVariable int movieNo) {
		MovieDto movieDto = movieDao.findByMovieNo(movieNo);
		if(movieDto != null) return ResponseEntity.ok().body(movieDto);
		else return ResponseEntity.notFound().build();
	}

	@GetMapping("/adminMovieList")
	public List<AdminMovieListVO> adminMovieList() {
		return movieDao.adminMovieList();
	}

	@PutMapping("/{movieNo}")
	public ResponseEntity<String> edit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		boolean result = movieDao.edit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}

	@PatchMapping("/{movieNo}")
	public ResponseEntity<String> editUnit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		if (movieDto.isEmpty())
			return ResponseEntity.badRequest().build();
		boolean result = movieDao.editUnit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}

	// 영화 등록(영화+이미지 같이 등록)
	@PostMapping(value = "/upload/", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public void insert(@ModelAttribute MovieUploadVO vo) throws IllegalStateException, IOException {

//		log.debug("vo = {}", vo);
		MovieDto movieDto = vo.getMovieDto();

		int movieNo = movieDao.sequence();
//		log.debug("movieNo={}",movieNo);

		movieDto.setMovieNo(movieNo);
//		log.debug("movieNo={}",moviedto.getMovieNo());
		movieDao.insert(movieDto);

		// 해당 영화에 대한 장르 같이 등록 구문
//		MovieGenreDto movieGenreDto = vo.getMovieGenreDto();
//		movieGenreDto.setMovieNo(movieNo);
//		movieGenreDao.insert(movieGenreDto);

//		// 해당 영화에 대한 장르 같이 여러 개 등록 구문
		List<MovieGenreDto> movieGenreDtoList = vo.getMovieGenreDtoList();
		for (MovieGenreDto movieGenreDto : movieGenreDtoList) {

			movieGenreDto.setMovieNo(movieNo);
//			log.debug("movieNo = {}", movieNo);
//			log.debug("genreName = {}", movieGenreDto.getGenreName());
//			log.debug("movieGenreDto = {}", movieGenreDto);
			movieGenreDao.insert(movieGenreDto);
		}

		// 해당 영화에 대한 배우와 역할 같이 여러 개 등록 구문
		List<MovieActorRoleDto> movieActorRoleDtoList = vo.getMovieActorRoleDtoList();
		for (MovieActorRoleDto movieActorRoleDto : movieActorRoleDtoList) {
			movieActorRoleDto.setMovieNo(movieNo);
			movieActorRoleDao.insert(movieActorRoleDto);
		}

		//////////////////////////////////////////
		// 영화 메인 이미지 등록
		MultipartFile movieImage = vo.getMovieImage();
		int imageNo = imageDao.sequence();
//		log.debug("imageNo={}", imageNo);
		File target = new File(dir, String.valueOf(imageNo));
		movieImage.transferTo(target);

		ImageDto imageDto = new ImageDto();
		imageDto.setImageNo(imageNo);
		imageDto.setImageName(movieImage.getOriginalFilename());
		imageDto.setImageSize(movieImage.getSize());
		imageDto.setImageType(movieImage.getContentType());
		imageDao.insert(imageDto);
		//////////////////////////////////////////
		movieDao.connectMainImage(movieDto.getMovieNo(), imageNo);

		//////////////////////////////////////////
		// 영화 상세 이미지 등록
		List<MultipartFile> movieImageList = vo.getMovieImageList();

		for (MultipartFile movieImageLists : movieImageList) {
			imageNo = imageDao.sequence();
//			log.debug("imageNo={}", imageNo);
			target = new File(dir, String.valueOf(imageNo));
			movieImageLists.transferTo(target);

			imageDto.setImageNo(imageNo);
			imageDto.setImageName(movieImageLists.getOriginalFilename());
			imageDto.setImageSize(movieImageLists.getSize());
			imageDto.setImageType(movieImageLists.getContentType());

//			log.debug("imageDto={}", imageDto);
			imageDao.insert(imageDto);

			movieDao.connectDetailImage(movieDto.getMovieNo(), imageNo);
		}
		//////////////////////////////////////////

	}

	
	//
	@GetMapping("/page/{currentPage}/size/{pageSize}")
	public List<AdminMovieListVO> selectAdminMovieListByPage(
			@PathVariable int currentPage, @PathVariable int pageSize) {
		return movieDao.selectAdminMovieListByPage(currentPage, pageSize);
	}
	
	@GetMapping("/adminSearch/{movieName}/page/{searchCurrentPage}/size/{searchPageSize}")
	public List<AdminMovieListVO> adminSearch(
			@PathVariable String movieName, @PathVariable int searchCurrentPage, @PathVariable int searchPageSize) {
		return movieDao.selectAdminSearchListByPage(movieName, searchCurrentPage, searchPageSize);
	}
	
	@GetMapping("/imageNoList/{movieNo}")
	public List<Integer> ImageNoList(@PathVariable int movieNo){
//		log.debug("movieNo={}",movieNo);
		return movieDao.findDetailImageNoByMovieNo(movieNo);
	}
	@GetMapping("/actorInfoList/{movieNo}")
	public List<MovieDetailActorVO> actorInfoList(@PathVariable int movieNo){
		return movieDao.findActorListByMovieNo(movieNo);
	}

}
