<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="/layui/css/layui.css">

<style>
body {
	padding: 10px;
}
</style>
</head>
<body>


	<form class="layui-form layui-form-pane1" action="">
	<input type="hidden" name="categoryId" id="categoryId"  value="${category.categoryId }">
		<div class="layui-form-item">
			<label class="layui-form-label">name</label>
			<div class="layui-input-block">
				<input type="text" name="name" id="name" 
					required placeholder="请输入账号" autocomplete="off" class="layui-input" value="${category.name }">
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


	<script src="/layui/layui.js"></script>
	<!-- <script src="../build/lay/dest/layui.all.js"></script> -->

	<script>
		layui.use('form', function() {
			var form = layui.form;
			var boolean = false;
			//自定义验证规则
			form.verify({
				name : function(value) {
					if (value.length < 5) {
						return '用户名也太短了吧';
					}
				},
				pass : [ /(.+){6,12}$/, '密码必须6到12位' ]
			});
			//监听提交
			form.on('submit(*)', function(data2) {
				$.ajax({
					url : "/admin/category/addOrEditCategory",
					method : "POST",
					data : JSON.stringify({
						"categoryId":$("#categoryId").val(),
						"name" : $("#name").val()
					}),
					dataType : "json",
					contentType: "application/json; charset=utf-8",
					 success: function (message) {
						 console.info("成功"+message);
							 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							 parent.layer.close(index); 
				        },
				        error: function (message) {
				           console.info("失败"+message);
				        }
				});
				return false;
			});

		});
	</script>


</body>
</html>
