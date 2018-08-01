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

import com.mashensoft.mapper.CategoryMapper;
import com.mashensoft.model.Category;
import com.mashensoft.model.User;
import com.mashensoft.util.ResponseData;

@Controller

@RequestMapping("/admin/category/")
public class CategoryControler {
	Logger log = LoggerFactory.getLogger(CategoryControler.class);
	@Autowired
	CategoryMapper categoryMapper;
	@RequestMapping("/categorylist")
	public String categorylist(){
		return "category/category_list";
	}
	@RequestMapping("/categoryedit/{categoryId}")
	public String useredit(@PathVariable Integer categoryId,Model model){
		if(categoryId!=null&&categoryId!=0){
			Category category = categoryMapper.getCategoryById(categoryId);
			model.addAttribute("category",category);
		}
		return "category/category_edit";
	}
	@RequestMapping("/deleteCategoryById")
	@ResponseBody
	public String deleteCategoryById(Integer categoryId){
		int count = 0;
		try {
			 count = categoryMapper.deleteCategoryById(categoryId);
		} catch (Exception e) {
			
		}
		if(count<1){
			return "false";
		}
		return "true";
	}
	@RequestMapping("/addOrEditCategory")
	@ResponseBody
	public String addOrEditCategory(@RequestBody Category category){
		if(category.getCategoryId()==null||category.getCategoryId()==0){
			categoryMapper.createCategory(category);
		}else{
			categoryMapper.updateCategory(category);
		}
		return "true";
	}
	@RequestMapping("/pagedata")
	@ResponseBody
	public ResponseData pagedata(Integer page,Integer limit,Category category){
		log.info("page:{}",page);
		log.info("limit:{}",limit);
		int beginrow = (page-1)*limit;
		Map map = new HashMap();
		map.put("beginrow", beginrow);
		map.put("limit", limit);
//		if(user.getUsername()!=null&&!"".equals(user.getUsername()));
//		map.put("username", user.getUsername());
		if(category.getName()!=null&&!"".equals(category.getName()))
		map.put("name", category.getName());
		List<Object> list = categoryMapper.selectCategoryAsPageList(map);
		ResponseData rd = new ResponseData();
		Integer countNumber = categoryMapper.selectCategoryAsPageListCount(map);
		rd.setCode(0);
		rd.setCount(countNumber);
		rd.setData(list);
		rd.setMsg("msg");
		return rd;
	}
	@RequestMapping("/test")
	@ResponseBody
	public String test(){
		Thread t = new Thread(new Runnable() {
			
			@Override
			public void run() {
				int i=0;
				try {
					for (int j = 0; j < 100; j++) {
						Thread.currentThread().sleep(1000);
						System.out.println(Thread.currentThread().getName()+","+i++);
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		});
		t.start();
		return "hello";
	}
}
