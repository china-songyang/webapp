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
import com.saturn.app.exception.BSException;
import com.saturn.app.utils.LogManager;

public class Resource {

	private String id;
	private String name;
	private String path;
	private String parentId;
	private String checked;
	private String sort;

	private static ORMapping<Resource> mapping = new ResultORMapping<Resource>();

	public static int add(Resource role) {
		if (get(role.getId()) != null) {
			throw new BSException("资源ID重复,id=" + role.getId());
		}

		String parentId = role.getParentId();
		if (parentId != null && !"".equals(parentId)) {
			return SimpleDaoTemplate.update(
					"INSERT INTO app_resources(id, name, path, parentId) VALUES(?, ?, ?, ?)",
					role.getId(), role.getName(), role.getPath(),
					role.getParentId());
		}

		return SimpleDaoTemplate.update(
				"INSERT INTO app_resources(id, name, path) VALUES(?, ?, ?)",
				role.getId(), role.getName(), role.getPath());
	}

	public static List<Resource> getResourcesByOrganizationId(
			String organizationId) {

		return SimpleDaoTemplate
				.query("SELECT id,NAME,sort,path,parentId,CASE WHEN (id  IN (SELECT auth_re_organization_resource.resourceId FROM auth_re_organization_resource WHERE auth_re_organization_resource.organizationId='"
						+ organizationId
						+ "')) THEN 'true 'ELSE null END AS checked FROM app_resources ORDER BY sort asc",
						null, new ORMapping<Resource>() {

							@Override
							public void mappingResult(ResultSet rs, Resource t)
									throws SQLException {
								t.setId(rs.getString("id"));
								t.setName(rs.getString("name"));
								t.setPath(rs.getString("path"));
								t.setParentId(rs.getString("parentId"));
								t.setChecked(rs.getString("checked"));
								t.setSort(rs.getString("sort"));
							}
						}, Resource.class);

	}
	public static int edit(Resource resource) {
		String parentId = resource.getParentId();
		if (parentId != null && !"".equals(parentId)) {
			return SimpleDaoTemplate
					.update("UPDATE app_resources SET name = ?, path = ?, parentId = ?, sort = ? WHERE id = ?",
							resource.getName(), resource.getPath(), resource.getParentId(), resource.getSort(),
							resource.getId());
		}

		return SimpleDaoTemplate.update(
				"UPDATE app_resources SET name = ?, path = ?, sort = ? WHERE id = ?",
				resource.getName(), resource.getPath(), resource.getSort(), resource.getId());
	}

	public static Resource get(String id) {
		//指定值对象类型(VOClass)。例子VOClass=User
		//指定表主键(key)。例子:key=id
		//指定插入表名称(tableName)。例子：如user表，tableName=user
		//指定O-R映射规则对象。默认mapping
		return SimpleDaoTemplate.queryOne(
				"SELECT * FROM app_resources WHERE 1 = 1 and id = '" + id + "'",
				null, mapping, Resource.class);
	}

	public static ListData<Resource> getResources(Resource resource,
			String start, String offset, String orderBy, String order) {

		return SimpleDaoTemplate.query(
				"SELECT * FROM app_resources WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(resource, "id",
						"name", "path", "parentId").addCondition(
						"ORDER BY {0} {1}", orderBy, order), mapping,
				Resource.class, start, offset);
	}

	public static List<Resource> getResourcesByRoleId(String roleId) {

		return SimpleDaoTemplate
				.query("SELECT id,NAME,sort,path,parentId,CASE WHEN (id  IN (SELECT auth_re_role_resource.resourceId FROM auth_re_role_resource WHERE auth_re_role_resource.roleId='"
						+ roleId
						+ "')) THEN 'true' ELSE null END AS checked FROM app_resources ORDER BY sort asc",
						null, new ORMapping<Resource>() {

							@Override
							public void mappingResult(ResultSet rs, Resource t)
									throws SQLException {
								t.setId(rs.getString("id"));
								t.setName(rs.getString("name"));
								t.setPath(rs.getString("path"));
								t.setParentId(rs.getString("parentId"));
								t.setChecked(rs.getString("checked"));
								t.setSort(rs.getString("sort"));
							}
						}, Resource.class);
	}


	public static List<Resource> getResourcesByUserId(String userId) {

		return SimpleDaoTemplate
				.query("SELECT id,NAME,sort,path,parentId,CASE WHEN (id  IN (SELECT auth_re_user_resource.resourceId FROM auth_re_user_resource WHERE auth_re_user_resource.userId='"
						+ userId
						+ "')) THEN 'true 'ELSE null END AS checked FROM app_resources ORDER BY sort asc",
						null, new ORMapping<Resource>() {

							@Override
							public void mappingResult(ResultSet rs, Resource t)
									throws SQLException {
								t.setId(rs.getString("id"));
								t.setName(rs.getString("name"));
								t.setPath(rs.getString("path"));
								t.setParentId(rs.getString("parentId"));
								t.setChecked(rs.getString("checked"));
								t.setSort(rs.getString("sort"));
							}
						}, Resource.class);

	}

	/**
	 * 获得用户登录菜单资源
	 * 
	 * @param userId
	 */
	public static List<Resource> getChildrenResourceByUserId(String userId,
			String parentId) {

		String sql = "SELECT * FROM app_resources WHERE id IN("
				+ "SELECT rRe.resourceId FROM auth_re_role_resource AS rRe, auth_re_user_role AS URo WHERE rRe.roleId = "
				+ "URo.roleId AND URo.userId ='"
				+ userId
				+ "' UNION SELECT resourceId FROM auth_re_user_resource WHERE userId='"
				+ userId + "')";
		
		if (parentId == null) {
			sql += " and parentId is null";
		} else {
			sql += " and parentId ='" + parentId + "'";
		}
		
		sql += " ORDER BY sort asc";

		return SimpleDaoTemplate.query(sql, null, mapping, Resource.class);
	}

	public static void changeSort(final String firstId, final String secondId) {
		SimpleDaoTemplate.update(new ITransaction() {
			public int execute(Connection connection) {
				Resource c1 = get(firstId);
				Resource c2 = get(secondId);
				
				String sort1 = c1.getSort();
				String sort2 = c2.getSort();
				
				SimpleDaoTemplate.update(connection,
					"UPDATE app_resources SET sort = ? WHERE id = ?", 
					"-1",
					secondId
				);
					
				
				SimpleDaoTemplate.update(connection,
					"UPDATE app_resources SET sort = ? WHERE id = ?", 
					sort2,
					firstId
				);
				
				SimpleDaoTemplate.update(connection,
					"UPDATE app_resources SET sort = ? WHERE id = ?", 
					sort1,
					secondId
				);
				
				return 0;
			}
		});
	}

	public static int remove(String id) {
		return SimpleDaoTemplate.update(
				"DELETE FROM app_resources WHERE id = ?", id);
	}

	public static void removes(String[] ids) {
		if (ids != null) {
			for (String id : ids) {
				remove(id);
			}
		}
	}

	public static String getAllUserResourceTreeJSON(String userId) {
		String json = generateTreeJSON(null, userId);
		LogManager.getLogger(LogManager.LOG_KEY_APP).debug(
				"TreeJSON:" + json);
		return json;
	}

	public static String generateTreeJSON(List<Resource> resources, String userId) {
		if (resources == null) {
			resources = Resource.getChildrenResourceByUserId(userId, null);
		}
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");

		for (Resource resource : resources) {
			buffer.append("{");
			buffer.append("\"id\":" + "\"" + resource.getId() + "\"" + ",");
			buffer.append("\"text\":" + "\"" + resource.getName() + "\"" + ",");
			List<Resource> child = Resource.getChildrenResourceByUserId(userId, resource.getId());
			if (child != null && !child.isEmpty()) {
				buffer.append("\"state\":" + "\"closed\"" + ",");
			}
			// buffer.append("\"iconCls\":\"icon-author\",");
			if (resource.getPath() != null) {
				buffer.append("\"attributes\":{\"path\":" + "\""
						+ resource.getPath() + "\"" + "}");
			} else {
				buffer.append("\"attributes\":null");
			}

			buffer.append(", \"children\" : ").append(generateTreeJSON(child, userId));
			buffer.append("},");
		}
		buffer.append("]");
		
		return buffer.toString().replaceFirst(",]", "]");
	}

	public Resource() {
	}

	public Resource(String id, String name, String path, String parentId,
			String checked, String sort) {
		super();
		this.id = id;
		this.name = name;
		this.path = path;
		this.parentId = parentId;
		this.checked = checked;
		this.sort = sort;
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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Override
	public String toString() {
		return new JSONObject(this).toString().replace("parentId", "_parentId");
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public static void main(String[] args) {
		System.out.println(new Resource());
	}
}
