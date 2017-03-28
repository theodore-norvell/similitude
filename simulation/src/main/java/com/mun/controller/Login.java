package com.mun.controller;

import com.mun.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by wanhui on 23/03/2017.
 */
@Controller
@RequestMapping("/")
public class Login {

    @Autowired
    private UserService userService;

    /**
     * @RequestParam 注解的作用是：根据参数名从URL中取得参数值
     * @param username
     *            用户名，一定要对应着表单的name才行
     * @param password
     *            用户密码，也应该对应表单的数据项
     * @param model
     *            一个域对象，可用于存储数据值
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(@RequestParam(value = "username", required = false) String username,@RequestParam(value = "password",required = false) String password, Model model){
        if(userService.login(username,password)){
            model.addAttribute("username", username);
            return "circuit";
        }else{
            model.addAttribute("username", username);
            return "index";
        }
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "circuit";//for test consideration, set the circuit to the first page
    }
}
