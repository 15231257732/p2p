package com.huaxin.ssm.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.service.IUserService;
import com.huaxin.ssm.service.impl.UserServiceImpl;


public class EmailUtil {
	
	
	public static  void sendEmail01(String email,String content){
	
		
		// 配置发送邮件的环境属性
		final Properties props = new Properties();        
		/*
		 * 可用的属性： mail.store.protocol / mail.transport.protocol / mail.host /         
		 * mail.user / mail.from         
		 */        
		// 表示SMTP发送邮件，需要进行身份验证       
		props.put("mail.smtp.auth", "true");        
		props.put("mail.smtp.host", "smtp.qq.com");        
		// 发件人的账号        
		props.put("mail.user", "973636264@qq.com");        
		// 访问SMTP服务时需要提供的密码        
		props.put("mail.password", "ivjeztmazrrxbbic");        
		// 构建授权信息，用于进行SMTP进行身份验证        
		Authenticator authenticator = new Authenticator() {            
			@Override           
			protected PasswordAuthentication getPasswordAuthentication() {                
				// 用户名、密码                
				String userName = props.getProperty("mail.user");                
				String password = props.getProperty("mail.password");                
				return new PasswordAuthentication(userName, password);    
			}
		};        
		// 使用环境属性和授权信息，创建邮件会话        
		Session mailSession = Session.getInstance(props, authenticator);        
		// 创建邮件消息        
		MimeMessage message = new MimeMessage(mailSession);        
		// 设置发件人        
		InternetAddress form;
		try {
			form = new InternetAddress( props.getProperty("mail.user"));
			message.setFrom(form);        
	        // 设置收件人    
			
	        InternetAddress to = new InternetAddress(email);        
	        message.setRecipient(RecipientType.TO, to);        
	        // 设置抄送        
	       InternetAddress cc = new InternetAddress(email);        
	        message.setRecipient(RecipientType.CC, cc);        
	        // 设置密送，其他的收件人不能看到密送的邮件地址        
	        InternetAddress bcc = new InternetAddress(email);        
	        message.setRecipient(RecipientType.CC, bcc);        
	        // 设置邮件标题        
	        message.setSubject("支付信息");        
	        // 设置邮件的内容体       
	        message.setContent(content, "text/html;charset=UTF-8");        
	        // 发送邮件        
	        Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}        
	}		

	public static void main(String[] args) {
		EmailUtil.sendEmail01("123","李明下午上课");
	}
}
