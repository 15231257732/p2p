package com.huaxin.ssm.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.Customer;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Sheng;
import com.huaxin.ssm.dao.ICusBankMapper;
import com.huaxin.ssm.service.ICusBankService;


@Service
public class CusBankServiceImpl implements ICusBankService{
	
	@Autowired
	private ICusBankMapper cusBankMapper;

	@Override
	public Integer deleteCusBank(String id) {
		
		return cusBankMapper.deleteCusBank(id);
	}

	@Override
	public List<Customer> getAllCusBank(PageBean pagebean) {
		return cusBankMapper.getAllCusBank(pagebean);
	}

	@Override
	public Integer getCusBankCount(PageBean pagebean) {
		return cusBankMapper.getCusBankCount(pagebean);
	}

	@Override
	public Integer saveOrUpdate(Customer customer) {
		if(customer!=null && StringUtils.isNotEmpty(customer.getId())){
			return cusBankMapper.updateCusBank(customer);
		}
		return cusBankMapper.addCusBank(customer);
	}

	@Override
	public Customer getCusBankById(String id) {
		return cusBankMapper.getCusBankById(id);
	}

	@Override
	public Integer activeObj(String id,String cid) {
		return cusBankMapper.activeObj(id,cid);
	}

	@Override
	public List<Sheng> getShengList() {
		return cusBankMapper.getShengList();
	}

}
