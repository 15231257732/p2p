package com.huaxin.ssm.util;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JsonUtil {
	/**
	 * bean2Json:Bean转换成json代码. <br/>
	 * @author fdz
	 * @param obj
	 * @return
	 */
	public static JSONObject bean2Json(Object obj){
		JSONObject jsonObject = JSONObject.fromObject(obj);
		return jsonObject;
	}
	/**
	 * map2Json:Map集合转换成json代码 <br/>
	 * @author fdz
	 * @param map
	 * @return
	 */
	public static JSONObject map2Json(Map<?,?> map){
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	/**
	 * List2Json:list转json. <br/>
	 * @author fdz
	 * @param list
	 * @return
	 */
	public static JSONArray  List2Json(List<?> list){
		JSONArray  jsonArray = JSONArray.fromObject(list);
		return jsonArray;
	}
	/**
	 * Array2Json:数组转json. <br/>
	 * @author fdz
	 * @param obj
	 * @return
	 */
	public static JSONArray  Array2Json(Object obj){
		JSONArray  jsonArray = JSONArray.fromObject(obj);
		return jsonArray;
	}

}
