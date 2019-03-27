<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.form.js"></script>
<title></title>
<script type="text/javascript">
    $(function(){
    	
    })
    
   
</script>
</head>
<body>
    <div id="cc" class="easyui-layout" style="width:100%;height:570px;">
	    <div data-options="region:'north',split:true" style="height:100px;">
	    	<h1>top</h1>
	    </div>
	    <div data-options="region:'west',title:'West',split:true" style="width:200px;">
	       <ul id="tt" class="easyui-tree">
			    <li>
					<span>Folder</span>
					<ul>
						<li>
							<span>Sub Folder 1</span>
							<ul>
								<li><span><a href="<%=path%>/user/toList.do" target="main">用户管理</a></span></li>
								<li><span>File 12</span></li>
								<li><span>File 13</span></li>
							</ul>
						</li>
						<li><span>File 2</span></li>
						<li><span>File 3</span></li>
					</ul>
				 </li>
			    <li><span>File21</span></li>
			</ul>
	    </div>
	    <div data-options="region:'center'" style="background:#eee;">
	    <div>456456456</div>
	       <iframe name="main" width="99%" height="99%"  frameborder="no" border="0"></iframe>
	    </div>
	</div>
   

</body>
</html>