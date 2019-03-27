package com.huaxin.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Sheng;
import com.huaxin.ssm.service.ICusBankService;
import com.huaxin.ssm.service.ICustomerService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/cusbank")
public class CusBankController {
	@Autowired
	private ICusBankService cusBankService;
	@Autowired
	private ICustomerService customerService; 
	
	@RequestMapping("/cusbankManage")
	public String userManage(){
		
		return "/views/cusbankManage";
	}
	/**
	 * 分页注意事项:
	 * 1、easyui默认会传入分页参数  page表示第几页  rows：每页记录数
	 * 2、返回数据的时候，必须设置total总记录数，rows：数据集合
	 * 3、需要满足json格式
	 * @author fdz
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllCusBank")
	@ResponseBody
	public String getAllCusBank(HttpServletRequest request){
		//查询参数
		String name=request.getParameter("sname");
		//分页第几页
		String pageNumber=request.getParameter("page");
		//每页记录数
		String pageSize=request.getParameter("rows");
		
		PageBean pagebean=new PageBean();
		//分页统一设置
		pagebean.setPagein(Integer.parseInt(pageNumber),Integer.parseInt(pageSize));
		
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("name", name);
		pagebean.setMap(map);
		//查询用户记录
		List<Customer> list=cusBankService.getAllCusBank(pagebean);
		//查询总记录数
		int rowcount=cusBankService.getCusBankCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	@RequestMapping("/deleteCusBank")
	@ResponseBody
	public String deleteCusBank(String id){
		int n=cusBankService.deleteCusBank(id);
		return String.valueOf(n);
	}
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(Customer customer){
		int n=cusBankService.saveOrUpdate(customer);
		return String.valueOf(n);
	}
	@RequestMapping("/getCusBankById")
	@ResponseBody
	public String getCusBankById(String id){
		Customer customer=cusBankService.getCusBankById(id);
		List<Customer> list=customerService.getCustomerList();
		List<Sheng> sslist=cusBankService.getShengList();
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("sslist", sslist);
		jsonobj.accumulate("cuslist", list);
		jsonobj.accumulate("bankinfo", customer);
		return jsonobj.toString();
	}
	@RequestMapping("/getCustomerList")
	@ResponseBody
	public String getCustomerList(){
		//查询客户信息
		List<Customer> list=customerService.getCustomerList();
		List<Sheng> sslist=cusBankService.getShengList();
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("sslist", sslist);
		jsonobj.accumulate("list", list);
		//JSONArray jsonobj=JSONArray.fromObject(list);
		return jsonobj.toString();
	}
	//激活
	
	@RequestMapping("/activeObj")
	@ResponseBody
	public String activeObj(String id,String cid){
		int n=cusBankService.activeObj(id,cid);
		return String.valueOf(n);
	}
}
