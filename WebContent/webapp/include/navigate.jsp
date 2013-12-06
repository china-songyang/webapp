<%@page import="com.saturn.website.WebUtils"%>
<%@page import="com.saturn.website.Content"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="part">
	<div class="parta">
		<h1>产品目录</h1>
		<div class="more">
			<a href="<%=WebUtils.getLink("geneon.product", null)%>"><img
				src="images/more.png" width="44" height="13" /></a>
		</div>
	</div>
	<div class="partb">
		<%
List __product = Content.getChildren("geneonproduct");
if (!__product.isEmpty()) {
	for (int i = 0; i < __product.size(); ++i) {
		Content child = (Content)__product.get(i);
		if ("显示".equals(child.getHasShowName())) {
			String id = child.getId();
			String name = child.getName();
			String urlz = child.getPath();
			%>
		<div class="xly">
			<div class="tb">
				<img src="images/iecool_arrow_051.gif" width="13" height="12" />
			</div>
			&nbsp;<%=name %></div>
		<!--系列一-->
		<%
			List __product_2 = Content.getChildren(id);
			if (!__product_2.isEmpty()) {
				for (int j = 0; j < __product_2.size(); ++j) {
					Content child_2 = (Content)__product_2.get(j);
					if ("显示".equals(child_2.getHasShowName())) {
						String id_2 = child_2.getId();
						String name_2 = child_2.getName();
						String urlz_2 = child_2.getPath()!=null&&!"".equals(child_2.getPath())?child_2.getPath()+"?cid=geneon.product&aid="+id_2+"&did="+id_2:"";
					%>
		<div class="xlr">
			<p>
				<a href="<%= urlz_2%>">·<%=name_2 %></a>
			</p>
		</div>
		<!--系列二-->
		<% 
					}
				}
			}
		}
	}
}
%>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>