package com.saturn.action.mobile.message;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jivesoftware.smack.Connection;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;
import com.saturn.mobile.MobileMessage;
import com.saturn.mobile.MsgReUser;

public class SendMessageAction implements IAction {

	private static final String IP = "127.0.0.1";
	private static final Integer DK = 5222;
	private static boolean isLogin = false;

	// private Roster roster;
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		User user = (User)request.getSession().getAttribute("authUser");
		/*String name = user.getId();
		String passwd = user.getPassword();*/
		
		String msgId = request.getParameter("id");
		// 发送信息到opfenfire
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();

		MobileMessage msg = MobileMessage.get(msgId); // 获得信息
		String id = msg.getId();
		String title = msg.getTitle();
		String text = msg.getText();
		String createTime = msg.getCreatetime();
		String level = msg.getLevelname();

		JSONObject t_job = new JSONObject();
		t_job.put("msageId", id);
		t_job.put("msgTitle", title);
		t_job.put("msgContent", text);
		t_job.put("msgTime", createTime);
		t_job.put("level", level);

		List<MsgReUser> mm = MsgReUser.getByMsgId(id);
		Connection con = getConnection();
		try {
			con.connect();
		} catch (XMPPException e2) {
			e2.printStackTrace();
		}

		if (!isLogin) {
			try {
				con.login("admin", "180002");
				isLogin = true;
			} catch (XMPPException e1) {
				e1.printStackTrace();
			}
		}

		for (int i = 0; i < mm.size(); i++) {
			String uId = mm.get(i).getUserId().toString();

			// 获取用户密码
			User us = User.get(uId);
			String pass = us.getPassword();

			t_job.put("userId", uId);
			returnList.add(t_job);

			JSONArray job = new JSONArray();
			job.addAll(returnList);

			Map map2 = new HashMap();
			map2.put("data", job);
			JSONObject job2 = new JSONObject();
			job2.putAll(map2);

			String ss = job2.toString();

			try {
				Message m = SendBCMsg(ss, "");
				con.sendPacket(m);
			} catch (XMPPException e) {
				e.printStackTrace();
			}
		}

		return new JspView("/app/mobile/office/message/show.jsp");
	}

	@Override
	public String requestMapping() {
		return "/app/mobile/message/sendMsgToOpenfire.action";
	}

	// 连接openfire服务器
	public Connection getConnection() {
		ConnectionConfiguration config = new ConnectionConfiguration(IP, DK);
		Connection connection = new XMPPConnection(config);
		return connection;
	}

	public boolean doLogin(Connection con, String user, String pwd) {
		try {
			con.connect();
			con.login(user, pwd);
		} catch (XMPPException e1) {
			e1.printStackTrace();
		}
		return true;
	}

	public Message SendBCMsg(String messgage, String groupName)
			throws XMPPException {

		Message m = new Message();
		m.setBody(messgage);// 设置消息。
		m.setTo("test" + "@broadcast.localhost");// [groupname]@[serviceName].[serverName]
		// con.sendPacket(m);
		return m;
	}

}
