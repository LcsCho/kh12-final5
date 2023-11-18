package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.vo.MVCCriticTop10RecommendVO;
import com.kh.movie.vo.MVCTop10RecommendVO;

public interface RecommendDao {

	List<MVCTop10RecommendVO> getMVCTop10();

	List<MVCCriticTop10RecommendVO> getMVCCriticTop10();

}
