<%@page import="com.saturn.website.PaginationUtils"%>
<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../include/include.jsp"%>
<title>下载页</title>
<script type="text/javascript">
$(function() {
	$.post("<%=request.getContextPath()%>/webdo/apkfile/apkfilelist.do", 
		null, 
		function(json){
			var str = "";
			var num = json.length;
			if(num>0){
				for(var i=0;i<num;i++) {
					var id = json[i].id;
					var title = json[i].title;
					var apkfile = json[i].apkfile;
					var content = json[i].content;
					var createtime = json[i].createTime;
					//--二级菜单---
					str=$("#apkfiletable").html()+" <tr>";
					str+="<td><a href=\"javascript:void(0);\" onclick=\"return down('"+ apkfile +"')\" >"+title+"</a></td>";
					str+="<tr>";
					str+="<td>"+content+"</td>";
					str+="</tr>";
					str+="<tr>";
					str+="<td>"+createtime+"</td>";
					str+="</tr>";
					$("#apkfiletable").html(str);
				}
			}
		}, 
		"json");

});


function down(note){
	var type=note;
	if(type!="null"&&type!=""){
		window.location.href='<%=request.getContextPath()%>/app/system/upload/download.do?note='+ note;
	}else{
		$.messager.alert('提示','无文件地址。','info');
	}
	return false;
}
</script>
<style type="text/css">
	a:link{
		color: blue;
	}
	a:visited {
			color: white;
	}
	a:hover{
			color: blue;
	}
	a:active {
			color: red;
	} 
</style>
</head>
<body background="<%=request.getContextPath()%>/app/themes/saturn/images/download.png">
<div id="apkfiletable" style="font-size: 20px;color:white;margin:350px 0px 0px 580px"></div>
</body>
</html>