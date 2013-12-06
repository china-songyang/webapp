package com.saturn.action.webdo;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.website.Article;

public class GetNewsDetailAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String json =request.getParameter("json");
		/*String json =	"{"
		+"\"command\":6003,"  //--接口标识
		+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
		+"\"param\" : {"
			+"\"newsType\" : \"webapp.kcdt\","               
			+"\"newsId\" : \"10\""       
			+"}"
		+"}";*/
		
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command  = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		
		String status = "";
		String message = "";
		String newsType = jsonobject2.get("newsType").toString();
		String newsId = jsonobject2.get("newsId").toString();
		
		Article vo = new Article();
		vo.setType(newsType);
		vo.setPoint(newsId);
		
		String offset = "100";
		
		List<HashMap> resultList = Article.getArcileById(vo, "0", offset);
		JSONObject t_job = new JSONObject();
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
				downurl = "http://"+urls[2];
			else
				downurl="http://";
			//
			for(Map map: resultList){
				String t_id = ""+map.get("id");
				String t_title = ""+map.get("title");
				String t_author = ""+map.get("author");
				String t_summary = ""+map.get("summary");
				String t_createTime = "" + map.get("createTime");
				String t_content = "" + map.get("text");
				String t_imageUrl = "" + map.get("imageUrl");
				/*
				String image = ""+map.get("image");
				String t_imgUrl = "";
				if("".equals(""+map.get("image"))) {
					 t_imgUrl = "";
				} else {
					 t_imgUrl = downurl+map.get("image");
				}*/
				/*StringBuffer t_imgUrl = new StringBuffer();
				List<Image> imgs = Image.getByAid(t_id);
				for(Image img: imgs){
					t_imgUrl.append(img.getImageUrl()).append(";");
				}*/
				
				t_job.put("title", t_title);
				t_job.put("author", t_author);
				t_job.put("summary", t_summary);
				t_job.put("createTime", t_createTime);
				t_job.put("content", t_content);
				t_job.put("imgUrl", t_imageUrl);
				
				break;
			}
		}
		Map map2 = new HashMap();
		map2.put("data", t_job);
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
		return "/app/webdo/news/getNewsDetail.do";
	}
}
