package com.huaxin.ssm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.dao.IUserDao;
import com.huaxin.ssm.service.IUserService;
import com.huaxin.ssm.util.ExcelUtil;
import com.huaxin.ssm.util.MD5;

/** 
* @author 作者 Your-Name: 
* @version 创建时间：2019年2月15日 上午10:08:01 
* 类说明 
*/

@Service
public class UserServiceImpl implements IUserService {
	@Autowired
	public IUserDao userDao;

	@Override
	public List<User> getAllUser(PageBean pagebean) {
		// TODO Auto-generated method stub
		return userDao.getAllUser(pagebean);
	}
	@Override
	public Integer getUserCount(PageBean pagebean) {
		// TODO Auto-generated method stub
		return userDao.getUserCount(pagebean);
	}
	//增加或修改
	@Override
	public Integer saveOrUpdateUser(User user) {
		// TODO Auto-generated method stub
		//MD5方法加密
		String encryptpass=MD5.encodeMD5(user.getUsername(), user.getPassword());
		user.setPassword(encryptpass);
        //判断ID是否为空，执行增加或修改	
		if(user!=null && StringUtils.isNotEmpty(user.getId())){
			//如果id不为空，则表示调用的是修改的方法
			return userDao.updateUser(user);
		}else if(user!=null && StringUtils.isEmpty(user.getId())){
			//如果id为空，说明调用的是新增方法
			return userDao.addUser(user);
		}
		return 0;
	}
	//增加或修改
	

	@Override
	public Integer deleteUser(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return userDao.deleteUser(map);
	}
	@Override
	public User getUserById(String id) {
		// TODO Auto-generated method stub
		return userDao.getUserById(id);
	}
	@Override
	public HSSFWorkbook exportExcel(Map<String, Object> map) {
		// TODO Auto-generated method stub
		 //定义表头
		 String[] headers={"用户名","邮件","性别","QQ","微信","注册日期"};
		 //获取数据集合
		 List<User> list=userDao.queryAllUser(map);
		 String [][] values=new String[list.size()][headers.length];
		 for (int i = 0; i < list.size(); i++) {
            User u = list.get(i);
            values[i][0] = u.getUsername();
            values[i][1] = u.getEmail();
            if(u!=null && u.getSex()!=null) {
            	values[i][2] = u.getSex().equals("1")?"男":"女";
            }
            /*values[i][2] = u.getSex();*/
            values[i][3] = u.getQq();
            values[i][4] = u.getWeixin();
            values[i][5] = u.getRegtime();
	     }
		 HSSFWorkbook workbook=ExcelUtil.getHSSFWorkbook("用户管理", headers, values, null);
		 return workbook;
	   }
	@Override
	@Transactional(propagation=Propagation.REQUIRED,timeout=10,
          isolation=Isolation.READ_COMMITTED,rollbackFor=Exception.class)
	public Integer saveUserRole(String id, String roleid) {
		// TODO Auto-generated method stub
		Map<String,String> map=new HashMap<String,String>();
		map.put("id", id);
		map.put("roleid", roleid);
		//先删除，在插入
		userDao.deleteUserRole(id);
		return userDao.saveUserRole(map);
	}
	@Override
	public int Updatapassword(User user) {
		// TODO Auto-generated method stub
		return userDao.Updatapassword(user);
	}
}

	

