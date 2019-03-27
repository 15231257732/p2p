package com.huaxin.ssm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.dao.ICusBankMapper;
import com.huaxin.ssm.dao.ICustomerMapper;
import com.huaxin.ssm.service.ICustomerService;

/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午11:37:30 

* 类说明 
*/
@Service
public class CustomerServiceImpl implements ICustomerService {

	@Autowired
	private ICustomerMapper customerMapper;
	@Autowired
	private ICusBankMapper cusBankMapper;
	
	@Override
	public List<Customer> getAllCustomer(PageBean pagebean) {
		// TODO Auto-generated method stub
		return customerMapper.getAllCustomer(pagebean);
	}

	@Override
	public Integer getCustomerCount(PageBean pagebean) {
		// TODO Auto-generated method stub
		return customerMapper.getCustomerCount(pagebean);
	}

	@Override
	public List<Customer> getCustomerList() {
		// TODO Auto-generated method stub
		return customerMapper.getCustomerList();
	}

	@Override
	public Integer deleteCustomer(String id) {
		// TODO Auto-generated method stub
		//执行俩个方法
		cusBankMapper.deleteByCid(id);
		return customerMapper.deleteCustomer(id);
	}

	@Override
	public Integer saveOrUpdateCustomer(Customer customer) {
		if(customer!=null && StringUtils.isNotEmpty(customer.getCid())){
			return customerMapper.updateCustomer(customer);
		}
		return customerMapper.addCustomer(customer);
	}

	@Override
	public Customer getCustomerById(String id) {
		// TODO Auto-generated method stub
		return customerMapper.getCustomerById(id);
	}

	@Override
	public Customer getBankByCid(String cid) {
		// TODO Auto-generated method stub
		return customerMapper.getBankByCid(cid);
	}

}
