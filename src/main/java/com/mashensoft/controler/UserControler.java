package com.mashensoft.controler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@RequestMapping("/admin/user/")
public class UserControler {
	Logger log = LoggerFactory.getLogger(UserControler.class);
	@Autowired
	UserMapper userMapper;
	@RequestMapping("/")
	public String home(){
		return "hello";
	}
	@RequestMapping("/userlist")
	public String userlist(){
		return "user/user_list";
	}
	@RequestMapping("/useredit/{userId}")
	public String useredit(@PathVariable Integer userId,Model model){
		if(userId!=null&&userId!=0){
			User user = userMapper.getUserById(userId);
			model.addAttribute("user",user);
		}
		return "user/user_edit";
	}
	@RequestMapping("/deleteUserById")
	@ResponseBody
	public String deleteUserById(Integer userId){
		int count = 0;
		try {
			 count = userMapper.deleteUserById(userId);
		} catch (Exception e) {
			
		}
		if(count<1){
			return "false";
		}
		return "true";
	}
	@RequestMapping("/addOrEditUser")
	@ResponseBody
	public String addOrEditUser(@RequestBody User user){
		if(user.getUserId()==null||user.getUserId()==0){
			userMapper.createUser(user);
		}else{
			userMapper.updateUser(user);
		}
		return "true";
	}
	@RequestMapping("/pagedata")
	@ResponseBody
	public ResponseData pagedata(Integer page,Integer limit,User user){
		log.info("page:{}",page);
		log.info("limit:{}",limit);
		int beginrow = (page-1)*limit;
		Map map = new HashMap();
		map.put("beginrow", beginrow);
		map.put("limit", limit);
		if(user.getUsername()!=null&&!"".equals(user.getUsername()));
		map.put("username", user.getUsername());
		if(user.getChineseName()!=null&&!"".equals(user.getChineseName()))
		map.put("chineseName", user.getChineseName());
		List<Object> list = userMapper.selectUserAsPageList(map);
		ResponseData rd = new ResponseData();
		Integer countNumber = userMapper.selectUserAsPageListCount(map);
		rd.setCode(0);
		rd.setCount(countNumber);
		rd.setData(list);
		rd.setMsg("msg");
		return rd;
	}
}
