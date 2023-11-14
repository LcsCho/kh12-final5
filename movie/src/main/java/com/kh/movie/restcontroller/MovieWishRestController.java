package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieWishDao;
import com.kh.movie.dto.MovieWishDto;
import com.kh.movie.vo.MovieWishVO;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화찜 관리", description = "영화찜 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movieWish")
public class MovieWishRestController {
	
	@Autowired
	private MovieWishDao movieWishDao;
	
	//전체 조회
	@GetMapping("/")
	public List<MovieWishDto> list() {
		return movieWishDao.selectList();
	}
	
	//등록
	@PostMapping("/")
	public void insert(@RequestBody MovieWishDto movieWishDto) {
		movieWishDao.insert(movieWishDto);
	}
	
	//삭제
	@DeleteMapping("/{wishNo}")
	public ResponseEntity<String> delete(@PathVariable int wishNo) {
		boolean result = movieWishDao.delete(wishNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	//찜번호로 상세 조회
	@GetMapping("/{wishNo}")
	public ResponseEntity<MovieWishDto> findByWishNo(@PathVariable int wishNo) {
		MovieWishDto movieWishDto = movieWishDao.selectOne(wishNo);
		if(movieWishDto != null) 	return ResponseEntity.ok().body(movieWishDto);
		else return ResponseEntity.notFound().build();
	}
	
	@RequestMapping("/action")
	public MovieWishVO action(@ModelAttribute MovieWishDto movieWishDto, HttpSession session) {
		int wishNo = movieWishDao.sequence();
		String memberId = (String) session.getAttribute("memberId");
		movieWishDto.setWishNo(wishNo);
		movieWishDto.setMemberId(memberId);
		boolean isCheck = movieWishDao.check(wishNo);
		System.out.println("wishNo: " + wishNo);
		System.out.println("movieNo: " + movieWishDto.getMovieNo());
		System.out.println("memberId: " + memberId);
		if(isCheck) {
			movieWishDao.delete(wishNo);
		}
		else {
			movieWishDao.insert(movieWishDto);
		}
		int count = movieWishDao.count(wishNo);
		MovieWishVO vo = new MovieWishVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
	
	@RequestMapping("/check")
	public MovieWishVO check(@ModelAttribute MovieWishDto movieWishDto, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		movieWishDto.setMemberId(memberId);
		boolean isCheck = movieWishDao.check(movieWishDto.getWishNo());
		int count = movieWishDao.count(movieWishDto.getWishNo());
		System.out.println("wishNo: " + movieWishDto.getWishNo());
		System.out.println("movieNo: " + movieWishDto.getMovieNo());
		System.out.println("memberId: " + memberId);
		MovieWishVO vo = new MovieWishVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		return vo;
	}
}
