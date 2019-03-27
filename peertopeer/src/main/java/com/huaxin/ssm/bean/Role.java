package com.huaxin.ssm.bean;

import java.io.Serializable;

/** 
* @author 作者 卜天全: 

* @version 创建时间：2019年2月20日 上午10:12:42 

* 类说明 
*/
// implements Serializablex序列化接口
public class Role implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7810814633286450511L;

	private String id;
	
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
