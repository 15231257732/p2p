package com.huaxin.ssm.dao;

import java.util.List;

import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.bean.User;
/** 

* @author 作者 Your-Name: 

* @version 创建时间：2019年2月19日 上午10:51:41 

* 类说明 

*/
public interface IMenuMapper {
	
	public List<Tree> getMenuTree();
	
	public List<Tree> getTreeListByPid(String id);
	
	public List<Tree> getAuthMenuTree(User user);
	
	public List<Tree> getAuthMenuTreeByPid(String userid,String pid);

}
