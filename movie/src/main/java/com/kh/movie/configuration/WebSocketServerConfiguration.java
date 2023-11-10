package com.kh.movie.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.movie.websocket.SockJsWebSocketServer;

@EnableWebSocket
@Configuration
public class WebSocketServerConfiguration implements WebSocketConfigurer{
	
	@Autowired
	private SockJsWebSocketServer sockJswebSocketServer;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		registry.addHandler(sockJswebSocketServer, "/ws/sockjs")
		.addInterceptors(new HttpSessionHandshakeInterceptor())
		.withSockJS();
	}
	
	
}
