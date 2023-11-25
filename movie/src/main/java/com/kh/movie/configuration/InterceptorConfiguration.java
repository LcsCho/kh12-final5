package com.kh.movie.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.movie.interceptor.MemberInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private MemberInterceptor memberInterceptor;

	public void addInterceptors(InterceptorRegistry registry) {
		
//		registry.addInterceptor(memberInterceptor)
//				.addPathPatterns(//비회원일 때 불가능
//						"/member/**"
//					)
//				.excludePathPatterns(//비회원일 때 가능
//						"/member/join",
//						"/member/joinFinish",
//						"/member/login",
//						"/member/idCheck",
//						"/member/nicknameCheck",
//						"/member/changePw"
//
//						
//						
//						);
	}
	
	
	
	
	
	
}
