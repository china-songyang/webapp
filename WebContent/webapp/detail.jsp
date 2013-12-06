<%@page import="com.saturn.website.PaginationUtils"%>
<%@page import="com.saturn.website.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/include.jsp"%>
<title>长春市志昂生物科技有限公司</title>
<script src="js/swfobject_modified.js" type="text/javascript"></script>
<link href="css/base.css" rel="stylesheet" type="text/css" />
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
          	String did = request.getParameter("did");
          	String indexStr = request.getParameter("index");
			Article article = new Article();
          	if(did.contains("geneonproduct")){
          		 article = Article.getOneByCid(did);
          	} else {
				 article = Article.get(did);
          	}
			//Article article = Article.getOneByCid(did);
			String title = "";
			String text = "";
			String datetime = "";
			String source = "";
			
			if (article != null) {
				title = article.getTitle();
				text = article.getText();
				datetime = article.getCreateTime();
				source = article.getOperaterName();
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
							<%=PaginationUtils.getPagination("detail.jsp?cid=" + __cid + "&did=" + did, indexStr, text) %>
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