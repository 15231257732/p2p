package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.bean.User;



/** 

* @author 作者 Your-Name: 

* @version 创建时间：2019年2月19日 上午10:48:32 

* 类说明 

*/
public interface IMenuService {
	public List<Tree> getMenuTree(User user);

}
