<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>table模块快速使用</title>
<link rel="stylesheet" href="${path}/layui/css/layui.css" media="all">
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
</head>
<body>
<div class="demoTable">
  <div style="margin-top: 20px;" id="searchform">
  标题：
  <div class="layui-inline">
    <input class="layui-input" name="title" id="title" autocomplete="off">
  </div>
  <button class="layui-btn" data-type="reload" id="searchButton">搜索</button>
  <button class="layui-btn" type="reset" id="reset">重置</button>
  <button class="layui-btn" type="button" id="createone">新增</button>
  </div>
</div>
	<table id="demo" lay-filter="test"></table>

	<script src="${path}/layui/layui.js"></script>
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
	<script>
	
		layui.use('table', function() {
			var table = layui.table;

			//第一个实例
			table.render({
				id:'testreload',
				elem : '#demo',
				height : 315,
				url : '/admin/article/pagedata' //数据接口
				,
				page : true //开启分页
				,
				cols : [ [ //表头
				{
					field : 'articleId',
					title : 'ID',
					width : 120,
					sort : true,
					fixed : 'left'
				}, {
					field : 'title',
					title : '标题',
					width : 120
				}, {
					field : 'createTime',
					title : '创建时间',
					width : 120,
					sort : true
				}, {
					field : 'updateTime',
					title : '更新时间',
					width : 120,
					sort : true
				}
				, {
					fixed : 'right',
					title : '操作',
					toolbar : '#barDemo',
					width : 150
				} ] ]
			});
			//监听工具条
			table.on('tool(test)', function(obj) {
				var data = obj.data;
				if (obj.event === 'del') {
					layer.confirm('真的删除行么', function(index) {
						//obj.del();
						console.info(data.articleId);
						var request = $.ajax({
							  url: "/admin/article/deleteArticleById",
							  method: "POST",
							  data: { articleId : data.articleId },
							  dataType: "json"
							});
							request.done(function( msg ) {
									 table.reload('testreload');
							  
							});
						//调用删除数据的url
						table.reload('demo');
						layer.close(index);
					});
				} else if (obj.event === 'edit') {
					//window.location="/admin/article/articleedit";
					layer.open({
						title:'编辑文章信息',
						type : 2,
						content : '/admin/article/articleedit/'+data.articleId //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						,area: ['80%', '95%'],
						end: function () {
							 table.reload('testreload');
					      }
					});
				}
			});
			
			var $ = layui.$, active = {
			        reload: function(){
			           // var demoReload = $('#demo');	
			            table.reload('testreload', {
			                where: {
			                	title: $('#title').val()
			                	
			                }
			            
			            });
			        }
			    };
			 $('#searchButton').on('click', function(){
				    var type = $(this).data('type');
				    active[type] ? active[type].call(this) : '';
				  });
			 $("#createone").click(function(){
					layer.open({
						title:'新增文章信息',
						type : 2,
						content : '/admin/article/articleedit/0' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						,area: ['80%', '95%'],
						end: function () {
							 table.reload('testreload');
					      }
					});
				})
		});
		$("#reset").click(function(){
			$("#searchform input").each(function(){
				$(this).val('');
			})
		})
		
	</script>
</body>
</html>