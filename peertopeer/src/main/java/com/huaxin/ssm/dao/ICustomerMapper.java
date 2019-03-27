package com.huaxin.ssm.dao;

import java.util.List;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;


public interface ICustomerMapper {
	
	
	public List<Customer> getAllCustomer(PageBean pagebean);
	
	public Integer getCustomerCount(PageBean pagebean);
	
	public List<Customer> getCustomerList();
	

	public Integer deleteCustomer(String id);
	

	
	public Integer addCustomer(Customer customer);
	
	public Integer updateCustomer(Customer customer);
	
	public Customer getCustomerById(String id);
	

	
	public Customer getBankByCid(String cid);
	
}
