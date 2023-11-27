package com.kh.movie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.movie.dao.ReviewDao;
import com.kh.movie.error.NoTargetException;
import com.kh.movie.vo.ReviewListVO;

@Component
public class ReviewDefenderInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		int movieNo = Integer.parseInt(request.getParameter("movieNo"));
		ReviewListVO reviewListVO = reviewDao.findByReviewNo(reviewNo,movieNo);
		if(reviewListVO == null) {
			throw new NoTargetException("존재하지 않는 리뷰");
		}
		return true;
	}

}
