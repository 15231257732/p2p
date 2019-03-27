<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=path%>/js/exporting.js"></script>
</head>
<script type="text/javascript">
$(function(){
	var path = '<%=path%>';
	$('#tt').tree({
		//data:[{"id":1,"text":"Folder1","iconCls":"icon-save", "children":[{"text":"File1", "checked":true }]}]
		url:"<%=path%>/menu/getMenuTree.do",
	    onClick: function(node){
	    	if (node.attributes) {
	            Open(node.text, node.attributes,node.icons);
	        }
		}
	});
	
	$("#charttype").combobox({
	    //alert(132);
		onChange: function (n,o) {
			doAjax(n);
		}
	});
	
	//切换显示其他图
	doAjax("01");
	doAjax("02");
	doAjax("03");
	doAjax("04");
	function doAjax(typevalue){
		var xAxis=[];
		var datas=[];
		$.ajax({
			type:"post",
			url:"<%=path%>/main/getChart.do?d=new Date()",
			data:{"type":typevalue},
			dataType:"json",
			success:function(res){
				if(typevalue=="01"){
					//[{"LOANAMOUNT":300000,"LOANDATE":"2018-03-23"},{"LOANAMOUNT":100000,"LOANDATE":"2018-01-10"}]
					for(var k in res){
						//alert(k);
						xAxis[k]=res[k].LOANDATE;
						//alert(xAxis[k]);
						datas[k]=res[k].LOANAMOUNT;
					}
					//显示折线图
					getChart(xAxis,datas);
				}else if(typevalue=="02"){
					//[{"Y":2,"NAME":"待审核"},{"Y":1,"NAME":"划扣成功"}]
					for(var k in res){
						var obj={};
						obj.name=res[k].NAME;
						obj.y=res[k].Y;
						if(k==1){
							obj.sliced=true;
							obj.selected=true;
						}
						datas[k]=obj;
					}
					getChartPie(datas);
				}else if(typevalue=="03"){
					//[{"LOANDAY":"2018-01","countArry":[0,1,0],"status":["未提交","待审核","划扣成功"]},{"LOANDAY":"2018-03","countArry":[1,0,1],"status":["未提交","待审核","划扣成功"]}]
					xAxis=res[0].status;
					for(var k in res){
						var obj={};
						obj.name=res[k].LOANDAY;
						obj.data=res[k].countArry;
						datas[k]=obj;
					}
					getChartBar(xAxis,datas);
				}else if(typevalue=="04"){
					//[{"LOANAMOUNT":300000,"LOANDATE":"2018-03-23"},{"LOANAMOUNT":100000,"LOANDATE":"2018-01-10"}]
					for(var k in res){
						//alert(k);
						xAxis[k]=res[k].LOANDATE;
						//alert(xAxis[k]);
						datas[k]=res[k].LOANAMOUNT;
					}
					//显示柱状图
					getChartColumn(xAxis,datas);
				}
				
				
			},
			error:function(e){
				alert(e);
			}
		})
	}
	
})
function Open(text, url,icons) {
	if ($("#tabs").tabs('exists', text)) {
        $('#tabs').tabs('select', text);
    } else {
        $('#tabs').tabs('add', {
            title : text,
            content:'<iframe  src="'+url+'" frameBorder="0" border="0" marginheight=0 marginwidth=0 scrolling= "no" style="width: 100%; height: 100%;" noResize/>',
            closable : true,
            iconCls:icons
            //href:path+url
        });
    }
}
//退出登录按钮
function logout(){
	<%-- location.href="<%=path%>/login/logout.do"; --%>
	location.href="../login/logout.do";
}
//打开修改密码窗口
function updatepassword(id){
	$('#form').form('clear');
	$('#dd').dialog('open');
	<%-- $.ajax({
        type: "POST",
        url:"<%=path%>/user/getUserById.do",
        data: {"id":id},
        dataType : 'json',
        success: function(data){
        	/* alert(data.filepath); */
        	/* {"email":"","enable":"","id":"10060","name":"","password":"11","qq":"11","regtime":"","sex":"1","username":"11","weixin":""} */
        	$("#id").val(data.id);
        	$("#username").textbox('setValue',data.username);
        	/* $("#password").textbox('setValue',data.password); */
        	$('#dd').dialog('open').dialog('setTitle', '修改用户密码');
        },
        error: function(e){
        	$.messager.alert('提示', '操作失败', 'error');
        }
    }); --%>
}
//提交表单,修改密码
function submitForm(){
	$('#dd').dialog('open');
	/* if($('#rpassword').validatebox("isValid")==true){ */
		var password=$("#password").val();
		var rpassword=$("#rpassword").val();
		//alert(password);
		//alert(rpassword);
		if(password==rpassword){
			$.ajax({
				type:"post",
				data:{"password":$("#password").val()},
				url:"<%=path%>/user/Updatapassword.do",
				dataType:"json",
				success:function(res){
					alert("修改密码成功");
				}
			})
		}else{
			alert("密码不一致");
		}
		$('#dd').dialog('close');
		
	/* }else{
		
		alert("密码不一致");
	} */
	/* var userid=$("#id").val(),
	var userid=$("#password").val() */
	/* {$("#id").val(),$("#password").val()} */
	
}
<%-- //修改密码
function Updatapassword(){
	var userid=$("#id").val()
	alert(userid);
	$.ajax({
		type: "POST",
        url:"<%=path%>/user/Updatapassword.do",
        data: {"id":userId},
        dataType : 'json',
        success: function(data){
        	
        }
		
	});
} --%>


//js日期
function currentTime(){
	var curruntDate=new Date();
	var year=curruntDate.getFullYear();
	var moth=curruntDate.getMonth()+1;
	moth=moth<10?"0"+moth:moth;
	var date=curruntDate.getDate();
	date=date<10?"0"+date:date;
	var hour = curruntDate.getHours(); 
	hour=hour<10?"0"+hour:hour;
	var minute = curruntDate.getMinutes(); 
	minute=minute<10?"0"+minute:minute;
	var second = curruntDate.getSeconds(); 
	second=second<10?"0"+second:second;
	var week = curruntDate.getDay(); 
	var str="";
	if (week == 0) {  
	        str = "星期日";  
	} else if (week == 1) {  
	        str = "星期一";  
	} else if (week == 2) {  
	        str = "星期二";  
	} else if (week == 3) {  
	        str = "星期三";  
	} else if (week == 4) {  
	        str = "星期四";  
	} else if (week == 5) {  
	        str = "星期五";  
	} else if (week == 6) {  
	        str = "星期六";  
	} 
    $("#curruntTime").html(year+"-"+moth+"-"+date+"&nbsp;&nbsp;"+str+"&nbsp;&nbsp;"+hour+":"+minute+":"+second);
}
setInterval(currentTime,1000);


//折线图
function getChart(xaxis,datas){
	Highcharts.chart('container', {
	    chart: {
	        type: 'line'
	    },
	    title: {
	        text: '出借申请统计'
	    },
	    subtitle: {
	        text: '最大金额'
	    },
	    xAxis: {
	        categories:xaxis
	    },
	    yAxis: {
	        title: {
	            text: '金额 (元)'
	        }
	    },
	    plotOptions: {
	        line: {
	            dataLabels: {
	                enabled: true
	            },
	            enableMouseTracking: true
	        }
	    },
	    series: [{
	        name: '出借申请',
	        data: datas
	    }]
	});
}

//饼图
function getChartPie(datas){
	Highcharts.chart('containert', {
	    chart: {
	        plotBackgroundColor: null,
	        plotBorderWidth: null,
	        plotShadow: false,
	        type: 'pie'
	    },
	    title: {
	        text: '出借申请划扣状态统计'
	    },
	    tooltip: {
	        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	    },
	    plotOptions: {
	        pie: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            dataLabels: {
	                enabled: true,
	                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                style: {
	                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                }
	            },
	            showInLegend:true
	        }
	    },
	    series: [{
	        name: '占比',
	        colorByPoint: true,
	        data:datas
	    }]
	});
}
//条形图
function getChartBar(xaxis,datas){
	Highcharts.chart('containers', {
	    chart: {
	        type: 'bar'
	    },
	    title: {
	        text: '出借申请划扣状态数量统计'
	    },
	    subtitle: {
	        text: '数量、月份、状态统计'
	    },
	    xAxis: {
	        categories:xaxis,
	        title: {
	            text: null
	        }
	    },
	    yAxis: {
	        min: 0,
	        title: {
	            text: 'Population (millions)',
	            align: 'high'
	        },
	        labels: {
	            overflow: 'justify'
	        }
	    },
	    tooltip: {
	        valueSuffix: ' millions'
	    },
	    plotOptions: {
	        bar: {
	            dataLabels: {
	                enabled: true
	            }
	        }
	    },
	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'top',
	        x: -40,
	        y: 80,
	        floating: true,
	        borderWidth: 1,
	        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
	        shadow: true
	    },
	    credits: {
	        enabled: false
	    },
	    series: datas
	});
}
//柱状图
function getChartColumn(xaxis,datas){
	Highcharts.chart('containerc', {
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: '出借申请统计'
	    },
	    xAxis: {
	        categories:xaxis
	    },
	  
	    
	    series: [{
	        name: '出借申请',
	        data: datas
	    }]
	});
}
</script>
<body class="easyui-layout">
	<div style="margin: 5px 0;"></div>
	<div class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'north'" style="height:20%">
			<div style=" margin-top: 20px;">
			<span style="font-size: 40px;margin-left: 200px;margin-top: 10px;"><font face="楷体">大地钱庄·财务管理系统</font></span>
				<a style="color: red;margin-left: 650px;">${userinfo.username}&nbsp;</a>您好，欢迎使用本交易系统</div>
			<div style="margin-left: 1170px; margin-top: 10px;">
				    <span id="curruntTime"></span> <span>
				    <a href="javascript:logout()" style="text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退出</a>&nbsp;&nbsp;&nbsp;
				    <a href="javascript:updatepassword(${userinfo.id})" style="text-decoration: none;">修改密码</a></span>
			  </div>
		</div>
		<!--左菜单  -->
		<div data-options="region:'west',split:true" title="菜单"
			style="width: 260px;padding-top: 10px;">
			<ul id="tt" style="font-size: 20px;"></ul>
		</div>
		<div  data-options="region:'center'" style="padding:5px;background:#eee;">
        <div class="easyui-tabs" fit="true" border="false" id="tabs">
	      <div title="首页" >
	            <div style="margin: 5px;">
	                 <label>图形刷新: </label><select class="easyui-combobox" id="charttype"  style="width:200px;">
						<option value="01" selected="selected">折线图</option>
						<option value="02">饼形图</option>
						<option value="03">条形图</option>
						<option value="04">柱形图</option>
					</select>
	            </div>
	            
	         	<div id="container"  style="width:45%;height:45%;padding:10px;margin-left: 2%;">
	         	
				</div>
				<div id="containert"  style="width:45%;height:45%;padding:10px;margin-left: 50%;margin-top: -320px;">
	         	
				</div>
				<div id="containers"  style="width:45%;height:45%;padding:10px;margin-left: 2%;">
	         	
				</div>
				<div id="containerc" style="width:45%;height:45%;padding:10px;margin-left: 50%;margin-top: -320px;">
				
				</div>
                 
	    </div>
    </div> 
    
    
   <!-- 弹出框 -->
    <div id="dd" class="easyui-dialog" title="修改密码" style="width:450px;height:200px;"
	    data-options="iconCls:'icon-save',resizable:true,modal:true" closed="true"> 
	    <!-- form 表单-->
	    <form id="form" method="post" style="margin-left: 20px;margin-top: 20px;" enctype="multipart/form-data">
				
				<div style="height: 30px;margin-left: 50px;">
				    <label for="password">新&nbsp;&nbsp;密&nbsp;&nbsp;码:</label> <input id="password" name="password" class="easyui-textbox" required="true"/>
				</div>
				
				<div style="height: 30px;margin-left: 52px;">
				    <label for="password">确认密码:</label> <input id="rpassword" name="rpassword" class="easyui-textbox" required="true"/>
				</div>
			</form>
			<div style="height: 30px;float: right;margin: 10px 150px 0px 0px;">
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
	</div>
    
	</div>
</body>
</html>