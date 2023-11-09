package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.kh.movie.dao.ImageDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.vo.MovieUploadVO;
import com.kh.movie.vo.AdminMovieListVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "영화 관리", description = "영화 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movie")
public class MovieRestController {
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private ImageDao imageDao; 
	
	@GetMapping("/")
	public List<MovieDto> list() {
		return movieDao.selectList();
	}
	
	@GetMapping("/movieCount")
	public int count() {
		return movieDao.getCount();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody MovieDto movieDto) {
		movieDao.insert(movieDto);
	}
	
	@DeleteMapping("/{movieNo}")
	public ResponseEntity<String> delete(@PathVariable int movieNo) {
		boolean result = movieDao.delete(movieNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/{movieName}")
	public List<MovieDto> find(@PathVariable String movieName) {
		return movieDao.selectList(movieName);
	}
	
	@GetMapping("/adminMovieList")
	public List<AdminMovieListVO> adminMovieList() {
		return movieDao.selectAdminMovieList();
	}
	
	@PutMapping("/{movieNo}")
	public ResponseEntity<String> edit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		boolean result = movieDao.edit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PatchMapping("/{movieNo}")
	public ResponseEntity<String> editUnit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		if (movieDto.isEmpty()) return ResponseEntity.badRequest().build();
		boolean result = movieDao.editUnit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PostMapping(value = "/image/",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public void upload(@ModelAttribute MovieUploadVO vo) throws IllegalStateException, IOException {
//		ObjectMapper mapper = new ObjectMapper();
//		MovieDto dto = mapper.readValue(movieDto, MovieDto.class);
		log.debug("dto = {}", vo);
		MovieDto moviedto = vo.getMovieDto();
		
		int movieNo = movieDao.sequence();
		log.debug("movieNo={}",movieNo);
		
		moviedto.setMovieNo(movieNo);
		log.debug("movieNo={}",moviedto.getMovieNo());
		movieDao.insert(moviedto);
		
		MultipartFile attach =vo.getAttach();
		
		int imageNo = imageDao.sequence();
		
		String home = System.getProperty("user.home");
		File dir = new File(home,"upload");
		dir.mkdir();
		File target = new File(dir,String.valueOf(imageNo));
		attach.transferTo(target);
		
		ImageDto imageDto = new ImageDto();
		imageDto.setImageNo(imageNo);
		imageDto.setImageName(attach.getOriginalFilename());
		imageDto.setImageSize(attach.getSize());
		imageDto.setImageType(attach.getContentType());	
		imageDao.insert(imageDto);
		
		movieDao.connectMainImage(moviedto.getMovieNo(),imageNo);
		log.debug("attach = {}", attach);
		
		
	}
	

}
