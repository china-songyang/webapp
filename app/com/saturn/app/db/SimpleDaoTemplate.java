package com.saturn.app.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.saturn.app.exception.DBException;
import com.saturn.app.utils.LogManager;

public class SimpleDaoTemplate {
	private static Logger loger = LogManager.getLogger(LogManager.LOG_KEY_APP);

	private static DataSource dataSource = DatabaseManager.getInstance()
			.getDataSource();

	public static int queryCount(String sql, DymaticCondition dymaticCondition) {
		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		int result = 0;
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			if (dymaticCondition != null) {
				sql += dymaticCondition.toString();
			}
			loger.debug("querySql:" + sql);

			connection = dataSource.getConnection();
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;

	}

	public static <T extends Object> List<T> query(String sql,
			DymaticCondition dymaticCondition, ORMapping<T> mapping,
			Class<T> clazzT) {

		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		if (mapping == null) {
			throw new DBException("ORMapping is null");
		}

		Connection connection = null;
		List<T> results = null;

		try {
			connection = dataSource.getConnection();
			results = query(connection, sql, dymaticCondition, mapping, clazzT);
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}
		return results;
	}

	public static <T extends Object> List<T> query(Connection connection,
			String sql, DymaticCondition dymaticCondition,
			ORMapping<T> mapping, Class<T> clazzT) {

		List<T> results = new ArrayList<T>();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			if (dymaticCondition != null) {
				sql += dymaticCondition.toString();
			}
			loger.debug("querySql:" + sql);

			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				T t = clazzT.newInstance();
				mapping.mappingResult(rs, t);

				results.add(t);
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return results;
	}

	public static <T extends Object> ListData<T> query(String sql,
			DymaticCondition dymaticCondition, ORMapping<T> mapping,
			Class<T> clazzT, String start, String offset) {

		int total = SimpleDaoTemplate.queryCount(getCountSql(sql),
				dymaticCondition);

		List<T> list = query(sql,
				dymaticCondition.addCondition("LIMIT {0}, {1}", start, offset),
				mapping, clazzT);

		return new ListData<T>(total, list);
	}

	private static String getCountSql(String sql) {
		sql = sql.toUpperCase();
		int index = sql.indexOf("FROM");

		return "SELECT count(*) " + sql.substring(index).toLowerCase();
	}

	public static <T extends Object> T queryOne(String sql,
			DymaticCondition dymaticCondition, ORMapping<T> mapping,
			Class<T> clazzT) {

		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		if (mapping == null) {
			throw new DBException("ORMapping is null");
		}

		Connection connection = null;
		T t = null;
		try {
			connection = dataSource.getConnection();
			t = queryOne(connection, sql, dymaticCondition, mapping, clazzT);
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return t;
	}

	public static <T extends Object> T queryOne(Connection connection,
			String sql, DymaticCondition dymaticCondition,
			ORMapping<T> mapping, Class<T> clazzT) {

		PreparedStatement ps = null;
		ResultSet rs = null;
		T t = null;
		try {
			if (dymaticCondition != null) {
				sql += dymaticCondition.toString();
			}
			loger.debug("querySql:" + sql);

			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				t = clazzT.newInstance();
				mapping.mappingResult(rs, t);
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return t;
	}

	public static <T extends Object> int update(String sql, String... args) {
		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		Connection connection = null;
		int result = 0;

		try {
			connection = dataSource.getConnection();
			result = update(connection, sql, args);
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;
	}

	public static <T extends Object> int update(Connection connection,
			String sql, String... args) {

		PreparedStatement ps = null;
		int result = 0;

		try {
			ps = connection.prepareStatement(sql);

			if (args != null) {
				int i = 1;
				for (String arg : args) {
					if (arg != null) {
						ps.setString(i++, arg);
					}
				}
			}

			result = ps.executeUpdate();
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;
	}

	public static <T extends Object> int update(String sql, T t,
			ORMapping<T> mapping) {

		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		if (mapping == null) {
			throw new DBException("ORMapping is null");
		}

		Connection connection = null;
		int result = 0;

		try {
			connection = dataSource.getConnection();

			result = update(connection, sql, t, mapping);
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;
	}

	public static <T extends Object> int update(Connection connection,
			String sql, T t, ORMapping<T> mapping) {

		PreparedStatement ps = null;
		int result = 0;

		try {
			ps = connection.prepareStatement(sql);
			mapping.mappingParameter(ps, t);
			result = ps.executeUpdate();
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;
	}

	public static int update(ITransaction transaction) {
		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		Connection connection = null;
		int result = 0;
		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);
			result = transaction.execute(connection);
			connection.commit();
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				throw new DBException(e1);
			}
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return result;
	}

	public static List<Map<String, String>> query(String sql,
			DymaticCondition dymaticCondition, String... args) {

		if (dataSource == null) {
			throw new DBException("DataSource is null");
		}

		Connection connection = null;
		List<Map<String, String>> results = null;

		try {
			connection = dataSource.getConnection();
			results = query(connection, sql, dymaticCondition, args);
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}
		return results;
	}

	public static List<Map<String, String>> query(Connection connection,
			String sql, DymaticCondition dymaticCondition, String... args) {

		List<Map<String, String>> results = new ArrayList<Map<String, String>>();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			if (dymaticCondition != null) {
				sql += dymaticCondition.toString();
			}
			loger.debug("querySql:" + sql);

			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {

				Map<String, String> map = new HashMap<String, String>();
				String filed = "";
				for (int i = 0; i < args.length; i++) {
					if (args[i].indexOf(" ") < 0) {
						if (args[i].indexOf(".") > 0) {
							filed = args[i].substring(args[i].indexOf(".") + 1,
									(args[i].length()));
							map.put(filed, rs.getString(filed));
						} else {
							map.put(args[i], rs.getString(args[i]));
						}
					} else {
						filed = args[i].substring(args[i].indexOf(" ") + 1,
								(args[i].length()));
						map.put(filed, rs.getString(filed));
					}

				}

				results.add(map);
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
		}

		return results;
	}
}
