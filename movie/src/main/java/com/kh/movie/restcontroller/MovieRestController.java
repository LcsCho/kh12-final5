package com.kh.movie.restcontroller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화 관리", description = "영화 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movie")
public class MovieRestController {

}
