<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>

<body >
    <div  style="height:490px">
        <div id="t_toolbar">
             <label>出借编号:</label> <input id="s_name" name="name" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchObj()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
	    </div>
	    <!-- 定义数据列表 -->
        <div id="DataGird" style="height:480px"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 0px 1px 30px 1px " closed="true">
			<div id="loantabs" class="easyui-tabs" fit="true"  >
			     <div title="客户信息" >
			         <form id="cusForm">
						<div style="height: 30px; padding:5px 20px 0px 30px">
						    <label>客户编号:</label> <input id="customer_code" name="customer_code" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>客户名称:</label> <input id="customer_name" name="customer_name" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>身份证件:</label> <input id="customer_card" name="id_card" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>手机号码:</label> <input id="customer_mobile" name="mobile" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>客户邮箱:</label> <input id="customer_email" name="email" class="easyui-textbox" >
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>客户住址:</label> <input id="customer_address" name="address" class="easyui-textbox">
						</div>
					</form>
			     </div>
			     <div title="账户信息" >
			         <form id="bankForm">
						<div style="height: 30px; padding:5px 20px 0px 30px">
						    <label>银行编号:</label> <input id="bankno" name="bankno" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>银行名称:</label> <input id="bankname" name="bankname" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>客户账号:</label> <input id="cardno" name="cardno" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>开户行名:</label> <input id="cardname" name="cardname" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>开户省份:</label> <input id="province" name="province" class="easyui-textbox" >
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>开户城市:</label> <input id="city" name="city" class="easyui-textbox">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>开户区县:</label> <input id="county" name="county" class="easyui-textbox">
						</div>
					</form>
			     </div>
			     <div title="产品信息" >
			         <form id="producForm">
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>产品名称:</label> <input id="product_name" name="name" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>年化收益:</label> <input id="product_proceeds" name="proceeds" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>购买周期:</label> <input id="period" name="period" class="easyui-textbox">
						</div>
					</form>
			     </div>
			     <div title="出借信息" >
			         <form id="addOrUpdateForm">
						<input type="hidden" id="c_id" name="id"/>
						<div style="height: 30px; padding:5px 20px 0px 30px">
						    <label>所属客户:</label> <input id="cusSelect" name="cid" class="easyui-combobox" required="true"/>
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
						    <label>投资产品:</label> <input id="proSelect" name="pid" class="easyui-combobox" required="true"/>
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>申请编号:</label> <input id="loancode" name="loancode" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>出借金额:</label> <input id="loanamount" name="Loanamount" class="easyui-textbox" required="true">
						</div>
						<div style="height: 30px; padding:5px 20px 0px 30px">
							<label>出借日期:</label> <input id="loandate" name="loandate" class="easyui-datebox"/>
						</div>
					</form>
			     </div>
			</div>
			
			<div>
				<a href="javascript:toAudit('2')" class="easyui-linkbutton" iconCls="icon-redo" >通过</a>
				<a href="javascript:toAudit('3')" class="easyui-linkbutton" iconCls="icon-back" >退回</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#DataGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/audit/getAllObj.do",
			    fitColumns: true,
			    rownumbers: true,
			    toolbar:'#t_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
				            { title: '客户名称', field: 'cusname', width: 100,},  
				            { title: '出借编号', field: 'loancode', width: 100},
				            { title: '投资产品', field: 'proname', width: 100},
				            { title: '出借金额', field: 'loanamount', width: 100},  
				            { title: '出借日期', field: 'loandate', width: 100}, 
				            { title: '单据状态', field: 'status', width: 100,
				            	formatter: function(value,row,index){
				            		if(value=="0"){
				            			return "未提交"
				            		}else if(value=="1"){
				            			return "待审核"
				            		}else{
				            			return value;
				            		}
				                }
				            },
				            { title: '操作', field: 'id', width: 100,
				            	formatter: function(value,row,index){
				            		var str="";
				            		if(row.status==1){
				            			str +="  <a href=\"javascript:updateDialog('"+value+"')\">审核</a>  ";
				            		}
				            		return str;
				    			}
							}
				        ]]
			});

		});
		
		function dialogClose(){
			$('#addOrUpdateDialog').dialog('close');
		}
		//打开修改窗口
		function updateDialog(id){
			$('#addOrUpdateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/audit/getObjById.do",
		        data: {"id":id},
		        dataType : 'json',
		        success: function(data){
		        	var loaninfo=data.loaninfo;
		        	var customer=data.customer;
		        	var bankinfo=data.bankinfo;
		        	var product=data.product;
		        	
		        	var clist=data.clist;
		        	var plist=data.plist;
		        	$("#c_id").val(id);
		        	$('#cusSelect').combobox({    
						data:clist,    
					    valueField:'cid',    
					    textField:'customer_name'
					});
 		        	$('#cusSelect').combobox('setValue', loaninfo.cid);
 		        	$('#proSelect').combobox({    
						data:plist,    
					    valueField:'id',    
					    textField:'name'
					});
 		        	$('#proSelect').combobox('setValue', loaninfo.pid);
		        	$("#loancode").textbox('setValue',loaninfo.loancode);
		        	$("#loanamount").textbox('setValue',loaninfo.loanamount);
		        	$("#loandate").datebox('setValue',loaninfo.loandate);
		        	if(loaninfo!=null){
		        		//客户信息
			        	$("#customer_code").textbox('setValue',customer.customer_code);
			        	$("#customer_name").textbox('setValue',customer.customer_name);
	 		        	$("#customer_card").textbox('setValue',customer.id_card);
	 		        	$("#customer_email").textbox('setValue',customer.email);
	 		        	$("#customer_mobile").textbox('setValue',customer.mobile);
	 		        	$("#customer_address").textbox('setValue',customer.address);
		        	}
 		        	if(bankinfo!=null){
 		        		//账户信息
 		        		$("#bankno").textbox('setValue',bankinfo.bankno);
 			        	$("#bankname").textbox('setValue',bankinfo.bankname);
 	 		        	$("#cardno").textbox('setValue',bankinfo.cardno);
 	 		        	$("#cardname").textbox('setValue',bankinfo.cardname);
 	 		        	$("#province").textbox('setValue',bankinfo.sheng);
 	 		        	/* $("#province").combobox({    
 							data:data.sslist,
 						    valueField:'id',    
 						    textField:'sheng'
 						}); */
 	 		        	$("#city").textbox('setValue',bankinfo.city);
 	 		        	
 	 		        	
 	 		        	$("#county").textbox('setValue',bankinfo.county);
 		        	}
 		        	if(product!=null){
 		        		//产品信息
 			        	$("#product_name").textbox('setValue',product.name);
 			        	$("#product_proceeds").textbox('setValue',product.proceeds);
 	 		        	$("#period").textbox('setValue',product.period);
 		        	}
		        	
		        	$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '出借审核');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		
		//审核
		function toAudit(status){
			$.ajax({
				type:"post",
				url:path+"/audit/toAudit.do",
				data:{"id":$("#c_id").val(),"status":status},
				dataType:'text',
				success:function(data){
					if(data==1){
		        		dialogClose();
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#DataGird').datagrid('reload'); 
		        	}
				},error:function(e){
					$.messager.alert('提示', '操作失败', 'error');
				}
			})
		}
		
		//查询客户
		function searchObj() {
			var sname=$("#s_name").textbox('getValue');
			var url=path+"/audit/getAllObj.do";
			$('#DataGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_name").textbox('setValue',"");
		}
		
		
	</script>     
    
</body>
</html>