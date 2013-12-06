package com.saturn.auth;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class Organization {

	private String id;
	private String name;
	private String description;
	private String responsible;
	private String parentId;
	private String userStr;

	private static ORMapping<Organization> mapping = new ResultORMapping<Organization>();
	
	private static ORMapping<Organization> mappingWithUser = new ResultORMapping<Organization>() {

		@Override
		public void mappingResult(ResultSet rs, Organization t)
				throws SQLException {
			
			super.mappingResult(rs, t);
			
			List<User> users = User.getUsersByOrganizationId(t.getId(), null, null, null).getList();
			StringBuffer buffer = new StringBuffer();
			if (users != null) {
				for (User user : users) {
					buffer.append(user.getName()).append("; ");
				}
			}
			
			t.setUserStr(buffer.toString());
		}
		
	};

	public static int add(Organization organization) {
		String parentId = organization.getParentId();
		if (parentId != null && !"".equals(parentId.trim())) {
			return SimpleDaoTemplate.update(
					"INSERT INTO auth_organizations(name, description, responsible, parentId) VALUES(?, ?, ?, ?)",
					organization.getName(),
					organization.getDescription(), organization.getResponsible(), organization.getParentId());
		}

		return SimpleDaoTemplate
				.update("INSERT INTO auth_organizations(name, description, responsible) VALUES(?, ?, ?)",
						 organization.getName(),
						organization.getDescription(),organization.getResponsible());
	}

	public static int edit(Organization organization) {
		String parentId = organization.getParentId();
		if (parentId != null && !"".equals(parentId.trim())) {
			return SimpleDaoTemplate
					.update("UPDATE auth_organizations SET name = ?, description = ?, responsible = ?, parentId = ? WHERE id = ?",
							organization.getName(),
							organization.getDescription(), organization.getResponsible(), 
							organization.getParentId(), organization.getId());
		}

		return SimpleDaoTemplate
				.update("UPDATE auth_organizations SET name = ?, description = ?, responsible = ? WHERE id = ?",
						organization.getName(), organization.getDescription(), organization.getResponsible(), 
						organization.getId());
	}

	
	public static List<Organization> getOrganizationByUser(String userId) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.query("SELECT * from auth_organizations as o, auth_re_organization_user as ou where o.id = ou.organizationId AND ou.userId = '"+userId+"'",
				null,
				mapping, Organization.class);
	}
	
	//获得部门负责职位
	public static Organization getManager(String oid) {
		Organization organization = get(oid);
		
		String res = organization.getResponsible();
		if ("是".equals(res)) {
			return organization;
		}
		
		String parentId = organization.getParentId();
		if (parentId == null) {
			return null;
		}
		
		Organization or = SimpleDaoTemplate.queryOne("SELECT * from auth_organizations where responsible='是' AND parentId=" + parentId,
				null,
				mapping, Organization.class);
		if (or != null) {
			return or;
		}
		
		return null;
	}
	
	public static Organization get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM auth_organizations WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Organization.class);
	}

	public static ListData<Organization> getOrganizations(
			Organization organization, String start, String offset,
			String orderBy, String order) {

		return SimpleDaoTemplate.query(
				"SELECT * FROM auth_organizations WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(organization, "id",
						"name", "description", "parentId").addCondition(
						"ORDER BY {0} {1}", orderBy, order), mappingWithUser,
				Organization.class, start, offset);
	}

	public static int updateOrganizationResource(final String organizationId,
			final String[] chekcedIds) {

		return SimpleDaoTemplate.update(new ITransaction() {

			public int execute(Connection connection) {
				SimpleDaoTemplate
						.update(connection,
								"DELETE FROM auth_re_organization_resource WHERE organizationId = ?",
								organizationId);
				StringBuffer buffer = new StringBuffer();
				buffer.append("insert into auth_re_organization_resource values");

				for (int i = 0; i < (chekcedIds.length); i++) {
					buffer.append("('");
					buffer.append(organizationId + "','" + chekcedIds[i]);
					buffer.append("'),");
				}
				String sql = buffer.toString().substring(0,
						buffer.toString().length() - 1);

				return SimpleDaoTemplate.update(connection, sql, (String) null);
			}
		});
	}

	public static int remove(final String id) {

		return SimpleDaoTemplate.update(
				"DELETE FROM auth_organizations WHERE id = ?", id);

	}

	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}

	public static int removeAllResource(String id) {
		return SimpleDaoTemplate
				.update("DELETE FROM auth_re_organization_resource WHERE organizationId = ?",
						id);
	}

	public static int removeUser(String organizationId, String userId) {
		return SimpleDaoTemplate
				.update("DELETE FROM auth_re_organization_user WHERE organizationId = ? and userId = ?",
						organizationId, userId);
	}

	public static void removeUsers(String organizationId, String[] userIds) {
		if (userIds != null) {
			for (String userId : userIds) {
				removeUser(organizationId, userId);
			}
		}
	}

	public Organization() {
	}

	public Organization(String id, String name, String description,
			String responsible, String parentId) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.responsible = responsible;
		this.parentId = parentId;
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
	
	public String getResponsible() {
		return responsible;
	}

	public void setResponsible(String responsible) {
		this.responsible = responsible;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getUserStr() {
		return userStr;
	}

	public void setUserStr(String userStr) {
		this.userStr = userStr;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString().replace("parentId", "_parentId");
	}
}
