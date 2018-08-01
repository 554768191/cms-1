<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>表单模块 - layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">

<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<script type="text/javascript" charset="utf-8"
	src="${path }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${path }/ueditor/ueditor.all.min.js">
	
</script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="${path }/ueditor/lang/zh-cn/zh-cn.js"></script>

<style>
body {
	padding: 10px;
}
</style>
</head>
<body>


	<form class="layui-form layui-form-pane1" action="">
		<input type="hidden" name="articleId" id="articleId"
			value="${article.articleId }">
<div class="layui-form-item">
    <label class="layui-form-label">分类</label>
    <div class="layui-input-block" style="z-index:1000">
      <select name="categoryId" lay-verify="required" id="categoryId">
        <option value=""></option>
        <c:forEach items="${categoryList }" var="category">
        <c:choose>
        <c:when test="${article.categoryId==category.categoryId }">
        <option value="${category.categoryId }" selected="selected">编号：${category.categoryId } 分类名称：${category.name }</option>
        
        </c:when>
        <c:otherwise>
        <option value="${category.categoryId }">编号：${category.categoryId } 分类名称：${category.name }</option>
        </c:otherwise>
        </c:choose>
        </c:forEach>
      </select>
    </div>
  </div>
		<div class="layui-form-item">
			<label class="layui-form-label">标题</label>
			<div class="layui-input-block">
				<input type="text" name="title" id="title"
					lay-verify="required|articlename" required placeholder="请输入标题"
					autocomplete="off" class="layui-input" value="${article.title }">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">内容</label>
			<div class="layui-input-block">
				<script id="editor" type="text/plain"
					style="width: 100%; height: 300px;"></script>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="*">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>

	<br>
	<br>
	<br>


	<script src="${path}/layui/layui.js"></script>
	<!-- <script src="../build/lay/dest/layui.all.js"></script> -->

	<script>
		layui.use('form', function() {
			var form = layui.form;
			var boolean = false;
			//自定义验证规则
			form.verify({
				articlename : function(value) {
					if (value.length < 2) {
						return '文章标题也太短了吧';
					}
				},
				pass : [ /(.+){6,12}$/, '密码必须6到12位' ]
			});
			//监听提交
			form.on('submit(*)', function(data2) {
				$.ajax({
					url : "/admin/article/addOrEditArticle",
					method : "POST",
					data : JSON.stringify({
						"categoryId":$("#categoryId").val(),
						"articleId" : $("#articleId").val(),
						"title" : $("#title").val(),
						"content" : UE.getEditor('editor').getContent()
					}),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function(message) {
						console.info("成功" + message);
						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index);
					},
					error : function(message) {
						console.info("失败" + message);
					}
				});

				return false;
			});

		});
	</script>

	<script>
		var ue = UE.getEditor('editor');
		ue.addListener("ready", function() {
			ue.setContent('${article.content}');
		});
	</script>
</body>
</html>
