<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div  style="height:490px">
        <div id="cus_toolbar">
             <label>客户名称:</label> <input id="s_customername" name="name" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchObj()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddCustomerDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
	    </div>
	    <!-- 定义数据列表 -->
        <div id="CustomerGird" style="height:480px"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateCustomerDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addOrUpdateCustomerForm">
				<input type="hidden" id="c_id" name="cid"/>
				<div style="height: 30px;">
					<label>客户编号:</label> <input id="customer_code" name="customer_code" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>客户名称:</label> <input id="customer_name" name="customer_name" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>身份证件:</label> <input id="customer_card" name="id_card" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>手机号码:</label> <input id="customer_mobile" name="mobile" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>客户邮箱:</label> <input id="customer_email" name="email" class="easyui-textbox" >
				</div>
				
				<div style="height: 30px;">
					<label>客户住址:</label> <input id="customer_address" name="address" class="easyui-textbox">
				</div>
				
			</form>
			<div>
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#CustomerGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/customer/getAllCustomer.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#cus_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
				            { title: '客户编号', field: 'customer_code', width: 100},  
				            { title: '客户名称', field: 'customer_name', width: 100},  
				            { title: '身份证', field: 'id_card', width: 100},  
				            { title: '手机', field: 'mobile', width: 100},  
				            { title: '邮箱', field: 'email', width: 100},  
				            { title: '住址', field: 'address', width: 100},  
				            { title: '操作', field: 'cid', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		str +="  <a href=\"javascript:deleteCustomer('"+value+"')\">删除</a>  ";
				            		str +="  <a href=\"javascript:updateCustomerDialog('"+value+"')\">修改</a>  ";
				            		return str;
				    			}
							}
				        ]]
			});
			/* var p = $('#roleGird').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//每页显示的记录条数，默认为10  
                pageList: [10,20,30,50],//可以设置每页记录条数的列表  
                beforePageText: '第',//页数文本框前显示的汉字  
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            }); */

		});
		//打开添加客户的dialog
		function openAddCustomerDialog(){
			$('#addOrUpdateCustomerForm').form('clear');
			$('#addOrUpdateCustomerDialog').dialog('open').dialog('setTitle', '新增客户');
		}
		function dialogClose(){
			$('#addOrUpdateCustomerDialog').dialog('close');
		}
		//打开修改窗口
		function updateCustomerDialog(cusid){
			$('#addOrUpdateCustomerForm').form('clear');
			
			$.ajax({
		        type: "POST",
		        url: path+"/customer/getCustomerById.do",
		        data: {"id":cusid},
		        dataType : 'json',
		        success: function(data){
		        	alert(data.customer_name);
		        	$("#c_id").val(cusid);
		        	$("#customer_code").textbox('setValue',data.customer_code);
		        	$("#customer_name").textbox('setValue',data.customer_name);
 		        	$("#customer_card").textbox('setValue',data.id_card);
 		        	$("#customer_email").textbox('setValue',data.email);
 		        	$("#customer_mobile").textbox('setValue',data.mobile);
 		        	$("#customer_address").textbox('setValue',data.address);
 		        	$('#addOrUpdateCustomerDialog').dialog('open').dialog('setTitle', '修改客户');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//删除客户
		function deleteCustomer(cid){
			$.ajax({
		        type: "POST",
		        url: path+"/customer/deleteCustomer.do",
		        data: {"id":cid},
		        dataType : 'text',
		        success: function(data){
		        	if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#CustomerGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//查询客户
		function searchObj() {
			var sname=$("#s_customername").textbox('getValue');
			var url=path+"/customer/getAllCustomer.do";
			$('#CustomerGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_customername").textbox('setValue',"");
		}
		//保存添加、修改内容
		function saveOrUpdate() {
			url = path+"/customer/saveOrUpdateCustomer.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addOrUpdateCustomerForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addOrUpdateCustomerDialog').dialog('close');
		        		$('#CustomerGird').datagrid('reload'); 
		        	}else{
		        		$.messager.alert('提示', '操作失败', 'info');
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		function submitForm(){
			$('#addOrUpdateCustomerForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveOrUpdate();
			    }
			});
		}
		
	</script>  
    
</body>
</html>