package com.kh.movie;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.Random;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dto.MemberDto;

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
        for (int i = 0; i < 1000; i++) {
            // 테스트용 MemberDto 생성
            MemberDto testMember = new MemberDto();
            testMember.setMemberId(generateSequentialEmail());

            // 각각 다른 비밀번호 생성 및 암호화
            String originalPassword = "Testpw" + i + "!";
            testMember.setMemberPw(passwordEncoder.encode(originalPassword));

            testMember.setMemberNickname(generateSequentialNickname());
            testMember.setMemberBirth(generateRandomDateOfBirth());
            testMember.setMemberLevel("일반");
            testMember.setMemberGender(random.nextBoolean() ? "남자" : "여자"); // 성별 랜덤
            testMember.setMemberContact(generateRandomPhoneNumber());
            testMember.setMemberJoin(generateRandomJoinDate());

            System.out.println(testMember);

            // 회원 등록
            memberDao.insert(testMember);
        }
    }

    // 회원 아이디(이메일) 설정
    private String generateSequentialEmail() {
        String[] domains = {"com", "co.kr", "net"};
        String email = "user" + emailCounter + "@movie." + domains[emailCounter % domains.length];
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
    
    //가입일 설정
    private Date generateRandomJoinDate() {
        long beginTime = Timestamp.valueOf("2021-01-01 00:00:00").getTime();
        long endTime = Timestamp.valueOf("2023-11-23 23:59:59").getTime();
        long diff = endTime - beginTime + 1;
        return new Date(beginTime + (long) (Math.random() * diff));
    }
}
