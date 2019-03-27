package com.huaxin.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;
import com.huaxin.ssm.service.IApplyService;
import com.huaxin.ssm.service.ICustomerService;
import com.huaxin.ssm.service.IProductService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/apply")
public class ApplyController {
	@Autowired
	private IApplyService applyService;
	@Autowired
	private ICustomerService customerService; 
	@Autowired
	private IProductService productService;
	
	/**
	 * 出借申请页面<br/>
	 * @author fdz
	 * @return
	 */
	@RequestMapping("/applyManage")
	public String applyManage(){
		return "/views/applyManage";
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
		List<LoanApply> list=applyService.getAllObj(pagebean);
		//查询总记录数
		int rowcount=applyService.getObjCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	@RequestMapping("/deleteObj")
	@ResponseBody
	public String deleteObj(String id){
		int n=applyService.deleteObj(id);
		return String.valueOf(n);
	}
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(LoanApply loanApply){
		int n=applyService.saveOrUpdate(loanApply);
		return String.valueOf(n);
	}
	@RequestMapping("/getObjById")
	@ResponseBody
	public String getObjById(String id){
		LoanApply loanApply=applyService.getObjById(id);
		//客户信息
		List<Customer> clist=customerService.getCustomerList();
		//产品信息
		List<Product> plist=productService.getProductList();
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("loaninfo", loanApply);
		jsonobj.accumulate("clist", clist);
		jsonobj.accumulate("plist", plist);
		return jsonobj.toString();
	}
	
	@RequestMapping("/getCustomerList")
	@ResponseBody
	public String getCustomerList(){
		//查询客户信息
		List<Customer> list=customerService.getCustomerList();
		JSONArray jsonobj=JSONArray.fromObject(list);
		return jsonobj.toString();
	}
	
	@RequestMapping("/getComboboxData")
	@ResponseBody
	public String getComboboxData(){
		//查询客户信息
		List<Customer> clist=customerService.getCustomerList();
		//产品信息
		List<Product> plist=productService.getProductList();
		//放到json
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("clist", clist);
		jsonobj.accumulate("plist", plist);
		return jsonobj.toString();
	}
	
	
	@RequestMapping("/toSubmit")
	@ResponseBody
	public String toSubmit(String id){
		int n=0;
		if(StringUtils.isNotEmpty(id)){
			if(id.indexOf("|")>0){
				String[] ids=id.split("\\|");
				for(int i=0;i<ids.length;i++){
					n=applyService.toSubmit(ids[i]);
				}
			}else{
				n=applyService.toSubmit(id);
			}
		}
		return String.valueOf(n);
	}
	
}
