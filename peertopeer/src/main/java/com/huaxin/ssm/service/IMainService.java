package com.huaxin.ssm.service;

import java.util.List;
import java.util.Map;

public interface IMainService {
	
	public List<Map<String,Object>> getLinChart() throws Exception;
	
	public List<Map<String,Object>> getPieChart() throws Exception;
	
	public List<Map<String,Object>> getBarChart() throws Exception;

}
