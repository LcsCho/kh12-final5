package com.kh.movie.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.movie.dao.RecommendDao;
import com.kh.movie.dao.SearchDao;
import com.kh.movie.dto.TodayRecommendDto;
import com.kh.movie.vo.TodayMovieListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchedulerImpl implements Scheduler {

	@Autowired
	private RecommendDao recommendDao;

	@Autowired
	private SearchDao searchDao;

	// 매일 자정
	@Override
	@Scheduled(cron = "0 0 0 * * *")
	public void getRandomMovies() {
		recommendDao.deleteRandom();

		List<TodayMovieListVO> allMovieList = recommendDao.getTodayList();

		// 리스트를 섞습니다.
		Collections.shuffle(allMovieList);

		// 필요한 수만큼 요소를 선택합니다.
		int size = Math.min(10, allMovieList.size());
		List<TodayMovieListVO> randomMovieList = allMovieList.subList(0, size);

		TodayRecommendDto todayRecommendDto = new TodayRecommendDto();
		for (TodayMovieListVO randomMovie : randomMovieList) {
			BeanUtils.copyProperties(randomMovie, todayRecommendDto);
			recommendDao.saveRandom(todayRecommendDto);
		}
	}

}
