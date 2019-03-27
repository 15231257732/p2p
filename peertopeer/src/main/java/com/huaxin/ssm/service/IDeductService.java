package com.huaxin.ssm.service;

import java.util.List;
import java.util.Map;

import com.huaxin.ssm.bean.Deduct;
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;



public interface IDeductService {
	
	
	public List<LoanApply> getAllObj(PageBean pagebean);
	
	public Integer getObjCount(PageBean pagebean);
	
    public List<LoanApply> getAllSuccObj(PageBean pagebean);
	
	public Integer getObjSuccCount(PageBean pagebean);
	
	public LoanApply getObjById(String id);
	
	public Deduct getDeductById(String id);
	
	public List<Deduct> getDeductListByIds(Map<String,String> map);
	
	public String toDeduct(Deduct deduct);
	
	public List<Deduct> getDeductInfo(String id);
	
	public Integer deductAppoint(Map<String,String> map);
	
	public String appointDeduct();
	
}
