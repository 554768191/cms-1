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

import com.mashensoft.mapper.ArticleMapper;
import com.mashensoft.mapper.CategoryMapper;
import com.mashensoft.model.Article;
import com.mashensoft.model.Category;
import com.mashensoft.util.ResponseData;

@Controller

@RequestMapping("/admin/article/")
public class ArticleControler {
	Logger log = LoggerFactory.getLogger(ArticleControler.class);
	@Autowired
	ArticleMapper articleMapper;
	@Autowired
	CategoryMapper categoryMapper;
	
	@RequestMapping("/")
	public String home(){
		return "hello";
	}
	@RequestMapping("/articlelist")
	public String articlelist(){
		return "article/article_list";
	}
	@RequestMapping("/articleedit/{articleId}")
	public String articleedit(@PathVariable Integer articleId,Model model){
		if(articleId!=null&&articleId!=0){
			Article article = articleMapper.getArticleById(articleId);
			model.addAttribute("article",article);
		}
		List<Category> categoryList = categoryMapper.getCategoryList();
		model.addAttribute("categoryList",categoryList);
		return "article/article_edit";
	}
	@RequestMapping("/deleteArticleById")
	@ResponseBody
	public String deleteArticleById(Integer articleId){
		int count = 0;
		try {
			 count = articleMapper.deleteArticleById(articleId);
		} catch (Exception e) {
			
		}
		if(count<1){
			return "false";
		}
		return "true";
	}
	@RequestMapping("/addOrEditArticle")
	@ResponseBody
	public String addOrEditArticle(@RequestBody Article article){
		if(article.getArticleId()==null||article.getArticleId()==0){
			articleMapper.createArticle(article);
		}else{
			articleMapper.updateArticle(article);
		}
		return "true";
	}
	@RequestMapping("/pagedata")
	@ResponseBody
	public ResponseData pagedata(Integer page,Integer limit,Article article){
		log.info("page:{}",page);
		log.info("limit:{}",limit);
		int beginrow = (page-1)*limit;
		Map map = new HashMap();
		map.put("beginrow", beginrow);
		map.put("limit", limit);
		if(article.getTitle()!=null&&!"".equals(article.getTitle()));
		map.put("title", article.getTitle());
//		if(article.getChineseName()!=null&&!"".equals(article.getChineseName()))
//		map.put("chineseName", article.getChineseName());
		List<Object> list = articleMapper.selectArticleAsPageList(map);
		ResponseData rd = new ResponseData();
		Integer countNumber = articleMapper.selectArticleAsPageListCount(map);
		rd.setCode(0);
		rd.setCount(countNumber);
		rd.setData(list);
		rd.setMsg("msg");
		return rd;
	}
}
