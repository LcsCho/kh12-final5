package com.kh.movie.vo;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "session")
@ToString(of = {"memberId", "memberLevel"})
public class ClientVO {
	@JsonIgnore
	private WebSocketSession session;
	private String memberId, memberLevel;
	
	public ClientVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.memberId = (String) attr.get("name");
		this.memberLevel = (String) attr.get("level");
	}
	
	public boolean isMember() {
		return memberId != null && memberLevel != null;
	}
	
	public void send(TextMessage message) throws IOException{
		session.sendMessage(message);
	}
}
