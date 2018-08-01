<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <link rel="shortcut icon" href="/static/img/favicon.ico">

        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <title>API管理平台 登录</title>
        <link rel="stylesheet" href="${path }/layui/css/layui.css?t=1504439386550" media="all">
        <link rel="stylesheet" href="${path }/login/login.css?t=1504439386550" media="all">
        <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    </head>
    <body>
        <div class="layui-carousel video_mask bg-img" id="login_carousel" >

            <div class="login layui-anim layui-anim-up">
                <h1>码神软件后台管理后台</h1></p>
                <form class="layui-form" action="${path }/dologin" method="post">
                    <div class="layui-form-item">
                        <input type="text" name="username" id="username" lay-verify="required" placeholder="请输入账号" autocomplete="off"  value="" class="layui-input">
                    </div>
                    <div class="layui-form-item">
                        <input type="password" name="password" id="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" value="" class="layui-input">
                    </div>
                    <button class="layui-btn login_btn" lay-submit="" lay-filter="login">登陆系统</button>
                </form>
            </div>
        </div>
        <script src="${path }/layui/layui.js?t=1504439386550" charset="utf-8"></script>
        
        <script type="text/javascript">
            layui.use(['layer','form'], function(){   
                var layer = layui.layer; 
                var form = layui.form;
                var error_info = "";
                if(error_info){
                    layer.msg(error_info,{time:2000,offset: '100px'});
                }
               
            })
        </script>
    </body>
</html>
