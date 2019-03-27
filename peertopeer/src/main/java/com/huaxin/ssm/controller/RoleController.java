package com.huaxin.ssm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Role;
import com.huaxin.ssm.bean.Tree;
import com.huaxin.ssm.service.IRoleService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午9:34:29 

* 类说明 
*/
@Controller
@RequestMapping(value="/role")
public class RoleController {

	@Autowired
	private IRoleService roleService;
    
    @RequestMapping("/roleManage")
	public String roleManage(){
		return "/views/roleManage";
	}
    @RequestMapping("/getAllRole")
    @ResponseBody
    public String getAllRole(HttpServletRequest request){
    	String pageSize=request.getParameter("rows");
    	String pageNum=request.getParameter("page");
    	//分页统一方法
    	PageBean pageBean=new PageBean();
    	pageBean.setPagein(Integer.parseInt(pageNum),Integer.parseInt(pageSize));
    	
    	List<Role> list=roleService.getAllRole(pageBean);
    	int rowcount=roleService.getRoleConut(pageBean);
    	JSONObject jsonobj=new JSONObject();
    	jsonobj.accumulate("total", rowcount);
    	jsonobj.accumulate("rows", list);
    	return jsonobj.toString();
    }
    @RequestMapping("/deleteRole")
    @ResponseBody
    public String deleteRole(String id) {
    	int n=roleService.deleteRole(id);
		return String.valueOf(n);
    }
    @RequestMapping("/getMenuAuthTree")
    @ResponseBody
    public String getMenuAuthTree(String id) {
    	List<Tree> list=roleService.getMenuAuthTree(id);
    	JSONArray json=JSONArray.fromObject(list);
		return json.toString();
    }
    
    
    @RequestMapping("saveOrUpdateRole")
    @ResponseBody
    public String saveOrUpdateRole(HttpServletRequest request) {
    	String name=request.getParameter("name");
    	Role role=new Role();
    	role.setName(name);
    	int n=roleService.saveOrUpdateRole(role);
		return String.valueOf(n);
    }
    
    @RequestMapping("/updateRoleMenu")
    @ResponseBody
    public String updateRoleMenu(HttpServletRequest request){
    	String menuid=request.getParameter("menuid");
    	String roleid=request.getParameter("roleid");
    	int n=roleService.updateRoleMenu(menuid,roleid);
    	return n>0?"true":"false";
    }
}
