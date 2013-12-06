<%@page import="com.saturn.auth.User"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<%@page import="com.saturn.website.Content"%>
<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文章信息</title>
<!-- kindEditor和easyui样式冲突 -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/window.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/messager.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/panel.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/combo.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/app/themes/saturn/combobox.css">
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
	<%
		String cid = request.getParameter("cid");
		Content content = Content.get(cid);
		String name = content.getName();
		
		Article	article = Article.getOneByCid(cid);
		User user = (User)session.getAttribute("authUser");
		String userId = "";
		String userName = "";
		
		if (user != null) {
			userId = user.getId();
			userName = user.getName();
			
			if (article == null) {
				article = new Article(null, cid, name, "", "article.state.normal", "普通", "visible.true", "显示", "0", DateUtils.getSystemTime(), user.getId(), user.getName(), "");
				Article.add(article);
			}
		}
		
		request.setAttribute("article", article);
	%>
	
	var editor = "";
	
	function edit() {
		editor.sync();
		$('#editForm').submit();
	}
	
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="text"]', {
			cssPath : '<%=request.getContextPath()%>/app/js/kindEditor/plugins/code/prettify.css',
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action',
			uploadJson : '<%=request.getContextPath()%>/app/system/upload/upload.action',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['editForm'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['editForm'].submit();
				});
			}
		});
	});
	
	$(function() {
		$('#text').focus();
		
		<%
		Object result = request.getParameter("result");
		if (result != null && "true".equals(result)) {
		%>
			$(function() {
				$.messager.show({
					title:'信息',
					msg:'保存成功',
					showType:'show'
				});
			});
		<%
		}
		%>
	});
	
	<%
		Object __user = request.getSession().getAttribute("authUser");
		if (__user == null && request.getRequestURI().indexOf("/app/") >= 0) {
	%>
	
	$(function() {
		/*$.messager.show({
			title:'信息',
			msg:'用户会话过期，请重新登录',
			showType:'show'
		});*/
		$.messager.confirm('用户过期', '请重新登录', function(r){
			top.location.href = '<%=request.getContextPath()%>/app/login.jsp';
		});
	});
	<%
		}
	%>
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改<%=name%>"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">
		<form id="editForm"
			action="<%=request.getContextPath()%>/app/website/admin/addOrEdit.action"
			method="post">
			<table class="table-form">
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="edit()" class="easyui-linkbutton"
								iconCls="icon-ok">确定</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>(提交: Ctrl
							+ Enter)
						</div>
					</td>
				</tr>
			</table>
			<textarea name="text" cols="100" rows="8"
				style="width: 700px; height: 200px; visibility: hidden;">${article.text}</textarea>
			<input id="id" type="hidden" name="id" type="text"
				value="${article.id}"></input> <input id="type" type="hidden"
				name="type" type="hidden" value="${article.type}"></input> <input
				id="typeName" type="hidden" name="typeName" type="text"
				value="${article.typeName}"></input> <input id="state" type="hidden"
				name="state" type="hidden" value="${article.state}"></input> <input
				id="stateName" type="hidden" name="stateName" type="text"
				value="${article.stateName}"></input> <input id="cid" type="hidden"
				name="cid" value="<%=cid%>"></input> <input id="title" type="hidden"
				name="title" type="text" value="<%=name%>"></input> <input
				id="createTime" type="hidden" name="createTime"
				value="${article.createTime}"></input> <input id="operater"
				type="hidden" name="operater" type="text" value="<%=userId%>"></input>
			<input id="operaterName" type="hidden" name="operaterName"
				type="text" value="<%=userName%>"></input> <input id="image"
				type="hidden" name="image" type="text" value="${article.image}"></input>
		</form>
	</div>
</body>
</html>