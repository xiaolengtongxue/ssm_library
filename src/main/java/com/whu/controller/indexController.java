package com.whu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class indexController {
//    shiro

    @RequestMapping(value = "/")
    public String index(HttpSession httpSession){
        if(httpSession.getAttribute("user")!=null)
            return "index";
        else
            return "login";
    }
}
