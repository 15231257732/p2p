package com.huaxin.ssm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huaxin.ssm.service.IMainService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value="/main")
public class MainController {

	@Autowired
	private IMainService mainService;
	/**
	 * 折线图
	 * @author fdz
	 * @return
	 */
	@RequestMapping("/getChart")
	@ResponseBody
	public String getChart(HttpServletRequest req){
		String type=req.getParameter("type");
		type=StringUtils.isEmpty(type)?"01":type;
		String mess="";
		List<Map<String, Object>> list=new ArrayList<Map<String, Object>>();;
		try {
			if("01".equals(type)){
				list=mainService.getLinChart();
			}else if("02".equals(type)){
				list=mainService.getPieChart();
			}else if("03".equals(type)){
				list=mainService.getBarChart();
			}else if("04".equals(type)){
				list=mainService.getLinChart();
			}
			JSONArray json=JSONArray.fromObject(list);
			mess=json.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mess;
	}
	
}
