<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(application.getAttribute("path")==null){
	String path = request.getContextPath();
	application.setAttribute("path", path);
}
%>