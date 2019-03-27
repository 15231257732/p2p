package com.huaxin.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.dao.IAuditMapper;
import com.huaxin.ssm.service.IAuditService;


@Service
public class AuditServiceImpl implements IAuditService{
	
	@Autowired
	private IAuditMapper  auditMapper;

	@Override
	public List<LoanApply> getAllObj(PageBean pagebean) {
		return auditMapper.getAllObj(pagebean);
	}

	@Override
	public Integer getObjCount(PageBean pagebean) {
		return auditMapper.getObjCount(pagebean);
	}

	@Override
	public LoanApply getObjById(String id) {
		return auditMapper.getObjById(id);
	}

	@Override
	public Integer toAudit(String id,String status) {
		return auditMapper.toAudit(id,status);
	}

}
