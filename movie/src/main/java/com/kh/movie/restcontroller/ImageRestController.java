package com.kh.movie.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.movie.dao.ImageDao;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "이미지 관리", description = "이미지 관리해용")
@CrossOrigin
@RestController
@RequestMapping("/image")
public class ImageRestController {
	
	@Autowired
	private ImageDao imageDao;

	
//	@PostMapping(value = "/image/", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//	public void upload(@RequestPart MultipartFile attach) {
//		log.debug("attach = {}", attach);
//	}
//	
	
	
}
