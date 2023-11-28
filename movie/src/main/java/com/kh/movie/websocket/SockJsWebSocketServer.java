package com.kh.movie.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.movie.dao.ChatDao;
import com.kh.movie.dto.ChatDto;
import com.kh.movie.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SockJsWebSocketServer extends TextWebSocketHandler{
	
	private Set<ClientVO> clients = new CopyOnWriteArraySet<>();
	private Set<ClientVO> members = new CopyOnWriteArraySet<>();
	
	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		ClientVO client = new ClientVO(session);
		clients.add(client);
		
		if(client.isMember()) members.add(client);
		
//		log.debug("사용자 접속! 현재 {}명", clients.size());
//		log.debug("접속한 사용자 = {}", clients);
		
		sendClientList();
		sendMessageList(client);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		ClientVO client = new ClientVO(session);
		clients.remove(client);
		
		if(client.isMember()) members.remove(client);
		
//		log.debug("사용자 접속종료! 현재 {}명", clients.size());
		
		sendClientList();
	}
	
	public void sendClientList() throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> data = new HashMap<>();
		data.put("clients", members);
		String clientJson = mapper.writeValueAsString(data);
		
		TextMessage message = new TextMessage(clientJson);
		for(ClientVO client : clients) client.send(message);
	}
	
	public void sendMessageList(ClientVO client) throws IOException {
		List<ChatDto> list = chatDao.selectList();
		 
		for(ChatDto chatDto : list) {
			Map<String, Object> map = new HashMap<>();
			map.put("content", chatDto.getChatContent());
			map.put("memberId", chatDto.getChatSender());
			map.put("memberLevel", chatDto.getChatSenderLevel());
			String messageJson = mapper.writeValueAsString(map);
			TextMessage message = new TextMessage(messageJson);
			client.send(message);
		}
	}
	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
		ClientVO client = new ClientVO(session);
		if(client.isMember() == false) return;
		
		Map params = mapper.readValue(message.getPayload(), Map.class);
		boolean isAllChat = params.get("target") == null;
		if(isAllChat) {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", client.getMemberId());
			map.put("memberLevel", client.getMemberLevel());
			map.put("content", params.get("content"));
			
			String messageJson = mapper.writeValueAsString(map);
			TextMessage tm = new TextMessage(messageJson);
			
			for(ClientVO c : clients) {
				c.send(tm);
			}
			
			chatDao.insert(ChatDto.builder()
					.chatContent((String) params.get("content"))
					.chatSender(client.getMemberId())
					.chatSenderLevel(client.getMemberLevel())
					.build());
		}
		
	}
	
}
