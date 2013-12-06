<%@page import="com.saturn.website.Content"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加新闻图片</title>
<!-- kindEditor和easyui样式冲突 -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/panel.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/combo.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/combobox.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/linkbutton.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/saturn.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/app/themes/saturn/formValidator/validator.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>

<%@ include file="/app/includes/kindEditor.jsp"%>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
	
	KindEditor.ready(function(K) {

		//-------单独上传图片----------
		var uploadbutton = K.uploadbutton({
			button : K('#uploadButton')[0],
			fieldName : 'imgFile',
			url : '<%=request.getContextPath()%>/app/system/upload/upload.action?dir=appCar',
			afterUpload : function(data) {
				if (data.error === 0) {
					var url = K.formatUrl(data.url, 'absolute');
					
					K('#imageUrl').val(url);
					$('#imageShow').attr("src", url);
				} else {
					alert(data.message);
				}
			}
		});
		
		uploadbutton.fileBox.change(function(e) {
			uploadbutton.submit();
		});
		
		var editor = K.editor({
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action?dir=appCar'
		});
		K.plugin('filemanager').call(editor, K);
		K('#filemanager').click(function() {
			var dialog = editor.plugin.filemanagerDialog({
				viewType : 'VIEW',
				clickFn : function(url, title) {
					K('#image').val(url);
					editor.hideDialog();
					$('#imageShow').attr("src", url);
				}
			});
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
			width : 250,
			value : "visible.true",
			onSelect : function(record){
				$('#stateName').val(record.text);
		    }
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改图片信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/website/admin/updateImage.action"
			method="post">
			<table>
				<tr>
					<td width="550px">
						<table class="table-form">
							<tr>
								<td style="text-align: right"><span style="color: red">*</span>显示:</td>
								<td><select id="state" class="easyui-combobox" name="state"
									url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
									valueField="id" textField="text" editable="false"></select></td>
								<td><div id="stateTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right">图片:</td>
								<td><input id="imageUrl" name="imageUrl" type="text" value="${img.imageUrl}"
									readonly="readonly" /></td>
								<td><div id="imageUrlTip"></div></td>
							</tr>
							<tr>
								<td colspan="3">
									<div style="padding: 10px;">
										<a href="#" onclick="add()" class="easyui-linkbutton"
											iconCls="icon-add">添加</a> <a
											href="javascript:history.back(-1)" class="easyui-linkbutton"
											iconCls="icon-cancel">取消</a>(提交: Ctrl+Enter)
									</div>
								</td>
							</tr>
						</table>
					</td>
					<td><img id="imageShow" alt="" src="${img.imageUrl}" width="150px" />
						<div>
							<a id="filemanager" href="#" class="easyui-linkbutton"
								iconCls="icon-add">服务器</a> <input type="button"
								id="uploadButton" value="上传" style="width: 70" />
						</div></td>
				</tr>
			</table>
			<input id="id" type="hidden" name="id" type="text" value="${img.id}""></input>
			<input id="articleId" type="hidden" name="articleId" type="text" value="${img.articleId}""></input>
			<input id="stateName" type="hidden" name="stateName" type="text" value="${img.stateName}""></input> 
			<input id="createTime" type="hidden" name="createTime" type="text" value="<%=DateUtils.getSystemTime()%>"></input>
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
		
		$("#text").formValidator({
			onfocus : "内容不能为空！并且不超过2000字符"
		}).inputValidator({
			min : 1,
			max : 2000
		});
	});
</script>
</html>
