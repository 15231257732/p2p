package com.huaxin.ssm.service;

import java.util.List;

import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;


public interface IAuditService {
	
	
	public List<LoanApply> getAllObj(PageBean pagebean);
	
	public Integer getObjCount(PageBean pagebean);
	
	public LoanApply getObjById(String id);
	
	public Integer toAudit(String id,String status);
	
	
}
