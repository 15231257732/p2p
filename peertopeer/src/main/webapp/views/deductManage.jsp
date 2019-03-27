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
             <!-- <a href="javascript:deductSelect()" class="easyui-linkbutton" iconCls="icon-ok">批量划扣</a> -->
             <a href="javascript:deductAppoint()" class="easyui-linkbutton" iconCls="icon-redo">预约划扣</a>
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
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
		<!-- 预约划扣弹出卡片 -->
		<div id="deductAppointDialog" class="easyui-dialog" style="width: 300px; height: 180px; padding: 30px 20px" closed="true">
			<form id="deductAppointForm">
			    <input type="hidden" id="ids" name="ids"/>
				<div style="height: 60px;">
					<label>出借日期:</label> <input id="appointdate" name="appointdate" class="easyui-datetimebox"/>
			    </div>
		    </form>
			<div>
			    <a href="javascript:saveDeductAppoint()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:AppointDialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
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
			    url:path+"/deduct/getAllObj.do",
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
				            { title: '预约时间', field: 'appointdate', width: 100},
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
				            		var status=row.status;
				            		var str = "";
				            		str +="  <a href=\"javascript:showInfo('"+value+"')\">查看</a>  ";
				            		if(status==2 ||status==5){
				            			str +="  <a href=\"javascript:toDeduct('"+value+"')\">划扣</a>  ";
				            			/* str +="  <a href=\"javascript:showDeductInfo('"+value+"')\">划扣记录</a>  "; */
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
		function AppointDialogClose(){
			$('#deductAppointDialog').dialog('close');
		}
		//打开窗口
		function showInfo(id){
			$('#addOrUpdateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/deduct/getObjById.do",
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
		        	$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '出借申请');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//划扣
		function toDeduct(id){
			$.ajax({
				type:"post",
				url:path+"/deduct/toDeduct.do",
				data:{"id":id},
				dataType:'text',
				success:function(res){
					//alert(res);
					if(res=="OK"){
		        		$.messager.alert('提示', '操作成功', 'info');
		        	}else{
		        		$.messager.alert('提示', res, 'info');
		        	}
					$('#DataGird').datagrid('reload'); 
				},error:function(e){
					$.messager.alert('提示', '操作失败', 'error');
				}
			})
		}
		//批量划扣
		function deductSelect(){
			var ids="";
			var rows=$("#DataGird").datagrid("getChecked");
			for(var i in rows){
				if(ids==""){
					ids+=rows[i].id;
				}else{
					ids+="|"+rows[i].id;
				}
			}
			if(ids==""){
				$.messager.alert('提示', '请选择待划扣的数据!', 'info');
				return ;
			}
			toDeduct(ids);
		}
		//预约划扣
		function deductAppoint(){
			$('#deductAppointForm').form('clear');
			var ids="";
			var rows=$("#DataGird").datagrid("getChecked");
			for(var i in rows){
				if(ids==""){
					ids+=rows[i].id;
				}else{
					ids+="|"+rows[i].id;
				}
			}
			if(ids==""){
				$.messager.alert('提示', '请选择要预约划扣的数据!', 'info');
				return ;
			}
			$("#ids").val(ids);
			$('#deductAppointDialog').dialog('open').dialog('setTitle', '预约划扣时间');
		}
		//设置预约划扣时间
		function saveDeductAppoint(){
			$.ajax({
				type:"post",
				url:path+"/deduct/deductAppoint.do",
				data:$("#deductAppointForm").serialize(),
				dataType:"text",
				success:function(res){
					if(res!=""){
						$.messager.alert('提示', '预约成功'+res+'条记录', 'info');
						$('#deductAppointDialog').dialog('close');
						$('#DataGird').datagrid('reload'); 
					}
				},error:function(e){
					$.messager.alert('提示', '操作失败', 'error');
				}
			})
		}
		//查询
		function searchObj() {
			var sname=$("#s_name").textbox('getValue');
			var url=path+"/deduct/getAllObj.do";
			$('#DataGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_name").textbox('setValue',"");
		}
		//划扣记录
		function showDeductInfo(id){
			alert(123);
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