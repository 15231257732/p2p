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
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;
import com.huaxin.ssm.bean.Sheng;
import com.huaxin.ssm.service.IAuditService;
import com.huaxin.ssm.service.ICusBankService;
import com.huaxin.ssm.service.ICustomerService;
import com.huaxin.ssm.service.IProductService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/audit")
public class AuditController {
	@Autowired
	private ICusBankService cusBankService;
	@Autowired
	private IAuditService auditService;
	@Autowired
	private ICustomerService customerService; 
	@Autowired
	private IProductService productService;
	
	//跳转出借审核页面
	@RequestMapping("/auditManage")
    public String auditManage(){
		return "/views/auditManage";
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
	@RequestMapping("/getAllObj")
	@ResponseBody
	public String getAllObj(HttpServletRequest request){
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
		List<LoanApply> list=auditService.getAllObj(pagebean);
		//查询总记录数
		int rowcount=auditService.getObjCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	
	@RequestMapping("/getObjById")
	@ResponseBody
	public String getObjById(String id){
		//出借信息
		LoanApply loanApply=auditService.getObjById(id);
		//客户信息
		Customer customer=customerService.getCustomerById(loanApply.getCid());
		//产品信息
		Product product=productService.getProductById(loanApply.getPid());
		//账户信息
		Customer cusbank=customerService.getBankByCid(loanApply.getCid());
		//客户信息结合
		List<Customer> clist=customerService.getCustomerList();
		//产品信息集合
		List<Product> plist=productService.getProductList();
		
		List<Sheng> sslist=cusBankService.getShengList();
		
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("loaninfo", loanApply);
		jsonobj.accumulate("customer", customer);
		jsonobj.accumulate("bankinfo", cusbank);
		jsonobj.accumulate("product", product);
		jsonobj.accumulate("clist", clist);
		jsonobj.accumulate("plist", plist);
		jsonobj.accumulate("sslist", sslist);
		return jsonobj.toString();
	}
	
	@RequestMapping("/toAudit")
	@ResponseBody
	public String toAudit(String id,String status){
		int n=auditService.toAudit(id,status);
		return String.valueOf(n);
	}
}
