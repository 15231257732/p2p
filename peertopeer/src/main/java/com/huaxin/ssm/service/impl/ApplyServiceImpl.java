package com.huaxin.ssm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.dao.IApplyMapper;
import com.huaxin.ssm.service.IApplyService;


@Service
public class ApplyServiceImpl implements IApplyService{
	
	@Autowired
	private IApplyMapper  applyMapper;

	@Override
	public Integer deleteObj(String id) {
		return applyMapper.deleteObj(id);
	}

	@Override
	public List<LoanApply> getAllObj(PageBean pagebean) {
		return applyMapper.getAllObj(pagebean);
	}

	@Override
	public Integer getObjCount(PageBean pagebean) {
		return applyMapper.getObjCount(pagebean);
	}

	@Override
	public Integer saveOrUpdate(LoanApply loanApply) {
		if(loanApply!=null && StringUtils.isNotEmpty(loanApply.getId())){
			return applyMapper.updateObj(loanApply);
		}
		return applyMapper.addObj(loanApply);
	}

	@Override
	public LoanApply getObjById(String id) {
		return applyMapper.getObjById(id);
	}

	@Override
	public Integer toSubmit(String id) {
		return applyMapper.toSubmit(id);
	}

}
