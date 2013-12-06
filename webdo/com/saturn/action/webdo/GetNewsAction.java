package com.saturn.action.webdo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.website.Article;

public class GetNewsAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String json =request.getParameter("json");
		/*String json =	"{"
		+"\"command\":6003,"  //--接口标识
		+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
		+"\"param\" : {"
			+"\"newsType\" : \"webapp.kcdt\","               
			+"\"lastNewsId\" : \"0\","               
			+"\"newsCount\" : \"10\""        
			+"}"
		+"}";*/
		
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command  = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		
		String status = "";
		String message = "";
		String newsType = jsonobject2.get("newsType").toString();
		String lastNewsId = jsonobject2.get("lastNewsId").toString();
		String newsCount = jsonobject2.get("newsCount").toString();
		
		Article vo = new Article();
		vo.setType(newsType);
		vo.setPoint(lastNewsId);
		
		String offset = "0";
		
		try {
			int count = Integer.parseInt(newsCount);
			if(count>0) {
				offset = "" + count;
			}
		} catch (Exception e) {
			
		}
		
		List<HashMap> resultList = Article.getArcileByType(vo, "0", offset);
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();
		if(resultList.isEmpty()){
			//密码不正确
			status = "F";
			message = "无信息";
		}else{
			status = "T";
			message = "有信息";
			//
			
			String downurl = request.getRequestURL().toString();
			
			String[] urls = downurl.split("/");
			if(urls.length>=3)
				downurl = "http://"+urls[2]+"";
			else
				downurl="http://";
			//
			for(Map map: resultList){
				String t_newsId = ""+map.get("point");
				String t_newsType = ""+map.get("type");
				String t_title = ""+map.get("title");
				String t_summary = ""+map.get("summary");
				String image = ""+map.get("image");
				String t_thumbnail = "";
				if("".equals(""+map.get("image"))) {
					 t_thumbnail = "";
				} else {
					 t_thumbnail = downurl+map.get("image");
				}
				String t_createTime = ""+map.get("createTime");
				JSONObject t_job = new JSONObject();
				t_job.put("newsId", t_newsId);
				t_job.put("newsType", t_newsType);
				t_job.put("title", t_title);
				t_job.put("summary", t_summary);
				t_job.put("thumbnail", t_thumbnail);
				t_job.put("createTime", t_createTime);
				returnList.add(t_job);
			}
		}
		
		JSONArray job = new JSONArray();
		job.addAll(returnList);
		
		Map map2 = new HashMap();
		map2.put("data", job);
		JSONObject job2 = new JSONObject();
		job2.putAll(map2);
		
		Map map3 = new HashMap();
		map3.put("command", command);
		map3.put("status", status);
		map3.put("message", message);
		map3.put("result", job2);
		
		JSONObject job3 = new JSONObject();
		job3.putAll(map3);
		
		String ss = job3.toString();
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(ss);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.flushBuffer();
			} catch (IOException ie) {
				ie.printStackTrace();
			}
		}
		
		return null;
	}
	
	@Override
	public String requestMapping() {
		return "/app/webdo/news/getNews.do";
	}
}
