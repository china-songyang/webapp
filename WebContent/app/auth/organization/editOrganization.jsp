<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改部门信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function edit() {
		$('#editForm').submit();
	}
	
	$(function() {
		$('#name').focus();
		$('#responsibleId').combobox({
			value : '${organization.responsible}' == '是' ? "boolean.true" : "boolean.false",
			width : 256,
			onSelect:function(record){
				$('#responsible').val(record.text);
		    }
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改部门信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">
		<form id="editForm"
			action="<%=request.getContextPath()%>/app/auth/organization/updateOrganization.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>标识:</td>
					<td><input id="id" name="id" type="text"
						value="${organization.id}" readonly="readonly"></input></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>名称:</td>
					<td><input id="name" name="name" type="text"
						value="${organization.name}"></input></td>
					<td><div id="nameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">负责:</td>
					<td><select id="responsibleId" class="easyui-combobox"
						name="responsibleId"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=boolean"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="responsibleIdTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">描述:</td>
					<td><input id="description" name="description" type="text"
						value="${organization.description}"></input></td>
					<td><div id="descriptionTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">父资源:</td>
					<td><input id="parentId" name="parentId" type="text"
						value="${organization.parentId}"></input></td>
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
			<input id="id" name="id" type="hidden" value="${organization.id}"></input>
			<input id="responsible" name="responsible" type="hidden"
				value="${organization.responsible}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});
		$("#name").formValidator({
			onfocus : "部门名称不能为空！并且不超过50字符"
		}).inputValidator({
			min : 1,
			max : 50
		});

		$("#description").formValidator({
			onfocus : "描述信息不超过50字符！",
			empty : true
		}).inputValidator({
			max : 50
		});
	});
</script>
</html>