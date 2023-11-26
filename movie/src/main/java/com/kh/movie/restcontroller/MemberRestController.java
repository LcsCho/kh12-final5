package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.movie.configuration.FileUploadProperties;
import com.kh.movie.dao.ImageDao;
import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.MovieWishDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.RecommendDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieVO;
import com.kh.movie.vo.ReviewListVO;
import com.kh.movie.vo.WishMovieRecommendVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "회원 관리", description = "회원 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private ImageDao imageDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private RecommendDao recommendDao;
	
	@Autowired
	private ReviewDao reviewDao;


	@Autowired
	private FileUploadProperties props;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}

	@Autowired
	private BCryptPasswordEncoder encoder;
  
	@GetMapping("/memberCount")
	public int count() {
		return memberDao.getCount();
	}
	
	@GetMapping("/searchCount/{memberNickname}")
	public int searchCount(@PathVariable String memberNickname) {
		return memberDao.searchCount(memberNickname);
	}

	@PatchMapping("/{memberId}")
	public ResponseEntity<String> editUnit(@PathVariable String memberId, @RequestBody MemberDto memberDto) {
		if (memberDto.isEmpty())
			return ResponseEntity.badRequest().build();
		boolean result = memberDao.editUnit(memberDto, memberId);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}

	@GetMapping("/")
	public List<MemberDto> list() {
		return memberDao.selectList();
	}

	
  @PostMapping("/login")
  public ResponseEntity<String> login(@RequestParam String memberId,
                                      @RequestParam String memberPw,
                                      HttpSession session) {
      MemberDto findDto = memberDao.selectOne(memberId);
      //log.debug("password={}", findDto.getMemberPw());
      
      if (findDto == null) {
          // 아이디가 존재하지 않는 경우
          return new ResponseEntity<>("아이디가 존재하지 않습니다.", HttpStatus.NOT_FOUND);
      }


      boolean isCorrectPw = encoder.matches(memberPw, findDto.getMemberPw());
      //log.debug("isCorrectPw = {}",isCorrectPw);

      if (isCorrectPw) {
          session.setAttribute("name", findDto.getMemberId());
          session.setAttribute("level", findDto.getMemberLevel());
          memberDao.updateMemberLastLogin(memberId);

          log.debug("Login successful. Session attributes: name={}, level={}", session.getAttribute("name"), session.getAttribute("level"));

          return new ResponseEntity<>("로그인 성공", HttpStatus.OK);
      } else {
          return new ResponseEntity<>("비밀번호가 일치하지 않습니다.", HttpStatus.UNAUTHORIZED);
      }
  }
	
	//아이디 체크(이메일주소)
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if (memberDto == null) { // 아이디가 없으면
			return "Y";
		} else { // 아이디가 있으면
			return "N";
		}
	}

	// 닉네임 체크
	@PostMapping("/nicknameCheck")
	public String snicknameCheck(@RequestParam String memberNickname) {
		MemberDto memberDto = memberDao.selectOneByNickname(memberNickname);
		if (memberDto == null) {
			return "Y";
		} else {
			return "N";
		}
	}
	
	//회원 정보 수정
	@PostMapping("/change")
	public String change(HttpSession session, @ModelAttribute MemberDto memberDto) {
		String memberId = (String) session.getAttribute("name");
		
		//MemberDto findDto = memberDao.selectOne(memberId);
		
		memberDto.setMemberId(memberId);
		 System.out.println("Received inputDto: " + memberDto);
			boolean result = memberDao.updateMemberInfo(memberDto);//입력받아 정보 변경 처리
			System.out.println("result = " + result);
			//마지막 정보 수정 시각 갱신
			memberDao.lastUpdate(memberDto.getMemberId());
			
			return "redirect:/mypage";
	}
	
	//회원 탈퇴
	@PostMapping("/exit")
	public ResponseEntity<String> exit(HttpSession session, String memberPw) {
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
	
		//비밀번호와 암호화된 비밀번호를 비교하여 일치한다면
		log.debug("입력PW = {}",memberPw);
		log.debug("memberPW = {}", memberDto.getMemberPw());
		
		if( memberDto != null && encoder.matches(memberPw, memberDto.getMemberPw())) {
			session.removeAttribute("name");//세션에서 name의 값을 삭제
			memberDao.delete(memberId);//삭제
			
			return ResponseEntity.ok("탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.");		
		}
		else {//비밀번호 불일치 시,
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("비밀번호가 일치하지 않습니다.");
		}
	}
	
	
	//로그아웃 상태일 때 
	@PostMapping("/changePw")
    public String changePassword(String memberId, String memberPw) {
        if (memberId != null && memberPw != null) {
            // 새로운 비밀번호 암호화
            String encryptedPassword = encoder.encode(memberPw);
            
            // 회원 정보 업데이트
            MemberDto memberDto = new MemberDto();
            memberDto.setMemberId(memberId);
            memberDto.setMemberPw(encryptedPassword);

            memberDao.updatePassword(memberDto); //DB에 비밀번호를 업데이트하는 메서드

            return "/"; // 비밀번호 변경 후 이동할 페이지 지정
        } else {
            // 오류 처리
            return "/error"; // 적절한 오류 페이지로 리다이렉트
        }
    }
	
	//로그인 상태일 때
	@PostMapping("/newPw")
	public String newPassword(HttpSession session, @RequestParam String memberPw) {
		String loginMemberId = (String) session.getAttribute("name");
		log.debug("입력PW = {}", memberPw);

		if (loginMemberId != null && memberPw != null) {
			String encryptedPassword = encoder.encode(memberPw);
			log.debug("새로운PW = {}", encryptedPassword);
			
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(loginMemberId);
			memberDto.setMemberPw(encryptedPassword);
      
			memberDao.updatePassword(memberDto);
            
			// 비밀번호 변경 후 로그인 세션 값 제거
            session.removeAttribute("name");
            session.removeAttribute("level");
            
            //session.setAttribute("name", loginMemberId);
            
            return "/";

		} else {
			return "/error";
		}
	}

	@PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<Integer> upload(@RequestPart MultipartFile image, HttpSession session)
			throws IllegalStateException, IOException {

		String memberId = (String) session.getAttribute("name");
		log.debug("memberId={}", memberId);

		// 기존 아이디가 가지고 있던 이미지의 번호 가져오기
		log.debug("findImageNo={}", memberDao.findMemberImage(memberId));
		Integer findImageNo = memberDao.findMemberImage(memberId);

		if (findImageNo != null && findImageNo > 0) {// 찾은 이미지가 0보다 크면//이미지가 있으면
			imageDao.delete(findImageNo);
			File target = new File(dir, String.valueOf(findImageNo));
			target.delete();
		}

		int imageNo = imageDao.sequence();
		log.debug("imageNo={}", imageNo);
		File target = new File(dir, String.valueOf(imageNo));
		image.transferTo(target);

		ImageDto insertDto = new ImageDto();
		insertDto.setImageNo(imageNo);
		insertDto.setImageName(image.getOriginalFilename());
		insertDto.setImageSize(image.getSize());
		insertDto.setImageType(image.getContentType());
		imageDao.insert(insertDto);
		memberDao.insertMemberImage(memberId, imageNo);
		// ajax에서 imageNo가 필요해서 반환을 함
		return ResponseEntity.ok().body(imageNo);
	}

	@DeleteMapping("/delete")
	public ResponseEntity<String> delete(HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		log.debug(memberId);
		int findImageNo = memberDao.findMemberImage(memberId);

		boolean result = imageDao.delete(findImageNo);
		File target = new File(dir, String.valueOf(findImageNo));
		target.delete();
		if (result) {
			return ResponseEntity.ok().build();
		} else {
			return ResponseEntity.notFound().build();
		}
	}

//	@GetMapping("/adminSearch/{memberNickname}")
//	public List<MemberDto> adminSearch(String memberNickname) {
//		return memberDao.selectList(memberNickname);
//	}
	
  //검색 회원 리스트 페이지네이션
	@GetMapping("/adminSearch/{memberNickname}/page/{searchCurrentPage}/size/{searchPageSize}")
	public List<MemberDto> adminSearch(
			@PathVariable String memberNickname, @PathVariable int searchCurrentPage, @PathVariable int searchPageSize) {
		return memberDao.selectSearchList(memberNickname, searchCurrentPage, searchPageSize);
	}
  
	//전체 회원 리스트 페이지네이션
	@GetMapping("page/{currentPage}/size/{pageSize}")
	public List<MemberDto> selectListByPage(@PathVariable int currentPage, @PathVariable int pageSize) {
		return memberDao.selectListByPage(currentPage, pageSize);
	}
	
	@GetMapping("/reviewList")
	public List<ReviewListVO> reviewList(HttpSession session, Model model) {
		
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		String memberNickname = memberDto.getMemberNickname();
		List<ReviewListVO> reviewList = reviewDao.getListByMemberNickname(memberNickname); 
		return reviewList;
	}
	
	@GetMapping("/ratingList")
	public List<MovieListVO> ratingList(HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		List<Integer> ratingList = ratingDao.getRatingListByMemberId(memberId);
		List<MovieListVO> ratingMovieList = new ArrayList<>();
		for (Integer rating : ratingList) {
			MovieVO movieVO = movieDao.findByMovieNoVO(rating);
			// MovieListVO 객체 생성
			MovieListVO ratingMovie = new MovieListVO();
			BeanUtils.copyProperties(movieVO, ratingMovie);
			
			// 리스트에 추가
//			log.debug("ratingMovie={}",ratingMovie);
			ratingMovieList.add(ratingMovie);
		}
		
		return ratingMovieList;
	}
	
	@DeleteMapping("/ratingDelete")
	public void ratingDelete(HttpSession session, @RequestParam int movieNo) {
		String memberId = (String) session.getAttribute("name");
		ratingDao.deleteRating(memberId, movieNo);
	}
	
	@GetMapping("/wishList")
	public List<MovieListVO> wishList(HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		List<WishMovieRecommendVO> wishMovieRecommendVO = recommendDao.getWishMovie(memberId);
		List<MovieListVO> wishMovieList = new ArrayList<>();
		
		for (WishMovieRecommendVO wishMovieRecommend : wishMovieRecommendVO) {
			int movieNo = wishMovieRecommend.getMovieNo();
			MovieVO movieVO = movieDao.findByMovieNoVO(movieNo);
			
			// MovieListVO 객체 생성
			MovieListVO wishMovieRecommendMovie = new MovieListVO();
			BeanUtils.copyProperties(movieVO, wishMovieRecommendMovie);
			
			// 리스트에 추가
			wishMovieList.add(wishMovieRecommendMovie);
		}
		return wishMovieList;
	}

}
