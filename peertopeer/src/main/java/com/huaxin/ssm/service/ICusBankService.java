package com.huaxin.ssm.service;

import java.util.List;
import java.util.Map;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Sheng;



public interface ICusBankService {
	
	public Integer deleteCusBank(String id);
	
	public List<Customer> getAllCusBank(PageBean pagebean);
	
	public Integer getCusBankCount(PageBean pagebean);
	
	public Integer saveOrUpdate(Customer customer);
	
	public Customer getCusBankById(String id);
	
	public Integer activeObj(String id,String cid);
	
	//获取省份信息
	public List<Sheng> getShengList();
	
	
}
