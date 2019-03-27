package com.huaxin.ssm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.service.IMenuService;
import com.huaxin.ssm.util.RedisUtil;

import net.sf.json.JSONArray;
import redis.clients.jedis.Jedis;

/** 

* @author 作者 Your-Name: 

* @version 创建时间：2019年2月19日 上午10:47:06 

* 类说明 

*/
@Controller
@RequestMapping(value="/menu")
public class MenuController {
	@Autowired
	private IMenuService menuService;
	/*@RequestMapping("/getMenuTree")
	@ResponseBody
	public String getMenuTree(HttpSession session){
		User user=(User) session.getAttribute("userinfo");	
		//查询菜单
		List<Tree> list=menuService.getMenuTree(user);	
		JSONArray json=JSONArray.fromObject(list);
		String str=json.toString();
		return str;
	}
	*/
	
	
	
	 private Jedis jedis;
	 
	    @RequestMapping("/getMenuTree")
		@ResponseBody
		public String getMenuTree(HttpSession session){
	    	//redis获取菜单
	    	jedis=RedisUtil.getJedis();
	    	if(jedis==null){
	    		User user=(User) session.getAttribute("userinfo");	
	    		//后台查询菜单树，并遍历
	    		List<Tree> list=menuService.getMenuTree(user);	
	    		//String json=JSONArray.toJSONString(list);
	    		JSONArray json=JSONArray.fromObject(list);
	    		String str=json.toString();
	    		return str;
	    	}else{
	    		String tree = jedis.get("maintree");
	    		if(tree==null){
	    			User user=(User) session.getAttribute("userinfo");	
	    			//后台查询菜单树，并遍历
	    			List<Tree> list=menuService.getMenuTree(user);	
	    			/*String json=com.alibaba.fastjson.JSONArray.toJSONString(list);*/
	    			String json=JSONArray.fromObject(list).toString();
	    			/*JSONArray.fromObject(object)*/
	    			
         			jedis.set("maintree", json);
	    			jedis.save();
	    			return json;
	    		}
	    		return tree;
   	}
		}

	
}
