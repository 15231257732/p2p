package com.huaxin.ssm.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Role;
import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.dao.IRoleMapper;
import com.huaxin.ssm.service.IRoleService;

/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午9:36:52 

* 类说明 
*/

@Service
public class RoleServiceImpl implements IRoleService {

	@Autowired
    private IRoleMapper roleMapper;
	
	@Override
	public List<Role> getAllRole(PageBean pageBean) {
		// TODO Auto-generated method stub
		return roleMapper.getAllRole(pageBean);
	}

	@Override
	public Integer getRoleConut(PageBean pageBean) {
		// TODO Auto-generated method stub
		return roleMapper.getRoleConut(pageBean);
	}

	@Override
	public Integer deleteRole(String id) {
		// TODO Auto-generated method stub
		return roleMapper.deleteRole(id);
	}

	@Override
	public Integer saveOrUpdateRole(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.addRole(role);
	}

	@Override
	public List<Tree> getMenuAuthTree(String roleid) {
		// TODO Auto-generated method stub
		/*return roleMapper.getParentMenuAuthTree();*/
		List<Tree> list=roleMapper.getParentMenuAuthTree();
		for(Tree tree:list){
			tree.setChildren(getChildren(tree.getId(),roleid));
		}
		return list;
	}
	//子菜单
	public List<Tree> getChildren(String id,String roleid){
		List<Tree> childrenlist=roleMapper.getMenuAuthTreeByParentId(id,roleid);
		if(childrenlist!=null && childrenlist.size()>0){
			for(Tree tree:childrenlist){
				boolean checked="true".equals(tree.getAttributes())?true:false;
				tree.setChecked(checked);
				getChildren(tree.getId(),roleid);
			}
		}
		return childrenlist;
	}

	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	public Integer updateRoleMenu(String menuid, String roleid) {
		// TODO Auto-generated method stub
		//先删除该角色下对应的所有菜单项
				int n=roleMapper.deleteRoleMenu(roleid);
				if(StringUtils.isNotEmpty(menuid)){
					String[] mids=menuid.split("\\|");
					for(int i=0;i<mids.length;i++){
						roleMapper.addRoleMenu(roleid,mids[i]);
						n++;
					}
				}
				return n;
	}

	@Override
	public String getRoleIdByUserId(String id) {
		// TODO Auto-generated method stub
		return roleMapper.getRoleIdByUserId(id);
	}

	@Override
	public String getRoleIdByUId(String id) {
		// TODO Auto-generated method stub
		return roleMapper.getRoleIdByUId(id);
	}

}
