package com.huaxin.ssm.dao;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.User;
/** 
* @author 作者 Your-Name: 
* @version 创建时间：2019年2月15日 上午10:09:36 
* 类说明 
*/
public interface IUserDao {
	//查询
	public List<User> getAllUser(PageBean pagebean);
	//分页
	public Integer getUserCount(PageBean pagebean);
	//增加
    public Integer addUser(User u);
	//修改
	public Integer updateUser(User u);
	//删除
	public Integer deleteUser(Map<String,Object> map);
	//去修改
	public User getUserById(String id);
	//导出表单
	public List<User> queryAllUser(Map<String,Object> map);
	
	public Integer saveUserRole(Map<String,String> map);
	
	public Integer deleteUserRole(String id);
	
	public int Updatapassword(User user);
}
