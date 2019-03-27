package com.huaxin.ssm.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.dao.IMainMapper;
import com.huaxin.ssm.service.IMainService;



@Service
public class MainServiceImpl implements IMainService{

	@Autowired
	private IMainMapper mainMapper;
	
	@Override
	public List<Map<String, Object>> getLinChart() throws Exception {
		return mainMapper.getLinChart();
	}

	@Override
	public List<Map<String, Object>> getPieChart() throws Exception {
		return mainMapper.getPieChart();
	}

	@Override
	public List<Map<String, Object>> getBarChart() throws Exception {
		List<Map<String, Object>> list=mainMapper.getBarChart();
		//存放日期
		List<Map<String, Object>> dateList=new ArrayList<Map<String, Object>>();
		
		Set<String> set=new HashSet<String>();
		for(Map<String, Object> map:list){
			set.add((String)map.get("LOANDAY"));
		}
		for(String str:set){
			Map<String, Object> datamap=new HashMap<String, Object>();
			datamap.put("LOANDAY", str);
			dateList.add(datamap);
		}
		//取状态
		Set<String> staset=new HashSet<String>();
		for(Map<String, Object> map:list){
			staset.add((String)map.get("NAME"));
		}
		String[] status=new String[staset.size()];
		int n=0;
		for(String str:staset){
			status[n]=str;
			n++;
		}
		
		for(Map<String, Object> datemap:dateList){
			int[] countArry=new int[status.length];
			int i=0;
			for(int j=0;j<status.length;j++){
				boolean flag=false;
				for(Map<String, Object> map:list){
					if(map.get("LOANDAY").equals(datemap.get("LOANDAY")) && status[i].equals(map.get("NAME"))){
						countArry[i]=Integer.parseInt(map.get("Y").toString());
						flag=true;
						break;
					}
				}
				if(!flag){
					countArry[i]=0;
				}
				i++;
			}
			datemap.put("countArry", countArry);
			datemap.put("status", status);
		}
		
		return dateList;
	}

}
