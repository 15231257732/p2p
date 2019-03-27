package com.huaxin.ssm.service;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.User;

/** 

* @author 作者 Your-Name: 

* @version 创建时间：2019年2月15日 上午10:06:41 

* 类说明 

*/
public interface IUserService {
	//查询全部信息和模糊查询
	public List<User> getAllUser(PageBean pagebean);
	//分页
	public Integer getUserCount(PageBean pagebean);
	//增加或修改
	public Integer saveOrUpdateUser(User user);
	//删除
	public Integer deleteUser(Map<String,Object> map);
	//去修改
	public User getUserById(String id);
	//导出表单
	public HSSFWorkbook exportExcel(Map<String,Object> map);
	
	public Integer saveUserRole(String id,String roleid);
	//修改密码
	public int Updatapassword(User user);
}
