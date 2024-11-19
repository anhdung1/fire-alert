package com.example.demo.service;

import com.example.demo.DTO.ChatMessageResponse;
import com.example.demo.model.ChatMessage;
import com.example.demo.model.Users;
import com.example.demo.repository.ChatMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ChatMessageService {
    @Autowired
    private ChatMessageRepository chatMessageRepository;
    @Autowired
    private UsersService usersService;
    public ChatMessageRepository getChatMessageRepository() {
        return chatMessageRepository;
    }
    public ChatMessage save(String content,Users user) {
        ChatMessage chatMessage = new ChatMessage();
        chatMessage.setContent(content);
        chatMessage.setSender(user);
        LocalDateTime now = LocalDateTime.now();
        chatMessage.setSendingTime(Timestamp.valueOf(now));
        chatMessageRepository.save(chatMessage);
        return chatMessage;
    }
    public ChatMessageResponse transferToChatMessageResponse(ChatMessage chatMessage) {
        ChatMessageResponse chatMessageResponse = new ChatMessageResponse();
        chatMessageResponse.setContent(chatMessage.getContent());
        chatMessageResponse.setSenderId(chatMessage.getSender().getId());
        chatMessageResponse.setSendingTime(chatMessage.getSendingTime());
        chatMessageResponse.setName(chatMessage.getSender().getUserInfo().getName());
        chatMessageResponse.setImageUrl(chatMessage.getSender().getUserInfo().getImageUrl());
        return chatMessageResponse;
    }
    public List<ChatMessageResponse> transferToChatMessageResponseList(List<ChatMessage> chatMessages) {
        List<ChatMessageResponse> chatMessageResponseList = new ArrayList<>();
        for(ChatMessage chatMessage : chatMessages) {
            chatMessageResponseList.add(transferToChatMessageResponse(chatMessage));
        }
        return chatMessageResponseList;
    }

}
