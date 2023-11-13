package com.kh.movie.dao;

import com.kh.movie.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	boolean deleteOver5min();
	CertDto selectOne(String certEmail);
	CertDto selectOneIn5min(String certEmail);

}
