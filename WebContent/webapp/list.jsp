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
			<div class="right">
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
				<div class="party">
					<div class="partay">
						<h1><%=__cname %></h1>
					</div>
					<div class="partby">
						<div class="wz a">
							<%
		        	    List all = Article.getByCid(__cid);
		        		String indexStr = request.getParameter("index");
		        		List articles = PaginationUtils.getPaginationList(all, indexStr);
						if (articles != null && !articles.isEmpty()) {
							for (int i = 0; i < articles.size(); ++i) {
								Article article = (Article)articles.get(i);
								
								String state = article.getStateName();
								if ("隐藏".equals(state)) {
									continue;
								}
								String title = article.getTitle();
								String type = article.getType();
								String did = article.getId();
								String datetime = article.getCreateTime();
								if (datetime != null) {
									datetime = datetime.substring(0,10);
								}
								
								String typeShow = "";
								if ("article.state.recommand".equals(type)) {
									typeShow = "<img src=\"images/iecool_arrow_157.gif\" width=\"28\" height=\"11\" />";
								} else if ("article.state.top".equals(type)) {
									typeShow = "[置顶]";
								}
						%>
							<div class="news">
								<div class="newst">
									<img src="images/iecool_arrow_168.gif" width="11" height="11" />
								</div>
								<div class="newsn">
									<a href="detail.jsp?cid=<%=__cid%>&did=<%=did%>"><%=title%></a>
								</div>
								<div class="time">
									[<%=datetime%>]
								</div>
							</div>
							<!--新闻-->
							<%
							}
						}
						%>
							<div align="center" style="padding-right: 20px"><%=PaginationUtils.getPagination("list.jsp?cid=" + __cid, indexStr, all) %></div>
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