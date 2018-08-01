package com.mashensoft.controler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mashensoft.mapper.UserMapper;
import com.mashensoft.model.User;
import com.mashensoft.util.ResponseData;

@Controller

@RequestMapping("/")
public class SystemControler {
	Logger log = LoggerFactory.getLogger(SystemControler.class);
	@Autowired
	UserMapper userMapper;
	@Autowired
	@RequestMapping("/index")
	public String home(){
		return "admin_index";
	}
	@RequestMapping("/login")
	public String login(){
		return "/login/login";
	}
	@RequestMapping("/dologin")
	public String dologin(User forUser,HttpServletRequest request){
		User user = userMapper.getUserByUsernamePassword(forUser);
		if(user!=null){
			HttpSession session = request.getSession();
			if(session.getAttribute("user")==null){
				//如果Session里没有user,就把当前的user放进去
				session.setAttribute("user",user );
				
			}
			return "admin_index";
		}else{
			return "redirect:/login/login.jsp";
		}
	}
	@RequestMapping("/logout")
	public String dologin(HttpServletRequest request){
		request.getSession().invalidate();
			return "redirect:/login/login.jsp";
	}
	
}
