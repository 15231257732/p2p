package com.huaxin.ssm.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.service.ILoginService;
import com.huaxin.ssm.util.MD5;



@Controller
@RequestMapping(value="/login")
public class LoginController {

	@Autowired
	private ILoginService loginService;
	
	@RequestMapping("/tologin")
	public String tologin(){
		return "/views/login";
	}
	@RequestMapping("/tomain")
	public String tomain(){
		return "/views/main";
	}
	/**
	 * 接收前端参数方法
	 * 1、如果是表单或者是ajax传递过来的参数，可以直接把表单的参数写在Controller相应的方法的形参中
	 * 2、用对象可以直接接收参数，前提是对象的属性字段与表单传递的参数name所属一致
	 * 3、通过HttpServletRequest接收，将HttpServletRequest写在Controller相应的方法中
	 * 4、通过注解参数方法接收参数 @RequestParam("username") String a
	 */
	@RequestMapping("/dologin")
	@ResponseBody
	public String dologin(String username,String password,HttpSession session){
		/*response.setContentType("text/html;charset=UTF-8");*/
		String mess="";
		User user=new User();
		//通过密码获取md5加密后的密文
		String encryptpass=MD5.encodeMD5(username, password);
		user.setUsername(username);
		user.setPassword(encryptpass);
		user=loginService.getUserInfo(user);
		if(user!=null && user.getId()!=null){
			//则说明用户存在，跳转到主页面,同时将用户信息放到session中
			session.setAttribute("userinfo", user);
			mess="ok";
		}else{
			mess="用户名或者密码错误";
		}
		
		return mess;
	}
	//退出按钮，实现清除session域
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		HttpSession session=request.getSession();
		session.removeAttribute("userinfo");
		session.invalidate();
		//String path=request.getContextPath();
		return "/views/login";
	}
}
