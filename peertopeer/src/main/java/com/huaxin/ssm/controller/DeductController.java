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
import com.huaxin.ssm.bean.Deduct;
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;
import com.huaxin.ssm.service.ICustomerService;
import com.huaxin.ssm.service.IDeductService;
import com.huaxin.ssm.service.IProductService;
import com.huaxin.ssm.util.EmailUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/deduct")
public class DeductController {
	
	@Autowired
	private IDeductService deductService;
	@Autowired
	private ICustomerService customerService; 
	@Autowired
	private IProductService productService;
	
	/**
	 * 出借划扣页面<br/>
	 * @author fdz
	 * @return
	 */
	@RequestMapping("/deductManage")
	public String deductManage(){
		return "/views/deductManage";
	}
	//已划扣页面
	@RequestMapping("/deductSuccessManage")
	public String deductSuccessManage(){
		return "/views/deductSuccessManage";
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
		List<LoanApply> list=deductService.getAllObj(pagebean);
		//查询总记录数
		int rowcount=deductService.getObjCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	
	@RequestMapping("/getAllSuccObj")
	@ResponseBody
	public String getAllSuccObj(HttpServletRequest request){
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
		List<LoanApply> list=deductService.getAllSuccObj(pagebean);
		//查询总记录数
		int rowcount=deductService.getObjSuccCount(pagebean);
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	@RequestMapping("/getObjById")
	@ResponseBody
	public String getObjById(String id){
		LoanApply loanApply=deductService.getObjById(id);
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
	
	@RequestMapping("/toDeduct")
	@ResponseBody
	public String toDeduct(String id){
		String resStr="";
		if(StringUtils.isNotEmpty(id)){
			if(id.indexOf("|")>0){
				String ids=id.replaceAll("\\|", ",");
				//通过对个id用in条件将待划扣的数据查询出来，然后调用支付接口
				Map<String,String> map=new HashMap<String,String>();
				map.put("ids",ids);
				List<Deduct> list=deductService.getDeductListByIds(map);
				if(list.size()>0){
					for(Deduct deduct:list){
						//调用支付接口
						resStr=deductService.toDeduct(deduct);
					}
				}
			}else{
				//通过id将待划扣的数据查询出来，然后调用支付接口
				Deduct deduct=deductService.getDeductById(id);
				//调用支付接口
				resStr=deductService.toDeduct(deduct);
			}
		}
		return resStr;
	}
	//划扣记录信息
	@RequestMapping("/getDeductInfo")
	@ResponseBody
	public String getDeductInfo(String id){
		//划扣记录
		List<Deduct> list=deductService.getDeductInfo(id);
		JSONArray jsonobj=JSONArray.fromObject(list);
		return jsonobj.toString();
	}
	//预约划扣，更新预约时间
	@RequestMapping("/deductAppoint")
	@ResponseBody
	public String deductAppoint(HttpServletRequest request){
		String ids=request.getParameter("ids");
		String appointdate=request.getParameter("appointdate");
		Map<String,String> map=new HashMap<String,String>();
		int n=0;
		if(StringUtils.isNotEmpty(ids)){
			if(ids.indexOf("|")>0){
				ids=ids.replaceAll("\\|", ",");
			}
			map.put("ids",ids);
			map.put("appointdate", appointdate);
			n=deductService.deductAppoint(map);
		}
		return String.valueOf(n);
	}
	@RequestMapping("/sendEmail")
	@ResponseBody
	public String sendEmail(String id){
		Deduct deduct=deductService.getDeductById(id);
		String name=deduct.getCusNm();
		String amout=deduct.getLoanAmount();
		String Loancode=deduct.getOrderNum();
		String email=deduct.getEmail();
		//String backname=deduct.getBankName();
		//调用通用发送邮件方法
		EmailUtil.sendEmail01(email,"你好,"+name+"，您的出借申请订单号为:"+Loancode+"划扣成功，金额为:"+amout+"邮件已经发送，请您注意查收.[支付宝]");
		return "OK";
	}
	
}
