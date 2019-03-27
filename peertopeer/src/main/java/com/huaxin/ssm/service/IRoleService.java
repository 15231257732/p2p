package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Role;
import com.huaxin.ssm.bean.Tree;
		

/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午9:35:33 

* 类说明 
*/
public interface IRoleService {
	//分页查询
	public List<Role> getAllRole(PageBean pageBean);
	//页数
	public Integer getRoleConut(PageBean pageBean);
	//删除
	public Integer deleteRole(String id);
	//修改或增加
	public Integer saveOrUpdateRole(Role role);
	//根据ID查询tree的父节点
	public List<Tree> getMenuAuthTree(String id);
	
	public Integer updateRoleMenu(String menuid,String roleid);
	
	public String getRoleIdByUserId(String id);
	
	public String getRoleIdByUId(String id);
    
}
