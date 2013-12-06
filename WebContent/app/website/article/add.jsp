<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加网站文章</title>
<!-- kindEditor和easyui样式冲突 -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/panel.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/combo.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/combobox.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/datagrid.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/pagination.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/linkbutton.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/saturn.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/formValidator/validator.css">

<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/easyui-lang-zh_CN.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/formValidator.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>

<%@ include file="/app/includes/kindEditor.jsp"%>
<script type="text/javascript">
	var editor = "";
	
	function add() {
		var typeValue = $('#cid').combogrid('getValue');
		
		if (typeValue == "") {
			alert("目录标识不能为空!");
		} else {
			editor.sync();
			$('#addForm').submit();
		}
	}
	
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="text"]', {
			cssPath : '<%=request.getContextPath()%>/app/js/kindEditor/plugins/code/prettify.css',
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action',
			uploadJson : '<%=request.getContextPath()%>/app/system/upload/upload.action',
			allowFileManager : true
		});
	});
	
	$(function() {
		$('#title').focus();
		
		$('#type').combobox({
			width : 250,
			value : "article.state.normal",
			onSelect : function(record){
				$('#typeName').val(record.text);
		    }
		});
		
		$('#state').combobox({
			value : "visible.true",
			width : 250,
			onSelect : function(record){
				$('#stateName').val(record.text);
		    }
		});
		
		$('#cid').combogrid({
			width : 250,
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
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加网站文章信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/website/article/add.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>目录标识:</td>
					<td><select id="cid" name="cid"></select></td>
					<td><div id="cidTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>题目:</td>
					<td><input id="title" name="title" type="text"></input></td>
					<td><div id="titleTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>类型:</td>
					<td><select id="type" class="easyui-combobox" name="type"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=article.state"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="typeTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>显示:</td>
					<td><select id="state" class="easyui-combobox" name="state"
						url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
						valueField="id" textField="text" editable="false"></select></td>
					<td><div id="combo_stateTip"></div></td>
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
			<textarea name="text" cols="100" rows="8"
				style="width: 700px; height: 200px; visibility: hidden;"></textarea>
			<input id="typeName" type="hidden" name="typeName" type="text"
				value="普通"></input> <input id="stateName" type="hidden"
				name="stateName" type="text" value="显示"></input> <input
				id="createTime" type="hidden" name="createTime" type="text"
				value="<%=DateUtils.getSystemTime()%>"></input> <input id="operater"
				type="hidden" name="operater" type="text" value="${authUser.id}"></input>
			<input id="operaterName" type="hidden" name="operaterName"
				type="text" value="${authUser.name}"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});
		
		$("#title").formValidator({
			onfocus : "题目不能为空！并且不超过100字符"
		}).inputValidator({
			min : 1,
			max : 100
		});
	});
</script>
</html>






