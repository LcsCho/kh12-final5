package com.kh.movie;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Random;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.MovieWishDao;
import com.kh.movie.dao.PreferGenreDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.dto.PreferGenreDto;
import com.kh.movie.dto.RatingDto;

@SpringBootTest
public class MemberApplicationTests {

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    private int emailCounter = 1; // 순서대로 증가하는 숫자를 저장할 변수
    private int nicknameCounter = 1; // 순서대로 증가하는 숫자를 저장할 변수

    @Test
    public void createUser() {
        Random random = new Random();

        // 더미 회원 생성
        for (int i = 0; i < 450; i++) {
            // 테스트용 MemberDto 생성
            MemberDto testMember = new MemberDto();
            testMember.setMemberId(generateSequentialEmail());

            // 각각 다른 비밀번호 생성 및 암호화
            String originalPassword = "Testuser1!";//패스워드 통일
            testMember.setMemberPw(passwordEncoder.encode(originalPassword));

            testMember.setMemberNickname(generateSequentialNickname());
            testMember.setMemberBirth(generateRandomDateOfBirth());
            testMember.setMemberLevel("일반");
            testMember.setMemberGender(random.nextBoolean() ? "남자" : "여자"); // 성별 랜덤
            testMember.setMemberContact(generateRandomPhoneNumber());
            //testMember.setMemberJoin(generateRandomJoinDate());

            System.out.println(testMember);

            // 회원 등록
            memberDao.insert(testMember);
            
         // 영화 평점 생성 및 등록
            generateAndInsertMovieRatings(testMember.getMemberId());
            
            //generateAndInsertMemberPreferences(testMember.getMemberNickname());
        }
    }

    // 회원 아이디(이메일) 설정
    private String generateSequentialEmail() {
        String[] domains = {"com"};
        String email = "testuser" + emailCounter + "@movie." + domains[emailCounter % domains.length];
        emailCounter++;
        return email;
    }

    // 생년월일 설정
    private String generateRandomDateOfBirth() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        long beginTime = Timestamp.valueOf("1950-01-01 00:00:00").getTime();
        long endTime = Timestamp.valueOf("2013-01-01 00:00:00").getTime();
        long diff = endTime - beginTime + 1;
        return dateFormat.format(new Date(beginTime + (long) (Math.random() * diff)));
    }

    // 연락처 설정
    private String generateRandomPhoneNumber() {
        Random random = new Random();
        StringBuilder phoneNumber = new StringBuilder("010");

        phoneNumber.append(random.nextInt(8) + 1);
        for (int i = 0; i < 7; i++) {
            phoneNumber.append(random.nextInt(10));
        }

        return phoneNumber.toString();
    }

    // 닉네임 설정
    private String generateSequentialNickname() {
        String baseNickname = "무비유저";
        String generatedNickname = baseNickname + nicknameCounter;
        nicknameCounter++;
        return generatedNickname;
    }
//    
//    //가입일 설정
//    private Date generateRandomJoinDate() {
//        long beginTime = Timestamp.valueOf("2021-01-01 00:00:00").getTime();
//        long endTime = Timestamp.valueOf("2023-11-23 23:59:59").getTime();
//        long diff = endTime - beginTime + 1;
//        return new Date(beginTime + (long) (Math.random() * diff));
//    }
    
    
    
// // 영화 평점 생성 및 등록 메서드
//    private void generateAndInsertMovieRatings(String memberId) {
//        Random random = new Random();
//
//     // 영화 평점을 125편의 영화에 대해 생성
//        for (int movieNo = 1; movieNo <= 140; movieNo++) {
//            // 특정 영화에 대한 회원의 평점이 이미 존재하는지 확인
//            if (!ratingDao.existsByMovieNoAndMemberId(movieNo, memberId)) {
//                // 테스트용 RatingDto 생성
//                RatingDto ratingDto = new RatingDto();
//                ratingDto.setRatingNo(random.nextInt());
//                ratingDto.setMovieNo(movieNo);
//                ratingDto.setMemberId(memberId);
//
//                // 2 이상부터 5까지 0.5 단위로 랜덤한 평점 부여
//                float ratingScore = 2.0f + (random.nextInt() * 3);
//                ratingDto.setRatingScore(ratingScore);
//                
//                ratingDto.setRatingDate(new Date(System.currentTimeMillis()));
//
//                // 평점 등록
//                ratingDao.insert(ratingDto);
//        }
//    }
//}

    @Autowired
    private RatingDao ratingDao;
    
    // 영화 평점 생성 및 등록 메서드
    private void generateAndInsertMovieRatings(String memberId) {
        Random random = new Random();

        // 영화 평점을 140편의 영화에 대해 생성
        for (int movieNo = 1; movieNo <= 142; movieNo++) {
            // 특정 영화에 대한 회원의 평점이 이미 존재하는지 확인
            if (!ratingDao.existsByMovieNoAndMemberId(movieNo, memberId)) {
                // 테스트용 RatingDto 생성
                RatingDto ratingDto = new RatingDto();
                ratingDto.setMovieNo(movieNo);
                ratingDto.setMemberId(memberId);

                // 2.0에서 5.0 사이의 랜덤한 평점 부여
                float ratingScore = 2.0f + (random.nextInt(7) * 0.5f);
                ratingDto.setRatingScore(ratingScore);

                ratingDto.setRatingDate(new Date(System.currentTimeMillis()));

                // 평점 등록
                ratingDao.insert(ratingDto);
            }
        }
    }
}