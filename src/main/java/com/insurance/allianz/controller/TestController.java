package com.insurance.allianz.controller;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/test")
public class TestController {

    @GetMapping("/test-one")
    public String test () {
        return "Application test endpoint is working.....";
    }

    @PostConstruct
    public void init() {
        log.info("Application working....");
    }
}
