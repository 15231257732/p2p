package com.huaxin.ssm.dao;

import java.util.List;
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
public interface IApplyMapper {
	
	public Integer deleteObj(String id);
	
	public List<LoanApply> getAllObj(PageBean pagebean);
	
	public Integer getObjCount(PageBean pagebean);
	
	public Integer addObj(LoanApply apply);
	
	public Integer updateObj(LoanApply apply);
	
	public LoanApply getObjById(String id);
	
	public Integer toSubmit(String id);
}
