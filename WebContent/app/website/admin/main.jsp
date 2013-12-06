<%@page import="com.saturn.auth.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理网站内容</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function getPath(node) {
		var mode = node.attributes.mode;
		var path = "editContentArticle.jsp"
		if (mode == "content.mode.more") {
			path = "listArticle.jsp";
		}
		path += "?cid="+node.id;
		
		return '<iframe scrolling="yes" frameborder="0"  src="<%=request.getContextPath()%>/app/website/admin/' + path + '" style="width:100%;height:100%;"></iframe>'
	}

	function addTab(pageTab, node) {
		pageTab.tabs('add', {
			title : node.text,
			content : getPath(node),
			iconCls : 'icon-tap',
			closable : false
		});
	}
	
	$(function() {
		$('#navigateTree').tree({
			url: '<%=request.getContextPath()%>/app/website/content/tree.action?cid=<%=request.getParameter("cid")%>',
			onClick : function(node) {
				var text = node.text;
				var pageTab = $('#pageTab');
				var tab = pageTab.tabs('getSelected');
				
				if (($('#navigateTree').tree('isLeaf',
						node.target) == true ) && (node.attributes!=null)) {
             	
					if (tab == null) {
						addTab(pageTab, node);
					} else {
						$('#pageTab').tabs('update', {
							tab: tab,
							options:{
								title : node.text,
								iconCls : 'icon-tap',
								content : getPath(node)
							}
						});
					}
				}
				
				//return false;
			}
		});
	});
</script>
</head>
<body class="easyui-layout">
	<div region="west" split="true" title="目录列表"
		style="width: 150px; padding1: 10px; overflow: hidden;">
		<div style="padding: 10px;">
			<ul id="navigateTree" class="easyui-tree">
			</ul>
		</div>
	</div>
	<div region="center" style="overflow: hidden;">
		<div id="pageTab" class="easyui-tabs" fit="true" border="false">
		</div>
	</div>
</body>
</html>