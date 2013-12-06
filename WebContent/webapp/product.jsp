<%@page import="java.util.ArrayList"%>
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
        %>
			<div class="right">
				<div class="party">
					<div class="partay">
						<h1><%=__cname %></h1>
					</div>
					<div class="partby">
						<%
		                String __aid = request.getParameter("aid");
		                List all = new ArrayList();
	                	if(__aid==null||"".equals(__aid)){
	                		all = Article.getLikeCid("geneonproduct.");
	                	}else{
	                		all = Article.getLikeCid(__aid);
	                	}
		        		String indexStr = request.getParameter("index");
		        		List articles = PaginationUtils.getPaginationList(all, indexStr, 25);
						if (articles != null && !articles.isEmpty()) {
							int i=0;
							%>
						<div class="cpxl">
							<%
							for (; i < articles.size() && i<5; ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getCid();
								String urlz = article.getImage();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								%>
							<div class="cpa">
								<div class="cpao">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title %></a>
								</h3>
							</div>
							<%
							}
							%>
							<div class="clear"></div>
						</div>
						<!-------------->
						<div class="cpxl">
							<%
							for (; i < articles.size() && i<10; ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getCid();
								String urlz = article.getImage();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								%>
							<div class="cpa">
								<div class="cpao">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title %></a>
								</h3>
							</div>
							<%
							}
							%>
							<div class="clear"></div>
						</div>
						<!-------------->
						<div class="cpxl">
							<%
							for (; i < articles.size() && i<15; ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getCid();
								String urlz = article.getImage();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								%>
							<div class="cpa">
								<div class="cpao">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title %></a>
								</h3>
							</div>
							<%
							}
							%>
							<div class="clear"></div>
						</div>
						<!-------------->
						<div class="cpxl">
							<%
							for (; i < articles.size() && i<20; ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getCid();
								String urlz = article.getImage();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								%>
							<div class="cpa">
								<div class="cpao">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title %></a>
								</h3>
							</div>
							<%
							}
							%>
							<div class="clear"></div>
						</div>
						<!-------------->
						<div class="cpxl">
							<%
							for (; i < articles.size() && i<25; ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getCid();
								String urlz = article.getImage();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								%>
							<div class="cpa">
								<div class="cpao">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title %></a>
								</h3>
							</div>
							<%
							}
							%>
							<div class="clear"></div>
						</div>
						<%
							
						}
						%>
						<div align="center" style="padding-right: 20px"><%=PaginationUtils.getPagination("product.jsp?cid=" + __cid+"&aid=" + __aid, indexStr, all) %></div>
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