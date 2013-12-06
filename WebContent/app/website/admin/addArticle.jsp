<%@page import="com.saturn.website.Content"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加网站文章</title>
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

<link href="<%=request.getContextPath()%>/app/website/admin/jquery/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/app/website/admin/jquery/swfobject.js"></script>
<script type="text/javascript" src = "<%=request.getContextPath()%>/app/website/admin/jquery/jquery.uploadify.v2.1.0.js"></script>

<%@ include file="/app/includes/kindEditor.jsp"%>
<script type="text/javascript">
	<%
		String cid = request.getParameter("cid");
		Content content = Content.get(cid);
		String cname = content.getName();
	%>
	
	var editoraa = "";
	
	function add() {
		editoraa.sync();
		$('#addForm').submit();
	}
	
	KindEditor.ready(function(K) {

		//-----编辑器上传图片----
		editoraa = K.create('textarea[name="text"]', {
			cssPath : '<%=request.getContextPath()%>/app/js/kindEditor/plugins/code/prettify.css',
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action',
			uploadJson : '<%=request.getContextPath()%>/app/system/upload/upload.action',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['addForm'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['addForm'].submit();
				});
			}
		});
		//-------单独上传图片----------
		var uploadbutton = K.uploadbutton({
			button : K('#uploadButton')[0],
			fieldName : 'imgFile',
			url : '<%=request.getContextPath()%>/app/system/upload/upload.action?dir=appCar',
			afterUpload : function(data) {
				if (data.error === 0) {
					var url = K.formatUrl(data.url, 'absolute');
					
					K('#image').val(url);
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

	<script type="text/javascript">
			$(document).ready(function() {
			　$("#uploadify").uploadify({
				　'uploader': 'uploadify.swf',  
				　//'script':'upload!doUpload.action?name=yangxiang',
				  'script': '<%=request.getContextPath()%>/app/system/upload/batchupload.do?dir=appCar',
				　//'script': 'servlet/Upload?name=yangxiang',  
				　'cancelImg': 'jquery/cancel.png',                  
				　'queueID' : 'fileQueue', //和存放队列的DIV的id一致  
				　//'fileDataName': 'fileupload', //必须，和以下input的name属性一致                   
				　'auto'  : false, //是否自动开始  
				　'multi': true, //是否支持多文件上传  
				  'buttonText': "upload", //按钮上的文字  
				　'simUploadLimit' : 1, //一次同步上传的文件数目  
				　'sizeLimit': 19871202, //设置单个文件大小限制，单位为byte  
				　'queueSizeLimit' : 5, //队列中同时存在的文件个数限制  
				　'fileDesc': '支持格式:jpg/gif/jpeg/png/bmp.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的  
				　'fileExt': '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式
				　'onComplete': function (event, queueID, fileObj, response, data) {
						//alert(event+"--"+queueID+"--"+fileObj+"--"+response+"--"+data);
						var jsonObj = eval("("+response+")");
						if(jsonObj.error==0) {
							alert("文件:" + fileObj.name + "上传成功");
							$("#imgVeiw").html($("#imgVeiw").html()+"<img width=\"110\" height=\"100\" id=\"" + fileObj.name + "\" src=\"" + jsonObj.url + "\" alt=\"" + fileObj.name + "\" />");
							$("#imageUrl").val($("#imageUrl").val()+jsonObj.url + ";");
						}else{
							alert("文件:" + fileObj.name + "上传失败!\n原因:" + jsonObj.message);
						}
				　},  
				　'onError': function(event, queueID, fileObj) {  
				　		alert("文件:" + fileObj.name + "上传失败");  
				　},  
				　'onCancel': function(event, queueID, fileObj){  
				　		/* alert("取消了" + fileObj.name);  */ 
				　} 
			　});
		　});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加<%=cname%>信息"
		icon="icon-add-form" collapsible="true" style="padding: 10px;">
		<form id="addForm"
			action="<%=request.getContextPath()%>/app/website/admin/add.action?cid=<%=cid%>"
			method="post">
			<table>
				<tr>
					<td width="550px">
						<table class="table-form">
							<tr>
								<td style="text-align: right"><span style="color: red">*</span>题目:</td>
								<td><input id="title" name="title" type="text"></input></td>
								<td><div id="titleTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right"><span style="color: red">*</span>概要:</td>
								<td><textarea id="summary" name="summary" style="width: 250px; height: 100px;"></textarea></td>
								<td><div id="summaryTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right"><span style="color: red">*</span>作者/来源:</td>
								<td><input id="author" name="author"></input></td>
								<td><div id="authorTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right">创建时间:</td>
								<td><input id="createTime" name="createTime" class="easyui-datetimebox" type="text"></input></td>
							</tr>
							<tr>
								<td style="text-align: right">显示:</td>
								<td><select id="state" class="easyui-combobox" name="state"
									url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=visible"
									valueField="id" textField="text" editable="false"></select></td>
								<td><div id="stateTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right">缩略图:</td>
								<td><input id="image" name="image" type="text" value=""
									readonly="readonly" /></td>
								<td><div id="imageTip"></div></td>
							</tr>
							<tr>
								<td style="text-align: right">新闻图片:</td>
								<td><input id="imageUrl" name="imageUrl" type="text" value=""
									readonly="readonly" /></td>
								<td><div id="imageTip"></div></td>
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
					<td><img id="imageShow" alt="" src="" width="150px" />
						<div>
							<a id="filemanager" href="#" class="easyui-linkbutton"
								iconCls="icon-add">服务器</a> <input type="button"
								id="uploadButton" value="上传" style="width: 70" />
						</div></td>
				</tr>
			</table>
			<font color="#2F6BBD" size="2px">内容：</font>
			<textarea name="text" cols="100" rows="8" style="width: 700px; height: 200px; visibility: hidden;"></textarea><br>
			<font color="#2F6BBD" size="2px">上传新闻图片：</font><br>
			<a href="javascript:jQuery('#uploadify').uploadifyUpload()">开始上传</a>&nbsp;
			<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消所有上传</a><br><br>
			<input type="file" name="uploadify" id="uploadify" />
			<div id="imgVeiw"></div>
			<div id="fileQueue"></div>
			<input id="stateName" type="hidden" name="stateName" type="text" value="显示"></input> 
			<input id="operater" type="hidden" name="operater" type="text" value="${authUser.id}"></input>
			<input id="operaterName" type="hidden" name="operaterName" type="text" value="${authUser.name}"></input>
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
		
		$("#author").formValidator({
			onfocus : "作者/来源不能为空"
		}).inputValidator({
			min : 1,
			max : 50
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






