package com.mashensoft.mapper;

import java.util.List;
import java.util.Map;

import com.mashensoft.model.Category;
import com.mashensoft.model.User;

public interface CategoryMapper {
	public List<Category> getCategoryList();
	public Category getCategoryById(Integer userId);

	public int createCategory(Category category);

	public int updateCategory(Category category);

	public int deleteCategoryById(Integer userId);

	public List<Object> selectCategoryAsPageList(Map map);
	public Integer selectCategoryAsPageListCount(Map map);
	
	
	public int batchInsert(List<Category> list);
}
