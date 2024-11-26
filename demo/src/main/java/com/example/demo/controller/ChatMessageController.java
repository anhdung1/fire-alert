package com.example.demo.controller;

import com.example.demo.DTO.ChatMessageRequest;

import com.example.demo.model.ChatMessage;
import com.example.demo.model.Users;
import com.example.demo.service.ChatMessageService;
import com.example.demo.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
public class ChatMessageController {
    @Autowired
    private UsersService usersService;
    @Autowired
    private ChatMessageService chatMessageService;
    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic")
    public Object sendMessage(@Payload ChatMessageRequest chatMessageRequest, @Header("x-api-key") String apiKey) {
        try{
            Users user= usersService.getUsersRepository().findByApiKey(apiKey);

            if(user==null)
                return null;
            ChatMessage chatMessage  =  chatMessageService.save(chatMessageRequest.getContent(),user);
             return chatMessageService.transferToChatMessageResponse(chatMessage);
        }catch (Exception e){
            System.out.println(e.toString());
            return null;

        }

    }
    @GetMapping("chat-history")
    public ResponseEntity<?> getChatMessages(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "30") int size) {
        Pageable pageable= PageRequest.of(page, size);
        List<ChatMessage> chatMessageList=chatMessageService.getChatMessageRepository().findMessage(pageable).getContent();
       return  ResponseEntity.ok(chatMessageService.transferToChatMessageResponseList(chatMessageList));

    }
}
