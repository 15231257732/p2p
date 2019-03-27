package com.huaxin.ssm.dao;

import java.util.List;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Role;
import com.huaxin.ssm.bean.Tree;

/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午9:38:35 

* 类说明 
*/
public interface IRoleMapper {
	
	//分页查询
	public List<Role> getAllRole(PageBean pageBean);
	//页数
	public Integer getRoleConut(PageBean pageBean);
	//删除
	public Integer deleteRole(String id);
	//增加
	public Integer addRole(Role role);
	//遍历父菜单
	public List<Tree> getParentMenuAuthTree();
	
	public String getRoleIdByUserId(String id);
	
	public Integer deleteRoleMenu(String id);
	
	public Integer addRoleMenu(String roleid,String menuid);
	
	public List<Tree> getMenuAuthTreeByParentId(String id,String roleid);
	
	//根据用户ID查询菜单ID
	public String getRoleIdByUId(String id);
}
