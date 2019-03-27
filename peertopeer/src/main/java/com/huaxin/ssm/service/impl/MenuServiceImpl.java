package com.huaxin.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.dao.IMenuMapper;
import com.huaxin.ssm.service.IMenuService;

/** 
* @author 作者 Your-Name: 
* @version 创建时间：2019年2月19日 上午10:50:21 
* 类说明 
*/
@Service
public class MenuServiceImpl implements IMenuService{

	@Autowired
	private IMenuMapper menuDao;

	@Override
	public List<Tree> getMenuTree(User user) {

		/*
		 * List<Tree> list=menuDao.getMenuTree(); return list;
		 */

		// 如果是管理员，则可以看到全部菜单
		if ("admin".equals(user.getUsername())) {
			List<Tree> list = menuDao.getMenuTree();
			for (Tree tree : list) {
				tree.setChildren(getChildren(tree.getId()));
			}
			return list;
		} else {
			// 查询当前用户授权后的菜单
			List<Tree> list = menuDao.getAuthMenuTree(user);
			for (Tree tree : list) {
				tree.setChildren(getAuthChildren(user.getId(), tree.getId()));
			}
			return list;
		}
	}

	private List<Tree> getChildren(String id) {
		List<Tree> list = menuDao.getTreeListByPid(id);
		if (list.size() > 0) {
			for (Tree tree : list) {
				tree.setChildren(getChildren(tree.getId()));
			}
		}
		return list;
	}

	private List<Tree> getAuthChildren(String userid, String pid) {
		List<Tree> list = menuDao.getAuthMenuTreeByPid(userid, pid);
		if (list.size() > 0) {
			for (Tree tree : list) {
				tree.setChildren(getAuthChildren(userid, tree.getId()));
			}
		}
		return list;
	}

}
