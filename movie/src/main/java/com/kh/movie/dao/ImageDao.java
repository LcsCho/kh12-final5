package com.kh.movie.dao;

import com.kh.movie.dto.ImageDto;

public interface ImageDao {
	
	void insert(ImageDto imageDto);
	ImageDto selectOne(int imageNo);
	boolean delete(int imageNo);
	int sequence();	
}
