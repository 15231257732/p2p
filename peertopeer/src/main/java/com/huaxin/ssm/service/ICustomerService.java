package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;


/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午11:35:53 

* 类说明 
*/
public interface ICustomerService {
	//删除
    public Integer deleteCustomer(String id);
	//带分页查询
	public List<Customer> getAllCustomer(PageBean pagebean);
	//查询总记录数
	public Integer getCustomerCount(PageBean pagebean);
	//增加或修改方法
	public Integer saveOrUpdateCustomer(Customer customer);
	//通过ID查询信息
	public Customer getCustomerById(String id);
	//获取客户的信息
	public List<Customer> getCustomerList();
	
	public Customer getBankByCid(String cid);

}
