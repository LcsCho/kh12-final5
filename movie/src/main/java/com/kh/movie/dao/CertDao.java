package com.kh.movie.dao;

import com.kh.movie.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	boolean deleteOver5min();
	CertDto selectOne(String certEmail);
	CertDto selectOneIn5min(String certEmail);
	
	//비밀번호 재설정 관련 메서드 추가
	 void addPwReset(CertDto certDto);
	 boolean removePwReset(String certEmail);
	 CertDto findByPwReset(String certEmail);

}
