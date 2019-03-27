package com.huaxin.ssm.bean;

import java.io.Serializable;

/** 

* @author 作者 Your-Name: 

* @version 创建时间：2019年2月15日 上午9:22:12 

* 类说明 

*/
public class Sheng implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4277742780192941005L;

	public String id;
	
	public String sheng;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSheng() {
		return sheng;
	}

	public void setSheng(String sheng) {
		this.sheng = sheng;
	}


	
	
}
