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

public class Meeting {

		private String id;
		private String userId;
		private String title;
		private String time;
		private String address;
		private String unit;
		private String text;
		private String createTime;
		private String state;
		private String stateName;
		
		private static Logger Logger = LogManager.getLogger(LogManager.LOG_KEY_APP);
		
		private static ORMapping<Meeting> mapping = new ResultORMapping<Meeting>();
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
		
		public static void addUsersToMet(String msgId, String[] userIds,  String sendTime){
			if(userIds != null) {
				for (String userId: userIds) {
					addUserToMet(msgId,userId,sendTime);
				}
			}
		}
		
		public static int addUserToMet(String msgId, String userId,String sendTime){
			return SimpleDaoTemplate.update("insert into met_re_user values(?,?,?)", userId, msgId,sendTime);
		}
		/**
		 * jyb  为设备返回消息JSON
		 * @param message
		 * @param start
		 * @param offset
		 * @return
		 */
		public static List<HashMap> getMeetings(Meeting meeting, String start,
				String offset, String order){
			String sql = "select a.*,b.userId as userName from mobile_meeting a,met_re_user b where a.id=b.metId and a.state='visible.true'";
			String startPoint = "0";
			String condition = "";
			String orderBy = "";
			/*if(meeting.getPoint()!=null&&!"".equals(meeting.getPoint())){
				startPoint = meeting.getPoint();
			}*/
			
			if("0".equals(order)) {
				orderBy = " ORDER BY createTime asc";
			}else if("1".equals(order)) {
				orderBy = " ORDER BY createTime desc";
			}else{
				return new ArrayList<HashMap>();
			}
				if("0".equals(meeting.getId())){
					if("0".equals(offset)) {
						return SimpleDaoTemplate.query(sql,
								new DymaticCondition().addCondition(" and b.userId='"+meeting.getUserId()+"'")
								.addCondition(orderBy), resultMapping, HashMap.class);
					}else{
						return SimpleDaoTemplate.query(sql,
								new DymaticCondition().addCondition(" and b.userId='"+meeting.getUserId()+"'")
								.addCondition(orderBy), resultMapping, HashMap.class, start, offset).getList();
					}
				}else{
					if("0".equals(offset)) {
						return SimpleDaoTemplate.query(sql,
								new DymaticCondition().addCondition(" and b.userId='"+meeting.getUserId()+"'")
								.addSimpleCondition(" and a.id='?'", meeting.getId())
								.addCondition(orderBy), resultMapping, HashMap.class);
					}else{
						return SimpleDaoTemplate.query(sql,
								new DymaticCondition().addCondition(" and b.userId='"+meeting.getUserId()+"'")
								.addSimpleCondition(" and a.id='?'", meeting.getId())
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
		
		/*public static void addUsersToMeeting(String meetingId,
				String[] points) {
			if (points != null) {
				for (String userPoint : points) {
					addUserToMeeting(meetingId, userPoint);
				}
			}
		}*/

		/*public static int addUserToMeeting(String meetingId, String userPoint) {
			return SimpleDaoTemplate.update(
					"INSERT INTO user_re_meeting VALUES(?, ?)",
					meetingId, userPoint);
		}*/
		public static int addUserToMeeting(String meetingMember, String meetingId,String createTime) {
			return SimpleDaoTemplate.update(
					"INSERT INTO met_re_user VALUES(?, ?, ?)",
					 meetingMember, meetingId, createTime);
		}
		
		public static ListData<Meeting> getMeetings(Meeting meeting, String start,
				String offset, String orderBy, String order){
			return SimpleDaoTemplate.query("select * from mobile_meeting where 1=1",
					new DymaticCondition().addSimpleCondition(meeting, "title", "time", "statename","unit","createTime","address")
					.addCondition("ORDER BY {0} {1}", orderBy, order), mapping, Meeting.class, start, offset);
		}
		
		public static int add(Meeting vo) {
			return  SimpleDaoTemplate.update("insert into mobile_meeting(userId, title, time, address, unit, text, createTime, state, stateName) values(?, ?, ?, ?, ?, ?, ?, ?, ?)", 
					vo.getUserId(), vo.getTitle(), vo.getTime(), vo.getAddress(),
					vo.getUnit(), vo.getText(),vo.getCreateTime(), 
					vo.getState(), vo.getStateName());
					
		}
		
		public static Meeting get(String id){
			return SimpleDaoTemplate.queryOne("select * from mobile_meeting where 1=1 and id = '"+ id +"'", 
					null, mapping, Meeting.class);
		}
		public static Meeting getMaxPoint(){
			return SimpleDaoTemplate.queryOne("select max(point) from mobile_meeting where 1=1", 
					null, mapping, Meeting.class);
		}
		
		public static Meeting getUserReMet(String id){
			return SimpleDaoTemplate.queryOne("select * from met_re_user where 1=1 and userId = '"+ id +"'", 
					null, mapping, Meeting.class);
		}
		
		public static Meeting getMaxId(){
			return SimpleDaoTemplate.queryOne("select * from mobile_meeting where 1=1 and id = (select max(id) from mobile_meeting)", 
					null, mapping, Meeting.class);
		}
		
		public static Meeting getOne(String type){
			return SimpleDaoTemplate.queryOne("select max(point) as point from mobile_message where 1=1 and type = '"+type+"'", 
					null, mapping, Meeting.class);
		}
		
		public static int edit(Meeting vo) {
			return SimpleDaoTemplate.update("update mobile_meeting set userId = ?, title = ?, time = ?, address = ?, unit=?, text=?, createTime=?, state=?, stateName=? where id = ?",
					vo.getUserId(), vo.getTitle(), vo.getTime(), vo.getAddress(),vo.getUnit(),
					vo.getText(), vo.getCreateTime(), vo.getState(), vo.getStateName(), vo.getId());
		}
		
		public static int remove(final String id) {
			//指定插入表名称(tableName)。例子：如user表，tableName=user
			return SimpleDaoTemplate.update("DELETE FROM mobile_meeting WHERE id = ?",
					id);
		}
		
		public static int removeReUser(final String id) {
			//指定插入表名称(tableName)。例子：如user表，tableName=user
			return SimpleDaoTemplate.update("DELETE FROM met_re_user WHERE metId = ?",
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
		
		public static void removeMeetingUser(String id, String[] userIds) {
			if (userIds != null) {
				for (String userId : userIds) {
					removeUser(id, userId);
				}
			}
		}
		
		public static int removeUser(String id, String userId) {
			return SimpleDaoTemplate
					.update("DELETE FROM met_re_user WHERE metId = ? and userId = ?",
							id, userId);
		}
		
		public static int show(String id) {
			Meeting vo = get(id);
			String state = vo.getState();
			
			if ("visible.true".equals(state)) {
				vo.setState("visible.false");
				vo.setStateName("隐藏");
			} else {
				vo.setState("visible.true");
				vo.setStateName("显示");
			}
			
			return edit(vo);
		}
		public Meeting(){
			
		}
		
		public Meeting(String id, String userId, String title, String time, String address,
				String unit, String text, String createTime, String state, 
				String stateName){
			super();
			this.id = id;
			this.userId = userId;
			this.title = title;
			this.time = time;
			this.address = address;
			this.unit = unit;
			this.text = text;
			this.createTime = createTime;
			this.state = state;
			this.stateName =stateName;
		}
		
		
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getUserId() {
			return userId;
		}

		public void setUserId(String userId) {
			this.userId = userId;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getTime() {
			return time;
		}

		public void setTime(String time) {
			this.time = time;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}

		public String getUnit() {
			return unit;
		}

		public void setUnit(String unit) {
			this.unit = unit;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}

		public String getCreateTime() {
			return createTime;
		}

		public void setCreateTime(String createTime) {
			this.createTime = createTime;
		}

		public String getState() {
			return state;
		}

		public void setState(String state) {
			this.state = state;
		}

		public String getStateName() {
			return stateName;
		}

		public void setStateName(String stateName) {
			this.stateName = stateName;
		}
		
		@Override
		public String toString() {
			return new JSONObject(this).toString();
		}
	}
