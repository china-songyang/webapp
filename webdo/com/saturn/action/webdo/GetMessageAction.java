package com.saturn.action.webdo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*import org.jivesoftware.smack.Connection;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.Roster;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;*/

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.mobile.MobileMessage;

public class GetMessageAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		//String json = readJSONString(request);
		String json = request.getParameter("json");
		/*String json =	"{"
						+"\"command\":6002,"  //--接口标识
						+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
						+"\"param\" : {"
							+"\"userId\" : \"system\","               
							+"\"msgId\" : \"0\","               
							+"\"timeStamp\" : \"2013-07-04 15:20:00\","               
							+"\"msgType\" : \"2\","               
							+"\"msgCount\" : \"2\","         //--手机使用的os版本，例如2.2或者4.1.2等
							+"\"order\" : \"1\""        
							+"}"
						+"}";*/
		
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		String status = "";
		String message = "";                     //--如果错误，返回错误结果
		
		String userId = jsonobject2.get("userId").toString();
		String msgId = jsonobject2.get("msgId").toString();
		String msgType = jsonobject2.get("msgType").toString();
		String msgCount = jsonobject2.get("msgCount").toString();
		String order = jsonobject2.get("order").toString();
		
		MobileMessage vo = new MobileMessage();
		//vo.setId(msgId);
		vo.setUserid(userId);
		vo.setType(msgType);
		vo.setPoint(msgId);
		
		String offset = "0";
		try {
			int count = Integer.parseInt(msgCount);
			if(count>0) {
				offset = ""+count;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		List<HashMap> resultList = MobileMessage.getMessagesByMobile(vo, "0", offset, order);
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();
		if(resultList.isEmpty()){
			//密码不正确
			status = "F";
			message = "无信息";
		}else{
			status = "T";
			message = "有信息";
			for(Map map: resultList){
				String t_userId = ""+map.get("userId");
				String t_msgId = ""+map.get("point");
				String t_msgTitle = ""+map.get("title");
				String t_msgContent = ""+map.get("text");
				String t_msgTime = ""+map.get("sendTime");
				String t_level = ""+map.get("level");	//--用户名等级
				String t_msgType = ""+map.get("type");
				JSONObject t_job = new JSONObject();
				t_job.put("userId", t_userId);
				t_job.put("msgId", t_msgId);
				t_job.put("msgTitle", t_msgTitle);
				t_job.put("msgContent", t_msgContent);
				t_job.put("msgTime", t_msgTime);
				t_job.put("level", t_level);
				t_job.put("msgType", t_msgType);
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
		//return new JsonView(ss);
		
	}
	
	/*public static class IMServer {  
	    private  static final String IP = "127.0.0.1";  
	    private  static final Integer DK = 5222;  
	    private  Roster roster;
	    
	    public static Connection getConnection() {  
	        ConnectionConfiguration config = new ConnectionConfiguration(IP, DK);  
	        Connection connection = new XMPPConnection(config);  
	        return connection;  
	    } 
	    
	    public void SendBCMsg(String username, String pass, String messgage,  
	            String groupName) throws XMPPException {  
	        Connection con = IMServer.getConnection();  
	        con.connect();  
	        con.login(username, pass);  
	        Message m = new Message();  
	        m.setBody(messgage);// 设置消息。  
	        m.setTo(groupName + "@broadcast.xjtu");// [groupname]@[serviceName].[serverName]  
	        con.sendPacket(m);  
	    }
	}*/
	@Override
	public String requestMapping() {
		return "/app/webdo/message/getMessage.do";
	}
}


