package com.saturn.mobile;

import java.util.List;

import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class MsgReUser {
	private String userId;
	private String msgId;
	private String msgType;
	private String sendTime;
	
	private static ORMapping<MsgReUser> mapping = new ResultORMapping<MsgReUser>();
	
	public static List<MsgReUser> getByMsgId(String id){
		return SimpleDaoTemplate.query("select * from msg_re_user where 1=1 and msgId = '"+ id +"'", 
				null, mapping, MsgReUser.class);
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	
	
}
