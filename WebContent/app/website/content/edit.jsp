<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改目录信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function edit() {
		$('#editForm').submit();
	}
	
	$(function() {
		$('#name').focus();
		
		$('#hasShow').combobox({
			width : 256,
			value : "${content.hasShow}",
			onSelect:function(record){
				$('#hasShowName').val(record.text);
		    }
		});
		
		$('#mode').combobox({
			width : 256,
			value : "${content.mode}",
			onSelect : function(record){
				$('#modeName').val(record.text);
		    }
		});
		
		$('#parentId').combogrid({
			width : 256,
			panelWidth : 600,
			idField : 'id',
			textField : 'name',
			pagination : true,
			rownumbers : true,
			sortName : 'id',
			sortOrder : 'asc',
			remoteSort : true,
			url : '<%=request.getContextPath()%>/app/website/content/list.action',
			columns : [[
				{field : 'id',title : '标识',width : 150, sortable : true},
				{field : 'name',title : '名称',width : 100, sortable : true},
				{field : 'hasShowName',title : '显示', width : 120, sortable : true}
			]]
		});
		$('#parentId').combogrid("setValue", '${content.parentId}');
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改目录信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">
		<form id="editForm"
			action="<%=request.getContextPath()%>/app/website/content/update.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right">父目录:</td>
					<td><select id="parentId" name="parentId"></select></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>标识:</td>
					<td><input id="id" name="id" type="text" value="${content.id}"
						readonly="readonly"></input></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>名称:</td>
					<td><input id="name" name="name" type="text"
						value="${content.name}"></input></td>
					<td>
						<div id="nameTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>英文名称:</td>
					<td><input id=english name="english" type="text"
						value="${content.english}"></input></td>
					<td><div id="englishTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">路径:</td>
					<td><input id="path" name="path" type="text"
						value="${content.path}"></input></td>
					<td>
						<div id="pathTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">显示:</td>
					<td><select id="hasShow" class="easyui-combobox"
						name="hasShow"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="hasShowTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">模式:</td>
					<td><select id="mode" class="easyui-combobox" name="mode"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=content.mode"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="hasShowTip"></div></td>
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
				value="${content.sort}"></input> <input id="hasShowName"
				type="hidden" name="hasShowName" type="text"
				value="${content.hasShowName}"></input> <input id="modeName"
				type="hidden" name="modeName" type="text"
				value="${content.modeName}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});
		
		$("#name").formValidator({
			onfocus : "目录名称不能为空！并且不超过50字符"
		}).inputValidator({
			min : 1,
			max : 50
		});
		
		$("#english").formValidator({
			onfocus : "英文名称不超过100字符",
			empty : true
		}).inputValidator({
			max : 100
		});

		$("#path").formValidator({
			onfocus : "路径信息不超过100字符",
			empty : true
		}).inputValidator({
			max : 100
		});
	});
</script>
</html>