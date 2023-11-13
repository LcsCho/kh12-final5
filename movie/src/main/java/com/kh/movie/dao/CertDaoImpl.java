package com.kh.movie.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.CertDto;
import com.kh.movie.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class CertDaoImpl implements CertDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CertDto certDto) {
		sqlSession.insert("cert.add", certDto);
	}

	@Override
	public boolean delete(String certEmail) {
		return sqlSession.delete("cert.remove",certEmail) > 0;
	}

	@Override
	public boolean deleteOver5min() {
		return sqlSession.delete("cert.deleteOver5min") > 0;
	}

	@Override
	public CertDto selectOne(String certEmail) {
		CertDto certDto = sqlSession.selectOne("cert.findByCertEmail", certEmail);
		return certDto;
	}

	@Override
	public CertDto selectOneIn5min(String certEmail) {
		return sqlSession.selectOne("cert.selectOneIn5min",certEmail);
	}
}
