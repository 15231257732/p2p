package com.huaxin.ssm.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class LoginFilter implements Filter {
	//记录日志
	private Log logger =LogFactory.getLog(getClass());
	
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse res=(HttpServletResponse)response;
		boolean flag=req.getSession().getAttribute("userinfo")==null?false:true;
		String url=req.getRequestURI();
		logger.info("过滤器获取请求路径url==>"+url);
		if(url.indexOf(FinalCodeUtil.DEDUCT_REQ_MAPING_NAME)<0){//接口请求不进行拦截
			if(url.indexOf("login.jsp")<0 && url.indexOf("tologin.do")<0 && url.indexOf("dologin.do")<0 && url.indexOf("logout.do")<0 && !flag){
				res.sendRedirect(req.getContextPath()+"/views/login.jsp");
			}
		}
		chain.doFilter(request, response);
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
