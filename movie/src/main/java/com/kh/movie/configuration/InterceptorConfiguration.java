package com.kh.movie.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.movie.interceptor.MemberInterceptor;
import com.kh.movie.interceptor.MovieDefenderInterceptor;
import com.kh.movie.interceptor.ReviewDefenderInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private MovieDefenderInterceptor movieDefenderInterceptor;
	
	@Autowired
	private ReviewDefenderInterceptor reviewDefenderInterceptor;

	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns(//비회원일 때 불가능
				"/member/**"
				)
				.excludePathPatterns(//비회원일 때 가능
				"/member/join", 
				"/member/joinFinish"
				);
		registry.addInterceptor(movieDefenderInterceptor)
				.addPathPatterns(
				"/movie/detail"	,
				"/movie/review/list",
				"/movie/review/detail"
				);
		registry.addInterceptor(reviewDefenderInterceptor)
				.addPathPatterns(
				"/movie/review/detail"
				);
		
		
	}
	
	
	
	
	
	
}
