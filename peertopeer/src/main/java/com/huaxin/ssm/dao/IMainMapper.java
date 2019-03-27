package com.huaxin.ssm.dao;

import java.util.List;
import java.util.Map;

public interface IMainMapper {
	
	public List<Map<String,Object>> getLinChart() throws Exception;
	
	public List<Map<String,Object>> getPieChart() throws Exception;
	
	public List<Map<String,Object>> getBarChart() throws Exception;
	

}
