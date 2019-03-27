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
        <div id="t_toolbar">
             <label>出借编号:</label> <input id="s_name" name="name" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchObj()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
             <!-- <a href="javascript:submitSelect()" class="easyui-linkbutton" iconCls="icon-ok">批量提交</a> -->
	    </div>
	    <!-- 定义数据列表 -->
        <div id="DataGird" style="height:480px"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addOrUpdateForm">
				<input type="hidden" id="c_id" name="id"/>
				<div style="height: 30px;">
				    <label>所属客户:</label> <input id="cusSelect" name="cid" class="easyui-combobox" required="true"/>
				</div>
				<div style="height: 30px;">
				    <label>投资产品:</label> <input id="proSelect" name="pid" class="easyui-combobox" required="true"/>
				</div>
				<div style="height: 30px;">
					<label>申请编号:</label> <input id="loancode" name="loancode" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>出借金额:</label> <input id="loanamount" name="Loanamount" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>出借日期:</label> <input id="loandate" name="loandate" class="easyui-datebox"/>
				</div>
			</form>
			<div>
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
		<!-- 划扣记录列表 -->
		<div id="deductDialog" class="easyui-dialog" style="width: 600px; height: 300px;" closed="true">
			<div id="deductDataGird" style="height:100%"></div> 
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#DataGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/apply/getAllObj.do",
			    fitColumns: true,
			    rownumbers: true,
			    toolbar:'#t_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
			                { title: '', field: '', checkbox:true, width: 100 },
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
				            		}else if(value=="2"){
				            			return "待划扣"
				            		}else if(value=="3"){
				            			return "审核退回"
				            		}else if(value=="4"){
				            			return "划扣成功"
				            		}else if(value=="5"){
				            			return "划扣失败"
				            		}else if(value=="6"){
				            			return "回款中"
				            		}else{
				            			return "出借完成";
				            		}
				                }
				            },
				            { title: '操作', field: 'id', width: 100,
				            	formatter: function(value,row,index){
				            		//alert(row);
				            		var status=row.status;
				            		var str = "";
				            		//2
				            		if(status==0 ||status==3){
				            			str +="  <a href=\"javascript:deleteObj('"+value+"')\">删除</a>  ";
					            		str +="  <a href=\"javascript:updateDialog('"+value+"')\">修改</a>  ";
				            			str +="  <a href=\"javascript:toSubmit('"+value+"')\">提交</a>  ";
				            		}else if(status>3){
				            			str +="  <a href=\"javascript:showDeductInfo('"+value+"')\">划扣记录</a>  ";
				            		}
				            		return str;
				    			}
							}
				        ]]
			});

		});
		//打开添加客户的dialog
		function openAddDialog(){
			$('#addOrUpdateForm').form('clear');
			//加载客户信息
			$.ajax({
		        type: "POST",
		        url: path+"/apply/getComboboxData.do",
		        data: {},
		        dataType : 'json',
		        success: function(data){
		        	var clist=data.clist;
		        	var plist=data.plist;
		        	$('#cusSelect').combobox({    
						data:clist,    
					    valueField:'cid',    
					    textField:'customer_name'
					});
		        	$('#proSelect').combobox({    
						data:plist,    
					    valueField:'id',    
					    textField:'name'
					});
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
			$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '新增出借申请');
		}
		function dialogClose(){
			$('#addOrUpdateDialog').dialog('close');
		}
		//打开修改窗口
		function updateDialog(id){
			$('#addOrUpdateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/apply/getObjById.do",
		        data: {"id":id},
		        dataType : 'json',
		        success: function(data){
		        	var loaninfo=data.loaninfo;
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
		        	$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '修改出借申请');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//删除客户
		function deleteObj(id){
			$.ajax({
		        type: "POST",
		        url: path+"/apply/deleteObj.do",
		        data: {"id":id},
		        dataType : 'text',
		        success: function(data){
		        	if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#DataGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//提交审核
		function toSubmit(id){
			//alert(id);
			$.ajax({
				type:"post",
				url:path+"/apply/toSubmit.do",
				data:{"id":id},
				dataType:'text',
				success:function(data){
					if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#DataGird').datagrid('reload'); 
		        	}
				},error:function(e){
					$.messager.alert('提示', '操作失败', 'error');
				}
			})
		}
		//批量提交
		function submitSelect(){
			//var selectNode = $('#staffGird').datagrid("getSelected");
			var ids="";
			var rows=$("#DataGird").datagrid("getChecked");
			for(var i in rows){
				if(rows[i].status==0 || rows[i].status==3){
					if(ids==""){
						ids+=rows[i].id;
					}else{
						ids+="|"+rows[i].id;
					}
				}
			}
			if(ids==""){
				$.messager.alert('提示', '待审核的数据不需要再次提交!', 'info');
				return ;
			}
			toSubmit(ids);
		}
		//查询客户
		function searchObj() {
			var sname=$("#s_name").textbox('getValue');
			var url=path+"/apply/getAllObj.do";
			$('#DataGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_name").textbox('setValue',"");
		}
		//保存添加、修改内容
		function saveOrUpdate() {
			url = path+"/apply/saveOrUpdate.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addOrUpdateForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addOrUpdateDialog').dialog('close');
		        		$('#DataGird').datagrid('reload'); 
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
			$('#addOrUpdateForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveOrUpdate();
			    }
			});
		}
		//划扣记录
		function showDeductInfo(id){
			$('#deductDataGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/deduct/getDeductInfo.do?id="+id+" ",
			    fitColumns: true,
			    rownumbers: true,
			    columns: [[  
							{ title: '流水号', field: 'serialNum', width: 220,},  
							{ title: '划扣金额', field: 'loanAmount', width: 60},  
							{ title: '划扣时间', field: 'deductTime', width: 100}, 
							{ title: '划扣结果', field: 'deductRes', width: 120}
				        ]]
			});
			$('#deductDialog').dialog('open').dialog('setTitle', '划扣记录');
		}
	</script>     
</body>
</html>