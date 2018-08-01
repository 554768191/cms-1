<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/common.jsp"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>layout 后台大布局 - Layui</title>
<style>
html, body, .layui-body, .layui-body>div, .layui-tab-content, .layui-tab,
	.layui-tab-content>div {
	height: 100%;
}

iframe {
	border: 0;
	width: 100%;
	height: 100%;
}
</style>
<link rel="stylesheet" href="${path}/layui/css/layui.css" media="all">
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>


</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">layui 后台布局</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">控制台</a></li>
				<li class="layui-nav-item"><a href="">商品管理</a></li>
				<li class="layui-nav-item"><a href="">用户</a></li>
				<li class="layui-nav-item"><a href="javascript:;">其它系统</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">邮件管理</a>
						</dd>
						<dd>
							<a href="">消息管理</a>
						</dd>
						<dd>
							<a href="">授权管理</a>
						</dd>
					</dl></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> 
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">基本资料</a>
						</dd>
						<dd>
							<a href="">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="${path }/login/login.jsp">退了</a></li>
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item layui-nav-itemed"><a class=""
						href="javascript:;">系统管理</a>
						<dl class="layui-nav-child">
							<dd id="mytest1">
								<a href="javascript:;" dataurl="${path }/admin/user/userlist">用户管理</a>
							</dd>

						</dl></li>
					<li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">业务管理</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" dataurl="${path }/admin/category/categorylist">文章分类管理</a>
							</dd>
							<dd>
								<a href="javascript:;" dataurl="${path }/admin/article/articlelist">文章管理</a>
							</dd>
						</dl></li>
				</ul>
			</div>
		</div>
		<div class="layui-body">
			<!-- 内容主体区域 begin-->
			<div style="padding: 15px;">
				<div class="layui-tab" lay-allowClose="true" lay-filter="demo">
					<ul class="layui-tab-title">
					</ul>
					<div class="layui-tab-content">
					</div>
				</div>
			</div>
		</div>
		<script src="${path}/layui/layui.js"></script>
		<script>
			layui.use('element', function() {
				var $ = layui.jquery, element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

				//触发事件
				var active = {
					tabAdd : function() {

						//新增一个Tab项
						element.tabAdd('demo', {
							title : '新选项' + (Math.random() * 1000 | 0) //用于演示
							,
							content : '内容' + (Math.random() * 1000 | 0),
							id : new Date().getTime()
						//实际使用一般是规定好的id，这里以时间戳模拟下
						})
					},
					tabDelete : function(othis) {
						//删除指定Tab项
						element.tabDelete('demo', '44'); //删除：“商品管理”

						othis.addClass('layui-btn-disabled');
					},
					tabChange : function() {
						//切换到指定Tab项
						element.tabChange('demo', '22'); //切换到：用户管理
					}
				};

				$('.site-demo-active').on('click', function() {
					var othis = $(this), type = othis.data('type');
					active[type] ? active[type].call(this, othis) : '';
				});

				//Hash地址的定位
				var layid = location.hash.replace(/^#test=/, '');
				element.tabChange('test', layid);

				element.on('tab(test)', function(elem) {
					location.hash = 'test=' + $(this).attr('lay-id');
				});

				$(".layui-nav-child a").click(
						function() {
							var sign = false;
							//如果集合里已经有了这个标签，直接切换
							//如果集合里已经有了这个标签，先新增，再切换
							//console.info($("li[lay-id=]").length);
							var activetagid = $(this).text();
							$("li[lay-id]").each(function() {
								if($(this).attr('lay-id')==activetagid){
									sign=true;
								}
							})
							
							if(sign==true){
								element.tabChange('demo', $(this).text()); //切换到：用户管理
							}else{
								//新增
								element.tabAdd('demo', {
									title : $(this).text() //用于演示
									,
									content : "<iframe src='"
											+ $(this).attr('dataurl')
											+ "'></iframe>",
									id : $(this).text()
								//实际使用一般是规定好的id，这里以时间戳模拟下
								});
								//切换
								element.tabChange('demo', $(this).text()); //切换到：用户管理
							}
							
							sign = false;
						});

			});
		</script>
		<div class="layui-footer" style="z-index: 1000;">
			<!-- 广州码神软件 -->
			广州码神软件 版权所有
		</div>
	</div>
</body>
</html>