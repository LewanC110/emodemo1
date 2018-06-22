package com.neuedu.controller;

import com.neuedu.entity.User;
import com.neuedu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping(value = {"/user"})
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/registView"})
    public String registView(){

        return "regist";
    }



    @RequestMapping(value = {"/checkUsername"})
    public void checkUsername(String username, HttpServletResponse resp) throws IOException {
        //根据用户名查询用户
        User user = userService.getUserByUserName(username);
        PrintWriter out = resp.getWriter();
        if(user == null){
            out.print(true);
        }else{
            out.print(false);
        }
    }

    @RequestMapping(value = {"/regist"})
    public String regist(){
        System.out.println(1);
        return "";
    }
}
