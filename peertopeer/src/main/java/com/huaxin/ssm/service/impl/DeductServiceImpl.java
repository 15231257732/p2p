package com.huaxin.ssm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.huaxin.ssm.bean.Deduct;
import com.huaxin.ssm.bean.LoanApply;
import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.dao.IDeductMapper;
import com.huaxin.ssm.service.IDeductService;
import com.huaxin.ssm.util.DeductUtil;
import com.huaxin.ssm.util.FinalCodeUtil;
import com.huaxin.ssm.util.XmlParseUtil;


@Service(value="deductService")

public class DeductServiceImpl implements IDeductService{
	//记录日志
	private Log logger =LogFactory.getLog(getClass());
	
	@Autowired
	private IDeductMapper  deductMapper;

	@Override
	public List<LoanApply> getAllObj(PageBean pagebean) {
		return deductMapper.getAllObj(pagebean);
	}

	@Override
	public Integer getObjCount(PageBean pagebean) {
		return deductMapper.getObjCount(pagebean);
	}

	@Override
	public LoanApply getObjById(String id) {
		return deductMapper.getObjById(id);
	}

	@Override
	public List<LoanApply> getAllSuccObj(PageBean pagebean) {
		return deductMapper.getAllSuccObj(pagebean);
	}

	@Override
	public Integer getObjSuccCount(PageBean pagebean) {
		return deductMapper.getObjSuccCount(pagebean);
	}
	@Override
	public Deduct getDeductById(String id) {
		return deductMapper.getDeductById(id);
	}
	
	@Override
	public List<Deduct> getDeductListByIds(Map<String,String> map) {
		return deductMapper.getDeductListByIds(map);
	}
	@Override
	public List<Deduct> getDeductInfo(String id) {
		return deductMapper.getDeductInfo(id);
	}

	@Override
	public Integer deductAppoint(Map<String, String> map) {
		return deductMapper.deductAppoint(map);
	}
	/**
	 * doDeduct:划扣方法 <br/>
	 * @author fdz
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public String toDeduct(Deduct deduct){
		String mess="";
		String serialNum=UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		//设置流水号
		deduct.setSerialNum(serialNum);
		deduct.setOrderNum(serialNum);
		//调用统一划扣方法
		String strResp=DeductUtil.sendDeductRequest(deduct);
		if(StringUtils.isEmpty(strResp)){
			mess=FinalCodeUtil.DEDUCT_MESSAGE015;
		}else{
			//解析回盘结果
			Map<String,String> map=XmlParseUtil.Dom4jXmlParse(strResp);
			String resCode=map.get("resCode");
			String resMess=map.get("resMess");
			String Amount=map.get("Amount");
			deduct.setLoanAmount(Amount);
			deduct.setDeductRes(resMess);
			//插入划扣记录
			deductMapper.AddDeduct(deduct);
			int state=4;
			if("OK".equals(resCode)){
				mess="OK";
			}else{
				state=5;
				mess=resMess;
			}
			//更新出借申请数据状态
			Map<String,Object> pramap=new HashMap<String,Object>();
			pramap.put("state", state);
			pramap.put("id", deduct.getId());
 			deductMapper.toDeduct(pramap);
		}
		return mess;
	}
	/**
	 * appointDeduct:定时执行预约划扣的记录. <br/>
	 * @author fdz
	 * @param deduct
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public String appointDeduct(){
		String mess="";
		List<Deduct> list=deductMapper.getAppointDeductList(null);
		if(list==null || list.size()==0){
			logger.info("未获取到预约划扣的数据");
		}else{
			for(Deduct deduct:list){
				mess=toDeduct(deduct);
			}
		}
		return mess;
	}

}
