<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加部门</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
	
	$(function() {
		$('#name').focus();
		
		$(function() {
			$('#name').focus();
		
			$('#responsibleId').combobox({
				value : "boolean.false",
				width : 256,
				onSelect:function(record){
					$('#responsible').val(record.text);
			    }
			});
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加部门信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/auth/organization/addOrganization.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>名称:</td>
					<td><input id="name" name="name" type="text"></input></td>
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
					<td><input id="description" name="description" type="text"></input>
					</td>
					<td><div id="descriptionTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">上级部门:</td>
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
			<input id="responsible" name="responsible" type="hidden" value="否"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
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