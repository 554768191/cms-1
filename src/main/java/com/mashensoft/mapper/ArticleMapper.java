package com.mashensoft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mashensoft.model.Article;
import com.mashensoft.mybatis.plugin.PageInfo;

public interface ArticleMapper {
	public List<Article> getArticleList();
	public Article getArticleById(Integer ArticleId);

	public int createArticle(Article Article);

	public int updateArticle(Article Article);

	public int deleteArticleById(Integer ArticleId);

	public List<Article> selectArticleListPage(@Param("page") PageInfo page);
	public List<Object> selectArticleAsPageList(Map map);
	public Integer selectArticleAsPageListCount(Map map);
}
