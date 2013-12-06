package com.saturn.auth;

import java.sql.Connection;
import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class Role {

	private String id;
	private String name;
	private String description;

	private static ORMapping<Role> mapping = new ResultORMapping<Role>();

	public static int add(Role role) {
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_roles(name, description) VALUES(?, ?)",
				role.getName(), role.getDescription());
	}

	public static int addResource(String roleId, String resourceId) {
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_re_role_resource VALUES(?, ?)", roleId,
				resourceId);
	}

	public static int addUser(String roleId, String userId) {
		return SimpleDaoTemplate.update(
				"INSERT INTO auth_re_user_role VALUES(?, ?)", userId, roleId);
	}

	public static int edit(Role role) {
		return SimpleDaoTemplate.update(
				"UPDATE auth_roles SET name = ?, description = ? WHERE id = ?",
				role.getName(), role.getDescription(), role.getId());
	}

	public static Role get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM auth_roles WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Role.class);
	}

	public static ListData<Role> getRoles(Role role, String start,
			String offset, String orderBy, String order) {

		return SimpleDaoTemplate.query("SELECT * FROM auth_roles WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(role, "id", "name")
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Role.class, start, offset);
	}

	public static ListData<Role> getRolesByUserId(String userId, String start,
			String offset, String orderBy, String order) {

		return SimpleDaoTemplate
				.query("SELECT role.* FROM auth_roles role, auth_re_user_role userRole WHERE 1=1 and role.id = userRole.roleId",
						new DymaticCondition().addCondition(
								"AND userRole.userId = '?'", userId)
								.addCondition("ORDER BY {0} {1}", orderBy,
										order), mapping, Role.class, start,
						offset);
	}

	public static ListData<Role> getNotHaveRolesByUserId(String userId,
			String start, String offset, String orderBy, String order) {

		return SimpleDaoTemplate.query(
				"SELECT * FROM auth_roles WHERE 1= 1", new DymaticCondition()
				.addCondition(
						"AND id NOT IN(SELECT role.id FROM auth_roles role, `auth_re_user_role` userRole WHERE userRole.`roleId` = role.id and userRole.userId = '?')",
						userId)
						.addCondition("ORDER BY {0} {1}", orderBy, order),
				mapping, Role.class, start, offset);
	}

	public static List<Role> getRolesByResourceId(String resourceId,
			String start, String offset, String orderBy) {
		
		return SimpleDaoTemplate
				.query("SELECT role.* FROM auth_roles role, auth_re_role_resource roleResource WHERE 1=1 and role.id = roleResource.roleId",
						new DymaticCondition()
								.addCondition(
										"AND roleResource.resourceId = '?'",
										resourceId)
								.addCondition("ORDER BY ? desc", orderBy)
								.addCondition("LIMIT {0}, {1}", start, offset),
						mapping, Role.class);
	}

	public static int updateRoleResource(final String roleId,
			final String[] chekcedIds) {
		return SimpleDaoTemplate.update(new ITransaction() {

			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_re_role_resource WHERE roleId = ?",
						roleId);
				StringBuffer buffer = new StringBuffer();
				buffer.append("insert into auth_re_role_resource values");

				for (int i = 0; i < (chekcedIds.length); i++) {
					buffer.append("('");
					buffer.append(roleId + "','" + chekcedIds[i]);
					buffer.append("'),");
				}
				String sql = buffer.toString().substring(0,
						buffer.toString().length() - 1);

				return SimpleDaoTemplate.update(connection, sql, (String) null);
			}
		});
	}

	public static int remove(final String id) {
		return SimpleDaoTemplate.update(new ITransaction() {

			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_re_role_resource WHERE roleId = ?",
						id);

				SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_re_user_role WHERE roleId = ?", id);

				return SimpleDaoTemplate.update(connection,
						"DELETE FROM auth_roles WHERE id = ?", id);
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

	public static int removeResource(String id, String resourceId) {
		return SimpleDaoTemplate
				.update("DELETE FROM auth_re_role_resource WHERE roleId = ? and resourceId = ?",
						id, resourceId);
	}

	public static int removeAllResource(String id) {
		return SimpleDaoTemplate.update(
				"DELETE FROM auth_re_role_resource WHERE roleId = ?", id);
	}

	public static int removeUser(String roleId, String userId) {
		return SimpleDaoTemplate
				.update("DELETE FROM auth_re_user_role WHERE userId = ? and roleId = ?",
						userId, roleId);
	}

	public static int removeAllUser(String roleId) {
		return SimpleDaoTemplate.update(
				"DELETE FROM auth_re_user_role WHERE roleId = ?", roleId);
	}

	public Role() {
	}

	public Role(String id, String name, String description) {
		this.id = id;
		this.name = name;
		this.description = description;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
