package com.huaxin.ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.dao.ILoginMapper;
import com.huaxin.ssm.service.ILoginService;


@Service
public class LoginServiceImpl implements ILoginService{
	@Autowired
	private ILoginMapper loginDao;
	
	@Override
	public User getUserInfo(User user) {
		User u=loginDao.getUserInfo(user);
		
		return u;
	}
    
}
