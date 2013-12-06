<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改资源信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function edit() {
		$('#editForm').submit();
	}
	
	$(function() {
		$('#name').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改资源信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">
		<form id="editForm"
			action="<%=request.getContextPath()%>/app/auth/resource/updateResource.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>标识:</td>
					<td><input id="id" name="id" type="text"
						value="${resource.id}" readonly="readonly"></input></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>名称:</td>
					<td><input id="name" name="name" type="text"
						value="${resource.name}"></input></td>
					<td>
						<div id="nameTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">路径:</td>
					<td><input id="path" name="path" type="text"
						value="${resource.path}"></input></td>
					<td>
						<div id="pathTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">父资源:</td>
					<td><input id="parentId" name="parentId" type="text"
						value="${resource.parentId}"></input></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
								onclick="edit()">确定</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input id="sort" type="hidden" name="sort" type="text"
				value="${resource.sort}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
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