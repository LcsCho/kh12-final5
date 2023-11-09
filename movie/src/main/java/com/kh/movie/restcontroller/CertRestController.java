package com.kh.movie.restcontroller;

import java.text.DecimalFormat;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
		
	}
	
}
