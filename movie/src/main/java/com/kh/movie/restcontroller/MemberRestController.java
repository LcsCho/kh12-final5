package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.kh.movie.dto.ImageDto;
import com.kh.movie.dto.MemberDto;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "회원 관리", description = "회원 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ImageDao imageDao;
	
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
	
//	@GetMapping("/memberCount/{memberCount}")
//	public int count() {
//		return memberDao.getCount();
//	}
	@GetMapping("/memberCount")
	public int count() {
		return memberDao.getCount();
	}
	
	@PatchMapping("/{memberId}")
	public ResponseEntity<String> editUnit(@PathVariable String memberId,
			@RequestBody MemberDto memberDto) {
		if (memberDto.isEmpty()) return ResponseEntity.badRequest().build();
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

	        if (findDto == null) {
	            return new ResponseEntity<>("아이디가 없습니다.", HttpStatus.BAD_REQUEST);
	        }

	        boolean isCorrectPw = encoder.matches(memberPw, findDto.getMemberPw());

	        if (isCorrectPw) {
	            session.setAttribute("name", findDto.getMemberId());
	            session.setAttribute("level", findDto.getMemberLevel());
	            memberDao.updateMemberLastLogin(memberId);
	       
	            return new ResponseEntity<>("로그인 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("비밀번호가 일치하지 않습니다.", HttpStatus.UNAUTHORIZED);
	        }
	    }
	

	
	//아이디 체크(이메일주소)
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) { //아이디가 없으면
			return "Y";
		}
		else { //아이디가 있으면
			return "N";
		}	
	}
	
	//닉네임 체크
	@PostMapping("/nicknameCheck")
	public String snicknameCheck(@RequestParam String memberNickname) {
		MemberDto memberDto = memberDao.selectOneByNickname(memberNickname);
		if(memberDto == null) { 
			return "Y";
		}
		else {
			return "N";
		}
	}

	@PostMapping("/changePw")
    public String changePassword(HttpSession session, String memberId, String memberPw) {
        if (memberId != null && memberPw != null) {
            // 새로운 비밀번호 암호화
            String encryptedPassword = encoder.encode(memberPw);
            
            // 회원 정보 업데이트
            MemberDto memberDto = new MemberDto();
            memberDto.setMemberId(memberId);
            memberDto.setMemberPw(encryptedPassword);

            memberDao.updatePassword(memberDto); //DB에 비밀번호를 업데이트하는 메서드

            return "redirect:/"; // 비밀번호 변경 후 이동할 페이지 지정
        } else {
            // 오류 처리
            return "redirect:/error"; // 적절한 오류 페이지로 리다이렉트
        }
    }
	
	@PostMapping("/newPw")
		public String newPassword(HttpSession session,String memberId, String memberPw) {
		String loginMemberId = (String) session.getAttribute("name");
		
		if(loginMemberId != null && memberPw != null) {
			String encryptedPassword = encoder.encode(memberPw);
			
			MemberDto memberDto = new MemberDto();
            memberDto.setMemberId(loginMemberId);
            memberDto.setMemberPw(encryptedPassword);

            memberDao.updatePassword(memberDto);
            
            return "redirect:/mypage";
		} else {
			return "redirect:/error";
		}
	}


	@PostMapping(value ="/upload",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<Integer> upload(@RequestPart MultipartFile image,HttpSession session) throws IllegalStateException, IOException {
		
		String memberId=(String) session.getAttribute("name");
		log.debug("memberId={}",memberId);
		
		//기존 아이디가 가지고 있던 이미지의 번호 가져오기
		log.debug("findImageNo={}",memberDao.findMemberImage(memberId));
		Integer findImageNo =memberDao.findMemberImage(memberId);
		
		if(findImageNo != null && findImageNo>0) {//찾은 이미지가 0보다 크면//이미지가 있으면
			imageDao.delete(findImageNo);
			File target =new File(dir,String.valueOf(findImageNo));
			target.delete();
		}
		
		
		int imageNo = imageDao.sequence();
		log.debug("imageNo={}",imageNo);
		File target = new File(dir, String.valueOf(imageNo));
		image.transferTo(target);
		
		ImageDto insertDto= new ImageDto();
		insertDto.setImageNo(imageNo);
		insertDto.setImageName(image.getOriginalFilename());
		insertDto.setImageSize(image.getSize());
		insertDto.setImageType(image.getContentType());
		imageDao.insert(insertDto);
		memberDao.insertMemberImage(memberId, imageNo);
		//ajax에서 imageNo가 필요해서 반환을 함
		return ResponseEntity.ok().body(imageNo);
	}
	@DeleteMapping("/delete")
	public ResponseEntity<String> delete(HttpSession session){
		String memberId=(String) session.getAttribute("name");
		log.debug(memberId);
		int findImageNo = memberDao.findMemberImage(memberId);
		
			boolean result = imageDao.delete(findImageNo);
			File target =new File(dir,String.valueOf(findImageNo));
			target.delete();
			if(result) {
				return ResponseEntity.ok().build();
			}
			else {
				return ResponseEntity.notFound().build();
			}
	}	
	@GetMapping("/adminSearch/{memberNickname}")
	public List<MemberDto> adminSearch(String memberNickname) {
		return memberDao.selectList(memberNickname);
	}
	
}

