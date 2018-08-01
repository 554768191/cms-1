package com.mashensoft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mashensoft.model.User;
import com.mashensoft.mybatis.plugin.PageInfo;

public interface UserMapper {
	public User getUserByUsernamePassword(User user);
	public List<User> getUserList();
	public User getUserById(Integer userId);

	public int createUser(User user);

	public int updateUser(User user);

	public int deleteUserById(Integer userId);

	public List<User> selectUserListPage(@Param("page") PageInfo page);
	public List<Object> selectUserAsPageList(Map map);
	public Integer selectUserAsPageListCount(Map map);
}
