package com.mashensoft.intercepter;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AuthorityIntercepter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//检查用户的session，如果session里没有user,就跳转到登录页面，如果有，就继续
		HttpSession session = request.getSession();
		if(session.getAttribute("user")==null){
			//如果Session里没有user,就把当前的user放进去
			String path = request.getServletContext().getContextPath();
			response.sendRedirect(path+"/login/login.jsp");
			return false;
		}
//		if(user!=null){
//			HttpSession session = request.getSession();
//			if(session.getAttribute("user")==null){
//				//如果Session里没有user,就把当前的user放进去
//				session.setAttribute("user",user );
//			}
//			return "admin_index";
//		}else{
//			return "redirect:/login/login.jsp";
//		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
