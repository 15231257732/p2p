package com.huaxin.ssm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Product;
import com.huaxin.ssm.dao.IProductMapper;
import com.huaxin.ssm.service.IProductService;


@Service
public class ProductServiceImpl implements IProductService{
	@Autowired
	private IProductMapper productMapper;

	@Override
	public Integer deleteProduct(String id) {
		return productMapper.deleteProduct(id);
	}

	@Override
	public List<Product> getAllProduct(PageBean pagebean) {
		return productMapper.getAllProduct(pagebean);
	}

	@Override
	public Integer getProductCount(PageBean pagebean) {
		return productMapper.getProductCount(pagebean);
	}

	@Override
	public Integer saveOrUpdateProduct(Product product) {
		if(product!=null && StringUtils.isNotEmpty(product.getId())){
			//调用修改
			return productMapper.updateProduct(product);
		}
		return productMapper.addProduct(product);
	}

	@Override
	public Product getProductById(String id) {
		return productMapper.getProductById(id);
	}

	@Override
	public List<Product> getProductList() {
		return productMapper.getProductList();
	}
	


}
