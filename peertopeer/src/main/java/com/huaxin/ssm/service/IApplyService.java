package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;

public interface IApplyService {
	
	public Integer deleteObj(String id);
	
	public List<LoanApply> getAllObj(PageBean pagebean);
	
	public Integer getObjCount(PageBean pagebean);
	
	public Integer saveOrUpdate(LoanApply obj);
	
	public LoanApply getObjById(String id);
	
	public Integer toSubmit(String id);
	
}
