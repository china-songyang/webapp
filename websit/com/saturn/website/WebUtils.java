package com.saturn.website;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class WebUtils {
	
	public static String getTextWithMax(String text, int max) {
		if (text == null) {
			return "";
		}
		text=text.replaceAll("<.+?>", "").replaceAll("&nbsp;", "");
		if (text.length() <= max) {
			return text;
		}
		
		return text.substring(0, max) + "...";
	}
	
	public static String getRootCid(HttpServletRequest request) {
		String uri = request.getRequestURI();
		
		String rootCid = "rongzhan";
		
		if (uri != null) {
			String[] subs = uri.split("/");
			if (subs.length >= 3) {
				rootCid = subs[2];
			}
		}
		return rootCid;
	}
	
	public static String getTitle(HttpServletRequest request) {
		String cid = request.getParameter("cid");
		String aid = request.getParameter("aid");
		
		String title = "首页";
		
		if (cid == null) {
			return title;
		}
		
		if (aid == null) {
			List<Content> children = Content.getChildren(cid);
			if (children != null && !children.isEmpty()) {
				aid = children.get(0).getId();
			}
		}
		
		Content content = Content.get(aid);
		if (content != null) {
			title = content.getName();
		} 
		
		return title;
	}
	
	public static String getLink(String cid, String aid) {
		if (cid == null) {
			return "index.jsp";
		}
		
		Content content = Content.get(cid);
		
		if (content == null) {
			return "index.jsp";
		}
		
		String path = content.getPath();
		if (aid != null && !"".equals(aid)) {
			Content child = Content.get(aid);
			if (child != null) {
				path = child.getPath();
			}
		}
		
		String mode = content.getMode();
		if (path == null || "".equals(path.trim())) {
			if ("content.mode.more".equals(mode)) {
				path = "list.jsp";
			} else  {
				path = "content.jsp";
			}
		}
		
		path += "?cid=" + cid;
		if (aid != null && !"".equals(aid)) {
			path += "&aid=" + aid;
		}
		
		return path;
	}
	/*public static void main(String[] args){
		String text="<p><span style=\"font-size:14px;\"><span style=\"font-family:SimSun;\"></span></span><span style=\"line-height:1;\">&nbsp;</span><span style=\"font-size:14px;\"><span style=\"font-family:SimSun;\"><span style=\"line-height:1;\">&nbsp;&nbsp;&nbsp;</span><span style=\"line-height:2;\">&nbsp;</span><span style=\"line-height:2;font-size:14px;\">融展是事业的港湾，我们把员工作为公司的服务对象，为员工的学习 、 工作、发展提供服务，努力为员工创造良好的工作环境，建造良好的事业发展平台,使您的知识技能、聪明才智得以施展，事业理想得以实现。</span></span></span> </p>";
		text=text.replaceAll("<.+?>", "");
		System.out.println(text);
		//text.substring(text.indexOf("<span"), text.indexOf(">"));
	}*/
}
