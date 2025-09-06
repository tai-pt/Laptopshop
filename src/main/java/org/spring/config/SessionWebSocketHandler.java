package org.spring.config;

import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SessionWebSocketHandler extends TextWebSocketHandler {

    private final SessionRegistry sessionRegistry;

    public SessionWebSocketHandler(SessionRegistry sessionRegistry) {
        this.sessionRegistry = sessionRegistry;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        System.out.println("[WS] Connected: " + session.getId());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Object httpSessionId = session.getAttributes().get("HTTP.SESSION.ID");
        System.out.println("[WS] Disconnected: " + session.getId() + " | HTTP session: " + httpSessionId);

        if (httpSessionId instanceof String id) {
            sessionRegistry.removeSessionInformation(id);
            System.out.println("[WS] Removed HTTP session: " + id);
        }
    }
}
