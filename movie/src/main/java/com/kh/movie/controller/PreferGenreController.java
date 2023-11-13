package com.kh.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.PreferGenreDao;
import com.kh.movie.dto.PreferGenreDto;

@Controller
@RequestMapping("/preferGenre")
public class PreferGenreController {

	@Autowired
	private PreferGenreDao preferGenreDao;
	
	@PostMapping("/save")
	public void insert(@RequestBody PreferGenreDto preferGenreDto) {
		preferGenreDao.insert(preferGenreDto);
	}
}
