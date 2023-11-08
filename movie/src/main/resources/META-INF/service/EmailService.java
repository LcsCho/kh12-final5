package com.kh.movie.service;

import java.io.IOException;

import javax.mail.MessagingException;

public interface EmailService {
	void sendCelebration(String email) throws MessagingException, IOException;
}
