<%@page import="com.saturn.website.PaginationUtils"%>
<%@page import="java.util.ArrayList"%>
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
			<div class="right">
				<div class="party">
					<div class="partay">
						<h1>公司简介</h1>
						<div class="more">
							<a href="<%=WebUtils.getLink("geneon.about", null)%>"><img
								src="images/more.png" width="44" height="13" /></a>
						</div>
					</div>
					<div class="partbyy">
						<div class="wz">
							<p><%=WebUtils.getTextWithMax(Article.getOneArticleText("geneon.about"), 450)%></p>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!--右-->
				<div class="party">
					<div class="partay">
						<h1>产品展示</h1>
						<div class="more">
							<a href="<%=WebUtils.getLink("geneon.product", null)%>"><img
								src="images/more.png" width="44" height="13" /></a>
						</div>
					</div>
					<div class="partbyc">
						<%
		                List all = new ArrayList();
	                	all = Article.getLikeCid("geneonproduct.");
		        		String indexStr = request.getParameter("index");
		        		List articles = PaginationUtils.getPaginationList(all, indexStr, 20);
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
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><%=title %></a>
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
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><%=title %></a>
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
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><%=title %></a>
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
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><img
										src="<%=urlz %>" alt="" width="128" height="125" /></a>
								</div>
								<h3>
									<a href="detail.jsp?cid=geneon.product&did=<%=did%>"><%=title %></a>
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
						<div class="clear"></div>
					</div>
					<!--产品展示-->
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