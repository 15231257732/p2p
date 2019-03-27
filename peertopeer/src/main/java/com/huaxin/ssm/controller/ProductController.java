package com.huaxin.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;
import com.huaxin.ssm.service.IProductService;
import com.huaxin.ssm.util.JsonUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/product")
public class ProductController {
	@Autowired
	private IProductService productService;
	
	@RequestMapping("/productManage")
	public String userManage(){
		
		return "/views/productManage";
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
	@RequestMapping("/getAllProduct")
	@ResponseBody
	public String getAllProduct(HttpServletRequest request){
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
		List<Product> list=productService.getAllProduct(pagebean);
		//查询总记录数
		int rowcount=productService.getProductCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	@RequestMapping("/deleteProduct")
	@ResponseBody
	public String deleteProduct(String id){
		int n=productService.deleteProduct(id);
		return String.valueOf(n);
	}
	@RequestMapping("/saveOrUpdateProduct")
	@ResponseBody
	public String saveOrUpdateProduct(Product product){
		int n=productService.saveOrUpdateProduct(product);
		return String.valueOf(n);
	}
	@RequestMapping("/getProductById")
	@ResponseBody
	public String getProductById(String id){
		Product product=productService.getProductById(id);
		JSONObject jsonobj=JsonUtil.bean2Json(product);
		return jsonobj.toString();
	}
	
	
	
}
