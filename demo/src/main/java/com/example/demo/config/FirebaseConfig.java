package com.example.demo.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.io.FileInputStream;
import java.io.IOException;

@Configuration
public class FirebaseConfig {
    @PostConstruct
    public void initializeFirebase() throws IOException {
        FileInputStream serviceAccount =
                new FileInputStream("D://Dowloads//fire-alarm-4b1a5-firebase-adminsdk-76wyb-7d9150dca6.json");

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://fire-alarm-4b1a5-default-rtdb.firebaseio.com")
                .build();

        FirebaseApp.initializeApp(options);

        System.out.println("Firebase initialized using Firebase Admin SDK 9.4.1!");
    }

}
