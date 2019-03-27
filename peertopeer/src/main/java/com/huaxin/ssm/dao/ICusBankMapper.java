package com.huaxin.ssm.dao;

import java.util.List;
import java.util.Map;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Sheng;



public interface ICusBankMapper {
	
	public Integer deleteCusBank(String id);
	
	//根据Cid查询
	public Integer deleteByCid(String cid);
	
	public List<Customer> getAllCusBank(PageBean pagebean);
	
	public Integer getCusBankCount(PageBean pagebean);
	
	public Integer addCusBank(Customer customer);
	
	public Integer updateCusBank(Customer customer);
	
	public Customer getCusBankById(String id);
	
	public Integer activeObj(String id,String cid);
	
	//获取省份信息
    public List<Sheng> getShengList();
	
}
