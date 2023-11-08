package com.kh.movie.service;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailServiceImpl implements EmailService{
	
	@Autowired
	private JavaMailSender sender;
	
	@Override
	public void sendCelebration(String email) throws MessagingException, IOException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,false,"UTF-8");
		
		helper.setTo(email);
		helper.setSubject("[MVC]가입을 축하합니다!");
		
		ClassPathResource resource = new ClassPathResource("templates/celebration.html");
		Document doc = Jsoup.parse(resource.getFile(), "UTF-8");
		
		//수신자 표시
		Element target = doc.getElementById("target");
		target.text(email);
		
		//로그인 링크 작성
		Element link = doc.getElementById("login-link");
//		link.attr("href","/scure/login");//절대경로지만 안됨(다른 사이트에서 실행하기 때문)
		
		//주소를 현재 상황에 맞게 생성하는 도구 사용
		//http://localhost/8080 까지 알아서 자동 생성
		String href = ServletUriComponentsBuilder.fromCurrentContextPath()//현재의 context path에서
													.path("/member/login")//세부 경로를 더하고
													.build()//만든 다음
													.toUriString();//문자열로 바꿔라
		link.attr("href",href);
		
		
		helper.setText(doc.toString(),true);
		
		sender.send(message);
		
	}

}
