<%@page import="com.saturn.website.PaginationUtils"%>
<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/include.jsp"%>
<script src="js/swfobject_modified.js" type="text/javascript"></script>
<link href="css/base.css" rel="stylesheet" type="text/css" />
<title>长春市志昂生物科技有限公司</title>
</head>
<body>
	<div id="container">
		<%@ include file="include/top.jsp"%>
		<div id="content">
			<%@ include file="include/left.jsp"%>
			<%
       		String __cid = request.getParameter("cid");
        	String __cname = "首页";
          	if (__cid != null) {
          		Content content = Content.get(__cid);
          		if (content != null) {
          			__cname = content.getName();
          		}
          	}
			Article article = Article.getOneByCid(__cid);
	  	  	String indexStr = request.getParameter("index");
			String title = "";
			String text = "";
			
			if (article != null) {
				title = article.getTitle();
				response.setHeader("title", title);
				text = article.getText();
			}
		%>
			<div class="right">
				<div class="party">
					<div class="partay">
						<h1><%=__cname %></h1>
					</div>
					<div class="partby">
						<p><%=PaginationUtils.getPageText(text, indexStr)%></p>
						<div align="center" style="padding-right: 20px">
							<%=PaginationUtils.getPagination("content.jsp?cid=" + __cid, indexStr, text) %>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!--右-->

			</div>
			<!--右侧-->
			<div class="clear"></div>
		</div>
		<!--内容-->
		<%@ include file="include/foot.jsp"%>
	</div>
	<!--容器-->
	<script type="text/javascript">
<!--
swfobject.registerObject("FlashID");
swfobject.registerObject("FlashID2");
//-->
</script>
</body>
</html>