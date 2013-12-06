<%@page import="com.saturn.website.WebUtils"%>
<%@page import="com.saturn.website.Content"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="header">
	<div class="logo">
		<img src="images/logo.jpg" width="227" height="90" />
	</div>
	<div class="writing">
		<object id="FlashID"
			classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="504"
			height="79">
			<param name="movie" value="flash/11.swf" />
			<param name="quality" value="high" />
			<param name="wmode" value="transparent" />
			<param name="swfversion" value="6.0.65.0" />
			<!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
			<param name="expressinstall" value="Scripts/expressInstall.swf" />
			<!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
			<!--[if !IE]>-->
			<object type="application/x-shockwave-flash" data="flash/11.swf"
				width="504" height="79">
				<!--<![endif]-->
				<param name="quality" value="high" />
				<param name="wmode" value="transparent" />
				<param name="swfversion" value="6.0.65.0" />
				<param name="expressinstall" value="Scripts/expressInstall.swf" />
				<!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
				<div>
					<h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
					<p>
						<a href="http://www.adobe.com/go/getflashplayer"><img
							src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
							alt="获取 Adobe Flash Player" width="112" height="33" /></a>
					</p>
				</div>
				<!--[if !IE]>-->
			</object>
			<!--<![endif]-->
		</object>
	</div>
	<div class="join">
		<p>
			<a href="javascript:void(0);"
				onclick='window.external.AddFavorite("http://www.geneonbio.com/","【长春市志昂生物科技有限公司】")'>&nbsp;&nbsp;加入收藏</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0);"
				onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.geneonbio.com');">设为首页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=WebUtils.getLink("geneon.contact", null)%>">联系我们</a>
		</p>
	</div>
	<div class="clear"></div>
</div>
<!--头部-->
<div id="nav">
	<ul>
		<%
				List __contents = Content.getChildren(WebUtils.getRootCid(request));
				String __id = request.getParameter("cid");

				if (!__contents.isEmpty()) {
					for (int i = 0; i < __contents.size(); ++i) {
						Content content = (Content) __contents.get(i);
						if ("显示".equals(content.getHasShowName())) {
							String id = content.getId();
							if (__id == null) {
								__id = id;
							}

							String css = "";
							if (__id.equals(id)) {
								css = "color:#11b5eb";
							}
			%>
		<li><a href="<%=WebUtils.getLink(id, null)%>" style="<%=css%>"><%=content.getName()%></a></li>
		<%
						}
					}
				}
			%>
	</ul>
</div>
<!--导航-->
<%@ include file="banner.jsp"%>

