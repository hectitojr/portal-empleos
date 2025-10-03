package com.zoedatalab.empleos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class JobPortalApplication {
    public static void main(String[] args) {
        SpringApplication.run(JobPortalApplication.class, args);
    }
}
