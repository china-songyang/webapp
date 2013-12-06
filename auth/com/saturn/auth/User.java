package com.saturn.auth;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;
import com.saturn.app.exception.BSException;
import com.saturn.app.utils.CodeUtils;
import com.saturn.app.utils.LogManager;

public class User {

	private String id = "";
	private String name = "";
	private String password = "";
	private String email = "";
	private String phone = "";
	private String level = "";
	private String tel = "";
	private String post = "";
	private String point = "";
	private String fax = "";

	private static ORMapping<User> mapping = new ResultORMapping<User>();
	private static Logger Logger = LogManager.getLogger(LogManager.LOG_KEY_APP);
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
	
	public static int add(User user) {
		if (get(user.getId()) != null) {
			throw new BSException("用户ID重复,id=" + user.getId());
		}

		user.setPassword(CodeUtils.encode(user.getPassword()));
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_users VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", user.getId(),
				user.getName(), user.getPassword(), user.getEmail(),
				user.getPhone(), user.getLevel(), user.getTel(), user.getPost(), user.getPoint(), user.getFax());

	}

	public static int addRole(String userId, String roleId) {
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_re_user_role VALUES(?, ?)", userId, roleId);
	}

	public static void addRoles(String userId, String[] roleIds) {
		if (roleIds != null) {
			for (String roleId : roleIds) {
				addRole(userId, roleId);
			}
		}
	}

	public static void addUsersToOrganization(String organizationId,
			String[] userIds) {
		if (userIds != null) {
			for (String userId : userIds) {
				addUserToOrganization(organizationId, userId);
			}
		}
	}

	public static int addUserToOrganization(String organizationId, String userId) {
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_re_organization_user VALUES(?, ?)",
				organizationId, userId);
	}

	public static int edit(User user) {
		return SimpleDaoTemplate
				.update("UPDATE auth_users SET name = ?, password = ?, email = ?, phone = ?, level = ?, tel = ?, post = ?, point = ?, fax = ? WHERE id = ?",
						user.getName(), user.getPassword(), user.getEmail(),
						user.getPhone(), user.getLevel(), user.getTel(), user.getPost(), user.getPoint(), user.getFax(), user.getId());
	}
	
	public static User get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM auth_users WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, User.class);
	}

	public static ListData<User> getUsers(User user, String start,
			String offset, String orderBy, String order) {

		return SimpleDaoTemplate.query(
				"SELECT * FROM auth_users WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(user, "id", "name",
						"email", "phone").addCondition("ORDER BY {0} {1}",
						orderBy, order), mapping, User.class, start, offset);
	}

	public static User getOne() {
		return SimpleDaoTemplate.queryOne("select max(point) as point from auth_users where 1=1 ", null, mapping, User.class);
	}
	
	public static List<HashMap> getUserByPoint(User user, String start,
			String offset){
		List<HashMap> list = new ArrayList<HashMap>();
		String sql = "select au.id,au.name,au.email, au.phone, au.level, au.tel, au.post, au.point,au.fax, ao.name as department, ao.parentId from auth_users as au, auth_re_organization_user as aou, auth_organizations as ao " +
				"where au.id = aou.userId and aou.organizationId = ao.id ";
		String startPoint = "0";
		String condition = "";
		if(user.getPoint()!=null&&!"".equals(user.getPoint())){
			startPoint = user.getPoint();
		}
		
		if("0".equals(startPoint)) {
			if("0".equals(offset)) {
				list =  SimpleDaoTemplate.query(sql,
						new DymaticCondition(), resultMapping, HashMap.class);
			}else{
				list =  SimpleDaoTemplate.query(sql,
						new DymaticCondition(), resultMapping, HashMap.class, start, offset).getList();
			}
		}else{
			condition = " and point>'"+startPoint+"'+0";
			if("0".equals(offset)) {
				list =  SimpleDaoTemplate.query(sql,
						new DymaticCondition().addCondition(condition),
						resultMapping, HashMap.class);
			}else{
				list =  SimpleDaoTemplate.query(sql,
						new DymaticCondition().addCondition(condition), 
						resultMapping, HashMap.class, start, offset).getList();
			}
		}
		for(Map<String, String> map : list){
			String id = map.get("parentId");
			Organization or = Organization.get(id);
			if(or!=null)
				map.put("unit", or.getName());
			else
				map.put("unit", "");
		}
		return list;
	}
	
	public static ListData<User> getUsersByOrganizationId(
			String organizationId, String start, String offset, String orderBy) {

		return SimpleDaoTemplate
				.query("SELECT user.* FROM auth_users user, auth_re_organization_user organizationUser WHERE 1=1 and user.id = organizationUser.userId",
						new DymaticCondition().addCondition(
								"AND organizationUser.organizationId = '?' ",
								organizationId).addCondition("ORDER BY ? desc",
								orderBy), mapping, User.class, start, offset);
	}

	public static int updateUserResource(final String userId,
			final String[] chekcedIds) {
		return SimpleDaoTemplate.update(new ITransaction() {

			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_re_user_resource WHERE userId = ?",
						userId);
				StringBuffer buffer = new StringBuffer();
				buffer.append("insert into auth_re_user_resource values");

				for (int i = 0; i < (chekcedIds.length); i++) {
					buffer.append("(\'");
					buffer.append(userId + "\', \'" + chekcedIds[i]);
					buffer.append("\'),");
				}
				String sql = buffer.toString().substring(0,
						buffer.toString().length() - 1);

				return SimpleDaoTemplate.update(connection, sql, (String) null);
			}
		});
	}

	public static int removeAllResource(String id) {
		return SimpleDaoTemplate.update(
				"DELETE FROM auth_re_user_resource WHERE userId = ?", id);
	}

	public static int remove(final String id) {
		return SimpleDaoTemplate.update(new ITransaction() {

			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_re_user_role WHERE userId = ?", id);

				return SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_users WHERE id = ?", id);
			}
		});
	}

	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}

	public static int removeRole(String userId, String roleId) {
		return SimpleDaoTemplate
				.update("DELETE FROM auth_re_user_role WHERE userId = ? and roleId = ?",
						userId, roleId);
	}

	public static void removeRoles(String userId, String[] roleIds) {
		if (roleIds != null) {
			for (String roleId : roleIds) {
				removeRole(userId, roleId);
			}
		}
	}

	public static int removeAllRole(String userId) {
		return SimpleDaoTemplate.update(
				"DELETE FROM auth_re_user_role WHERE userId = ?", userId);
	}

	public static ListData<User> getUsersByRoleId(String roleId, String start,
			String offset, String orderBy) {

		return SimpleDaoTemplate
				.query("SELECT user.* FROM auth_users user, auth_re_user_role userRole WHERE 1=1 and user.id = userRole.userId",
						new DymaticCondition().addCondition(
								"AND userRole.roleId = '?'", roleId)
								.addCondition("ORDER BY ? desc", orderBy),
						mapping, User.class, start, offset);

	}

	public static ListData<User> getNotInOrganizationsByOrganizationId(
			String organizationId, String start, String offset, String orderBy,
			String order) {

		return SimpleDaoTemplate
				.query("SELECT * FROM auth_users WHERE 1= 1",
						new DymaticCondition()
								.addCondition(
										"AND id NOT IN(SELECT user.id FROM auth_users user, `auth_re_organization_user` organizationUser WHERE organizationUser.`userId` = user.id and organizationUser.organizationId = '?')",
										organizationId).addCondition(
										"ORDER BY {0} {1}", orderBy, order),
						mapping, User.class, start, offset);
	}

	public static ListData<User> getNotInMsgByMsgId(
			String MsgId, String start, String offset, String orderBy,
			String order) {

		return SimpleDaoTemplate
				.query("SELECT * FROM auth_users WHERE 1= 1",
						new DymaticCondition()
								.addCondition(
										"AND id NOT IN(SELECT user.id FROM auth_users user, `msg_re_user` msgUser WHERE msgUser.`userId` = user.id and msgUser.msgId = '?')",
										MsgId).addCondition(
										"ORDER BY {0} {1}", orderBy, order),
						mapping, User.class, start, offset);
	}
	
	public static ListData<User> getNotInMetByMetId(
			String MetId, String start, String offset, String orderBy,
			String order) {
		
		return SimpleDaoTemplate
				.query("SELECT * FROM auth_users WHERE 1= 1",
						new DymaticCondition()
				.addCondition(
						"AND id NOT IN(SELECT user.id FROM auth_users user, `met_re_user` metUser WHERE metUser.`userId` = user.id and metUser.metId = '?')",
						MetId).addCondition(
								"ORDER BY {0} {1}", orderBy, order),
								mapping, User.class, start, offset);
	}
	
	public static ListData<User> getUsersWithoutByMsgId(
			String msgId, String start, String offset, String orderBy) {

		return SimpleDaoTemplate
				.query("SELECT user.* FROM auth_users user, msg_re_user msgUser WHERE 1=1 and user.id = msgUser.userId",
						new DymaticCondition().addCondition(
								"AND msgUser.msgId = '?' ",
								msgId).addCondition("ORDER BY ? desc",
								orderBy), mapping, User.class, start, offset);
	}
	
	public static ListData<User> getUsersWithoutByMetId(
			String metId, String start, String offset, String orderBy) {
		
		return SimpleDaoTemplate
				.query("SELECT user.* FROM auth_users user, met_re_user metUser WHERE 1=1 and user.id = metUser.userId",
						new DymaticCondition().addCondition(
								"AND metUser.metId = '?' ",
								metId).addCondition("ORDER BY ? desc",
										orderBy), mapping, User.class, start, offset);
	}
	
	public User() {
	}

	public User(String id, String name, String password, String email,
			String phone, String level, String tel, String post, String fax) {
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.level = level;
		this.tel = tel;
		this.post = post;
		this.fax = fax;
	}

	
	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	
	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
