package com.saturn.mobile;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;
import com.saturn.app.utils.LogManager;

public class MobileMessage {
	
	private String id;
	private String title;
	private String text;
	private String state;
	private String statename;
	private String createtime;
	private String creater;
	private String creatername;
	private String levelname;
	private String level;
	private String type;
	private String userid;
	private String point;
	private static Logger Logger = LogManager.getLogger(LogManager.LOG_KEY_APP);
	
	private static ORMapping<MobileMessage> mapping = new ResultORMapping<MobileMessage>();
	private static ORMapping<HashMap> resultMapping = new ORMapping<HashMap>() {

		@SuppressWarnings("unchecked")//hashmap的类型检查
		@Override
		public void mappingResult(ResultSet rs, HashMap t) throws SQLException {
			try {
				ResultSetMetaData metaData = rs.getMetaData();
				
				if (metaData != null) {
					int size = metaData.getColumnCount();
					for (int i = 1; i <= size; ++i) {
						String name = metaData.getColumnName(i);
						
						try {
							String value = rs.getString(name);
							t.put(name, value);
						} catch (Exception e) {
							Logger.debug(e);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			Logger.debug("Result Mapping Object[" + t.getClass().getSimpleName() + "]:" + t);
		}
	};
	
	/**
	 * jyb  为设备返回消息JSON
	 * @param message
	 * @param start
	 * @param offset
	 * @return
	 */
	public static List<HashMap> getMessagesByMobile(MobileMessage message, String start,
			String offset, String order){
		String sql = "select * from mobile_message a,msg_re_user b where a.id=b.msgId and a.state='visible.true'";
		String startPoint = "0";
		String condition = "";
		String orderBy = "";
		if(message.getPoint()!=null&&!"".equals(message.getPoint())){
			startPoint = message.getPoint();
		}
		
		if("0".equals(order)) {
			orderBy = "ORDER BY point asc";
		}else if("1".equals(order)) {
			orderBy = "ORDER BY point desc";
		}else{
			return new ArrayList<HashMap>();
		}
		
		if("0".equals(startPoint)) {
			if("0".equals(offset)) {
				return SimpleDaoTemplate.query(sql,
						new DymaticCondition().addSimpleCondition(message, "userid", "type")
						.addCondition(orderBy), resultMapping, HashMap.class);
			}else{
				return SimpleDaoTemplate.query(sql,
						new DymaticCondition().addSimpleCondition(message, "userid", "type")
						.addCondition(orderBy), resultMapping, HashMap.class, start, offset).getList();
			}
		}else{
			if("0".equals(order)) {
				condition = "and point>'"+startPoint+"'+0";
			}else if("1".equals(order)) {
				condition = "and point<'"+startPoint+"'+0";
			}
			if("0".equals(offset)) {
				return SimpleDaoTemplate.query(sql,
						new DymaticCondition().addSimpleCondition(message, "userid", "type").addCondition(condition)
						.addCondition(orderBy), resultMapping, HashMap.class);
			}else{
				return SimpleDaoTemplate.query(sql,
						new DymaticCondition().addSimpleCondition(message, "userid", "type").addCondition(condition)
						.addCondition(orderBy), resultMapping, HashMap.class, start, offset).getList();
			}
		}
	}
	/*public static List<HashMap> getMessagesByMobile(MobileMessage message, String start,
			String offset, String order){
		String startPoint = "0";
		String orderBy = "";
		if(message.getPoint()!=null&&!"".equals(message.getPoint())){
			startPoint = message.getPoint();
		}
		if("0".equals(order)) {
			orderBy = "and point>'"+startPoint+"'";
		}else if("1".equals(order)) {
			orderBy = "and point<'"+startPoint+"'";
		}else{
			return new ArrayList<HashMap>();
		}
		
		if("0".equals(offset)) {
			return SimpleDaoTemplate.query("select * from mobile_message a,msg_re_user b where a.id=b.msgId and a.state='visible.true'",
					new DymaticCondition().addSimpleCondition(message, "userid", "type").addCondition(orderBy)
					.addCondition("ORDER BY sendTime asc"), resultMapping, HashMap.class);
		}
		return SimpleDaoTemplate.query("select * from mobile_message a,msg_re_user b where a.id=b.msgId and a.state='visible.true'",
				new DymaticCondition().addSimpleCondition(message, "userid", "type").addCondition(orderBy)
				.addCondition("ORDER BY sendTime asc"), resultMapping, HashMap.class, start, offset).getList();
	}*/
	
	public static ListData<MobileMessage> getMessages(MobileMessage message, String start,
			String offset, String orderBy, String order){
		return SimpleDaoTemplate.query("select * from mobile_message where 1=1",
				new DymaticCondition().addSimpleCondition(message, "title", "creatername", "statename","createtime").addCondition("and type = ?",message.getType())
				.addCondition("ORDER BY {0} {1}", orderBy, order), mapping, MobileMessage.class, start, offset);
	}
	
	public static int add(MobileMessage vo) {
		return  SimpleDaoTemplate.update("insert into mobile_message(title, text, state, statename, createtime, creater, creatername, levelname, level, type, point) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
				vo.getTitle(), vo.getText(), vo.getState(),
				vo.getStatename(), vo.getCreatetime(), vo.getCreater(), 
				vo.getCreatername(), vo.getLevelname(), vo.getLevel(), vo.getType(), vo.getPoint());
				
	}
	
	public static MobileMessage get(String id){
		return SimpleDaoTemplate.queryOne("select * from mobile_message where 1=1 and id = '"+ id +"'", 
				null, mapping, MobileMessage.class);
	}
	
	public static MobileMessage getOne(String type){
		return SimpleDaoTemplate.queryOne("select max(point) as point from mobile_message where 1=1 and type = '"+type+"'", 
				null, mapping, MobileMessage.class);
	}
	
	public static int edit(MobileMessage vo) {
		return SimpleDaoTemplate.update("update mobile_message set title = ?, text = ?, state = ?, statename = ?, createtime=?, creater=?, creatername=?, level=?, levelname=?, type=?, point=? where id = ?",
				vo.getTitle(), vo.getText(), vo.getState(), vo.getStatename(), vo.getCreatetime(), vo.getCreater(),
				vo.getCreatername(), vo.getLevel(), vo.getLevelname(), vo.getType(), vo.getPoint(), vo.getId());
	}
	
	public static int remove(final String id) {
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		return SimpleDaoTemplate.update("DELETE FROM mobile_message WHERE id = ?",
				id);
	}
	
	public static int removeReUser(final String id) {
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		return SimpleDaoTemplate.update("DELETE FROM msg_re_user WHERE msgId = ?",
				id);
	}
	
	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}
	
	public static void removeReUsers(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				removeReUser(id);
			}
		}
	}
	
	public static void addUsersToMsg(String msgId, String[] userIds, String type, String sendTime){
		if(userIds != null) {
			for (String userId: userIds) {
				addUserToMsg(msgId,userId,type,sendTime);
			}
		}
	}
	
	public static int addUserToMsg(String msgId, String userId, String type,String sendTime){
		return SimpleDaoTemplate.update("insert into msg_re_user values(?,?,?,?)", userId, msgId, type,sendTime);
	}
	
	/*public static ListData<MobileMessage> getNotInMsgByMsgId(
			String MsgId, String start, String offset, String orderBy,
			String order) {

		return SimpleDaoTemplate
				.query("SELECT * FROM auth_users WHERE 1= 1",
						new DymaticCondition()
								.addCondition(
										"AND id NOT IN(SELECT user.id FROM auth_users user, `msg_re_user` msgUser WHERE msgUser.`userId` = user.id and msgUser.msgId = '?')",
										MsgId).addCondition(
										"ORDER BY {0} {1}", orderBy, order),
						mapping, MobileMessage.class, start, offset);
	}*/
	
/*	public static ListData<MobileMessage> getUsersWithoutByMsgId(
			String msgId, String start, String offset, String orderBy) {
 
		return SimpleDaoTemplate
				.query("SELECT user.* FROM auth_users user, msg_re_user msgUser WHERE 1=1 and user.id = msgUser.userId",
						new DymaticCondition().addCondition(
								"AND msgUser.msgId = '?' ",
								msgId).addCondition("ORDER BY ? desc",
								orderBy), mapping, MobileMessage.class, start, offset);
	}*/
	
	public static void removeMsgUser(String id, String[] userIds) {
		if (userIds != null) {
			for (String userId : userIds) {
				removeUser(id, userId);
			}
		}
	}
	
	public static int removeUser(String id, String userId) {
		return SimpleDaoTemplate
				.update("DELETE FROM msg_re_user WHERE msgId = ? and userId = ?",
						id, userId);
	}
	
	public static int show(String id) {
		MobileMessage vo = get(id);
		String state = vo.getState();
		
		if ("visible.true".equals(state)) {
			vo.setState("visible.false");
			vo.setStatename("隐藏");
		} else {
			vo.setState("visible.true");
			vo.setStatename("显示");
		}
		
		return edit(vo);
	}
	public MobileMessage(){
		
	}
	
	public MobileMessage(String id, String title, String text, String state, String statename,
			String createtime, String creater, String creatername, String levelname, String level, 
			String type, String userid, String point){
		this.id = id;
		this.title = title;
		this.text = text;
		this.state = state;
		this.statename = statename;
		this.createtime = createtime;
		this.creater = creater;
		this.creatername = creatername;
		this.levelname = levelname;
		this.level = level;
		this.type = type;
		this.userid = userid;
		this.point = point;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStatename() {
		return statename;
	}
	public void setStatename(String statename) {
		this.statename = statename;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getCreatername() {
		return creatername;
	}
	public void setCreatername(String creatername) {
		this.creatername = creatername;
	}
	
	public String getLevelname() {
		return levelname;
	}

	public void setLevelname(String levelname) {
		this.levelname = levelname;
	}

	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
