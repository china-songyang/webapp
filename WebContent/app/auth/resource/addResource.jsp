<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加资源</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
	
	$(function() {
		$('#id').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加资源信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/auth/resource/addResource.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>标识:</td>
					<td><input id="id" name="id" type="text"
						value="<%=request.getParameter("parentId")%>"></input></td>
					<td><div id="idTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>名称:</td>
					<td><input id="name" name="name" type="text"></input></td>
					<td><div id="nameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">路径:</td>
					<td><input id="path" name="path" type="text"></input></td>
					<td><div id="pathTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">父资源:</td>
					<td><input id="parentId" name="parentId" type="text"
						value="<%=request.getParameter("parentId")%>" readonly="readonly"></input>
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});
		
		$("#id").formValidator({
			onfocus : "标识由数字，字母，小数点组成，不超过50字符"
		}).regexValidator({
			regexp : "id"
		}).inputValidator({
			min : 1,
			max : 50,
			onerror : "标识不超过50字符"
		}).ajaxValidator({
			url : "<%=request.getContextPath()%>/app/auth/resource/isRepeatResourceId.action",
			data : $('#id').val(),
			success : function(data) {
				return data == "false";
			},
			onerror : "标识已经存在"
		});

		$("#name").formValidator({
			onfocus : "资源名称不能为空！并且不超过50字符"
		}).inputValidator({
			min : 1,
			max : 50
		});

		$("#path").formValidator({
			onfocus : "路径信息不超过100字符！",
			empty : true
		}).inputValidator({
			max : 100
		});
	});
</script>
</html>






