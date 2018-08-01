package com.mashensoft.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.mashensoft.main.Springboot2Application;
import com.mashensoft.model.Category;
import com.mashensoft.model.User;
import com.mashensoft.mybatis.plugin.PageInfo;
import com.mashensoft.util.MD5Util;

@RunWith(SpringRunner.class)
@SpringBootTest(classes=Springboot2Application.class)
//@Transactional
public class UserMapperTest {
	@Autowired
	UserMapper userMapper;
	@Autowired
	CategoryMapper categoryMapper;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetUserList() {
		List<User> userList = userMapper.getUserList();
		Assert.assertEquals(1,userList.size());
	}
	
	@Test
	public void testCreateUser() {
		User user = new User();
		user.setUsername("zongxing");
		user.setChineseName("宗星");
		user.setPassword("123456");
		user.setCreateTime(new Date());
		int count = userMapper.createUser(user);
		Assert.assertEquals(1,count);
	}
	@Test
	public void testUpdateUser() {
		User user = new User();
		user.setUserId(7);
//		user.setUsername("zongxing");
//		user.setChineseName("宗星");
		user.setPassword("123567");
		user.setUpdateTime(new Date());
		int count = userMapper.updateUser(user);
		Assert.assertEquals(1,count);
	}
	@Transactional
	@Test
	public void testDeleteUserById() {
		int count = userMapper.deleteUserById(7);
		Assert.assertEquals(1,count);
	}
	@Test
	public void testSelectUserListPage() {
		int pageSize = 1;
		int currentPage = 1;
		int currentRow = (currentPage-1)*pageSize;
		PageInfo page = new PageInfo();
		page.setCurrentResult(currentRow);
		page.setShowCount(pageSize);
		List<User> list = userMapper.selectUserListPage(page);
		Assert.assertEquals(1,list.size());
	}
	@Test
	public void testSelectUserAsPageList() {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("username", "b");
		map.put("begin", 0);
		map.put("size", 1);
		List<Object> list = userMapper.selectUserAsPageList(map);
		Assert.assertEquals(1,list.size());
	}
	@Test
	public void testBatchInsert() {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("username", "b");
//		map.put("begin", 0);
//		map.put("size", 1);
//		List<Object> list = userMapper.selectUserAsPageList(map);
//		Assert.assertEquals(1,list.size());
		for(int j=0;j<10;j++){
			List<Category> list = new ArrayList<>();
			for(int i=0;i<5000;i++){
				Category c =new Category();
				c.setName(UUID.randomUUID().toString());
				list.add(c);
			}
			int count = categoryMapper.batchInsert(list);
			System.out.println("count:"+count);
		}
	}

}
