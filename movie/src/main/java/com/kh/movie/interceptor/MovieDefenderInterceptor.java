package com.kh.movie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.error.NoTargetException;

@Component
public class MovieDefenderInterceptor implements HandlerInterceptor {

	@Autowired
	private MovieDao movieDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int movieNo =Integer.parseInt(request.getParameter("movieNo"));
		MovieDto movieDto =movieDao.findByMovieNo(movieNo);
		if(movieDto == null) {
			throw new NoTargetException("존재하지 않는 영화");
		}
		return true;
	}
	
	
}
