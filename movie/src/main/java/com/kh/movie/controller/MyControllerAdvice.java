package com.kh.movie.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MyControllerAdvice {
	private static final Logger logger = LoggerFactory.getLogger(MyControllerAdvice.class);

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e) {
        // 로그 출력
        logger.error("Exception occurred: ", e);
        // 예외 처리 로직 추가
        return "error";
    }
}
