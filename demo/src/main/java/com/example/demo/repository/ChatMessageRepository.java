package com.example.demo.repository;

import com.example.demo.model.ChatMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;




public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    @Query("select c from ChatMessage c order by c.sendingTime desc ")
    Page<ChatMessage> findMessage(Pageable pageable);

}
