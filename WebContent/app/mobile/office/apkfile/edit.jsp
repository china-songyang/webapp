<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改信息</title>
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
	
	function edit() {
		var apkfile = $('#apkfile').val();
		
		if (apkfile == "") {
			alert("文件地址不能为空!");
			return;
		}
		$('#editForm').submit();
		
	}
	
	KindEditor.ready(function(K) {
		//文件
		var uploadbutton1 = K.uploadbutton({
			button : K('#uploadButton1')[0],
			fieldName : 'imgFile',
			url : '<%=request.getContextPath()%>/app/system/upload/upload.action?dir=file',
			afterUpload : function(data) {
				if (data.error === 0) {
					var url = K.formatUrl(data.url, 'absolute');
					
					K('#apkfile').val(url);
					//$('#imageShow').attr("src", url);
				} else {
					alert(data.message);
				}
			}
		});
		
		uploadbutton1.fileBox.change(function(e) {
			uploadbutton1.submit();
		});
		
		//文件
		var editor = K.editor({
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action?dir=file'
		});
		K.plugin('filemanager').call(editor, K);
		K('#filemanager').click(function() {
			var dialog = editor.plugin.filemanagerDialog({
				viewType : 'VIEW',
				clickFn : function(url, title) {
					K('#apkfile').val(url);
					editor.hideDialog();
					//$('#imageShow').attr("src", url);
				}
			});
		});
	});
	
	$(function() {
		$('#title').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改文件信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">
		<form id="editForm"
			action="<%=request.getContextPath()%>/app/mobile/office/apkfile/update.action"
			method="post">
			<table class="table-form">
				<div style="margin: 0px 0px 0px 50px;">
					<input id="image" name="image" type="hidden" value=""
						readonly="readonly" /> <input type="button" id="uploadButton1"
						style="height: 30px;" value="上传" />
				</div>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>题目:</td>
					<td><input id="title" name="title" type="text"
						value="${apkfile.title}"></input></td>
					<td><div id="titleTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>内容:</td>
					<td><textarea id="content" name="content" style="width: 300px;height: 100px">${apkfile.content}</textarea></td>
					<td><div id="contentTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red">*</span>版本号:</td>
					<td><input id="softVersion" name="softVersion" type="text"value="${apkfile.softVersion}"></input></td>
					<td><div id="softVersionTip"></div></td>
				</tr>
				<tr>
					<td style="text-align: right"><span style="color: red"></span>文件:</td>
					<td><input id="apkfile" name="apkfile" type="text"
						value="${apkfile.apkfile}" readonly="readonly" /> <a
						id="filemanager" href="#" class="easyui-linkbutton"
						iconCls="icon-add">服务器</a></td>
					<td><div id="apkfileTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="edit()" class="easyui-linkbutton"
								iconCls="icon-ok">确定</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input id="id" name="id" type="hidden" value="${apkfile.id}" /> <input
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
			formid : "editForm"
		});
		
		$("#title").formValidator({
			onfocus : "题目不能为空！并且不超过100字符"
		}).inputValidator({
			min : 1,
			max : 100
		});
		
		$("#text").formValidator({
			onfocus : "内容不能为空！并且不超过2000字符"
		}).inputValidator({
			min : 1,
			max : 2000
		});
	});
</script>
</html>