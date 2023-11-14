package com.kh.movie.restcontroller;

import java.text.DecimalFormat;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dto.CertDto;
import com.kh.movie.dao.CertDao;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {

	
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CertDao certDao;
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
		//인증번호 생성
		Random r = new Random();
		int no = r.nextInt(1000000);
		DecimalFormat fm = new DecimalFormat("000000");
		String certNo = fm.format(no);
		
		//발송
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(certEmail);
		message.setSubject("[MVC] 인증번호 발송");
		message.setText("인증번호 확인 후 입력하세요. [ "+certNo+" ]");
		sender.send(message);
	
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertNo(certNo);
		certDao.insert(certDto);
	}
	
	@PostMapping("/check")
	public Map<String, Object> check(@ModelAttribute CertDto certDto){
		//[1]이메일로 인증정보를 조회
				//CertDto findDto = certDao.selectOne(certDto.getCertEmail());//기간제한 없음
				CertDto findDto = certDao.selectOneIn5min(certDto.getCertEmail());//5분제한
				if(findDto !=null ) {
					//[2]인증번호 비교
					boolean isValid = findDto.getCertNo().equals(certDto.getCertNo());
					if(isValid) {
						//인증 성공하면 인증번호를 삭제
						certDao.delete(certDto.getCertEmail());
						return Map.of("result",true);
					}
				}
				return Map.of("result", false);
			}
	
	//비밀번호 재설정 메서드 추가
	//인증번호 생성 & 전송
	@PostMapping("/resetPassword")
	public void resetPassword(@RequestParam String certEmail) {
	    sendPwResetEmail(certEmail);
	}

	private void sendPwResetEmail(String certEmail) {
		Random r = new Random();
	    int no = r.nextInt(1000000);
	    DecimalFormat fm = new DecimalFormat("000000");
	    String certNo = fm.format(no);

	    // 발송
	    SimpleMailMessage message = new SimpleMailMessage();
	    message.setTo(certEmail);
	    message.setSubject("[MVC] 비밀번호 재설정 안내");
	    message.setText("인증번호 [ " + certNo + " ]");
	    sender.send(message);

	    // 기존 인증번호 삭제 및 새로운 인증번호 저장
	    certDao.delete(certEmail);
	    CertDto certDto = new CertDto();
	    certDto.setCertEmail(certEmail);
	    certDto.setCertNo(certNo);
	    certDao.insert(certDto);
	}
	
	
		//전송받은 인증번호 체크
	 @PostMapping("/checkEmail")
	    public Map<String, Object> checkEmail(@ModelAttribute CertDto certDto) {
	        CertDto findDto = certDao.selectOne(certDto.getCertEmail());
	        if (findDto != null) {
	            boolean isValid = findDto.getCertNo().equals(certDto.getCertNo());
	            if (isValid) {
	                certDao.delete(certDto.getCertEmail());
	                return Map.of("result", true);
	            }
	        }
	        return Map.of("result", false);
	    }

	

	
}
