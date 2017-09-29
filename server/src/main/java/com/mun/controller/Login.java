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
     *               get parameter from the URL according to the parameter
     * @param username
     *            用户名，一定要对应着表单的name才行
     *            user name which should be the same as the name in the form
     * @param password
     *            用户密码，也应该对应表单的数据项
     *            password which should be the password in the form
     * @param model
     *            一个域对象，可用于存储数据值
     *            model used to store value which want to pass to the front page
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(@RequestParam(value = "username", required = false) String username,@RequestParam(value = "password",required = false) String password, Model model){
        if(userService.login(username,password)){
            model.addAttribute("username", username);
            return "circuit";
        }else{
            model.addAttribute("fail", "Password wrong or user doesn't exist!");
            return "index";
        }
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "index";//for test consideration, set the circuit to the first page
    }
}
