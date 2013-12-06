<%@page import="com.saturn.website.Content"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加网站目录</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
	
	$(function() {
		$('#id').focus();
		
		$('#hasShow').combobox({
			width : 250,
			value : "visible.true",
			onSelect : function(record){
				$('#hasShowName').val(record.text);
		    }
		});
		
		$('#mode').combobox({
			width : 250,
			value : "content.mode.none",
			onSelect : function(record){
				$('#modeName').val(record.text);
		    }
		});
		
		$('#parentId').combogrid({
			width : 250,
			panelWidth : 600,
			value : '<%=request.getParameter("parentId")==null?"":request.getParameter("parentId")%>',
			idField : 'id',
			textField : 'name',
			pagination : true,
			rownumbers : true,
			sortName : 'id',
			sortOrder : 'asc',
			remoteSort : true,
			url : '<%=request.getContextPath()%>/app/website/content/list.action',
			onSelect : function(record){
				$('#id').val($('#parentId').combogrid("getValue"));
		    },
			columns : [[
				{field : 'id',title : '标识',width : 150, sortable : true},
				{field : 'name',title : '名称',width : 100, sortable : true},
				{field : 'hasShowName',title : '显示', width : 120, sortable : true}
			]]
		});
		
		<%
			String parentId = request.getParameter("parentId");
			String text = null;
			if (parentId != null) {
				Content content = Content.get(parentId);
				if (content != null) {
					text = content.getName();
				}
		%>
			$('#parentId').combogrid("setValue", '<%=parentId%>');
		<%
				if (text != null) {
		%>
			$('#parentId').combogrid("setText", '<%=text%>');
		<%
				}
			}
		%>
		
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加网站目录信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/website/content/add.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right">父目录:</td>
					<td><select id="parentId" name="parentId"></select></td>
					<td></td>
				</tr>
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
					<td style="text-align: right"><span style="color: red">*</span>英文名称:</td>
					<td><input id="english" name="english" type="text"></input></td>
					<td><div id="englishTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right">路径:</td>
					<td><input id="path" name="path" type="text"></input></td>
					<td><div id="pathTip"></div></td>
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
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input id="hasShowName" type="hidden" name="hasShowName" type="text"
				value="显示"></input> <input id="modeName" type="hidden"
				name="modeName" type="text" value="空项"></input>
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
			url : "<%=request.getContextPath()%>/app/website/content/isRepeatId.action",
			data : $('#id').val(),
			success : function(data) {
				return data == "false";
			},
			onerror : "标识已经存在"
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






