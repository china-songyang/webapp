package com.saturn.app.db;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.dbcp.BasicDataSourceFactory;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;

import com.saturn.app.utils.Dom4jUtils;
import com.saturn.app.utils.LogManager;

public class DatabaseManager {

	private static Logger logger = LogManager.getLogger(LogManager.LOG_KEY_APP);

	private static final String DBDATA_SOURCE_CONFIG_FILE = "/saturn-config.xml";

	private static final String JAVA_COMP_ENV = "java:comp/env/";
	private static final String URLNAME = "url";
	private static final String DRIVER_CLASS_NAME = "driverClassName";
	private static final String JDBC = "jdbc";
	private static final String VALIDATION_QUERY = "validationQuery";
	private static final String TEST_ON_BORROW = "testOnBorrow";
	private static final String REMOVE_ABANDONED_TIMEOUT = "removeAbandonedTimeout";
	private static final String REMOVE_ABANDONED = "removeAbandoned";
	private static final String MAX_WAIT = "maxWait";
	private static final String MAX_IDLE = "maxIdle";
	private static final String MAX_ACTIVE = "maxActive";
	private static final String PASS_WORD = "password";
	private static final String USER_NAME = "username";

	private static final String XML_KEY_DATABASE = "database";
	private static final String XML_VALIDATION_QUERY = "validationQuery";
	private static final String XML_TEST_ON_BORROW = "testOnBorrow";
	private static final String XML_REMOVE_ABANDONED_TIMEOUT = "removeAbandonedTimeout";
	private static final String XML_REMOVE_ABANDONED = "removeAbandoned";
	private static final String XML_MAX_WAIT = "maxWait";
	private static final String XML_MAX_IDLE = "maxIdle";
	private static final String XML_MAX_ACTIVE = "maxActive";
	private static final String XML_PASSWORD = "password";
	private static final String XML_USERNAME = "username";
	private static final String XML_JDBC_URL = "jdbcurl";
	private static final String XML_JDBC_DRIVER = "jdbcdriver";
	private static final String XML_JNDINAME = "jndiname";
	private static final String XML_CONNECT_TYPE = "connectType";
	private static final String XML_DATABASE_TYPE = "dbType";

	private static DatabaseManager dbManager;
	private static DataSource defaultDS = null;
	
	static {
		dbManager = new DatabaseManager();
	}

	private DatabaseManager() {
		initalDataSource();
	}

	/**
	 * 获得DatabaseManager的单态实例
	 * 
	 * @return
	 */
	public static DatabaseManager getInstance() {
		return dbManager;
	}

	/**
	 * 获得数据源
	 * 
	 * @return
	 */
	public DataSource getDataSource() {
		return defaultDS;
	}
	
	/**
	 * 获得默认配置的数据库连接
	 * 
	 * @return
	 */
	public Connection getConnection() {
		if (defaultDS != null) {
			try {
				// logger.debug("->->Get Default DBConnection");
				return defaultDS.getConnection();

			} catch (Exception e) {
				logger.error("->->Could not find connectin from dataSource. the reason is : "
						+ e.getMessage());
			}
		}
		
		return null;
	}

	/**
	 * 初始化默认的数据源对象。
	 */
	private void initalDataSource() {
		SaturnConfigInfo dataConfig = getSaturnConfigInfo(DBDATA_SOURCE_CONFIG_FILE);

		Connection connection = null;

		String connectType = dataConfig.getConnectType();
		String jdbcdriver = dataConfig.getJdbcdriver();
		String jdbcurl = dataConfig.getJdbcurl().trim();
		String username = dataConfig.getUsername();
		String password = dataConfig.getPassword();
		String maxActive = dataConfig.getMaxActive();
		String maxIdle = dataConfig.getMaxIdle();
		String maxWait = dataConfig.getMaxWait();
		String removeAbandoned = dataConfig.getRemoveAbandoned();
		String removeAbandonedTimeout = dataConfig.getRemoveAbandonedTimeout();
		String testOnBorrow = dataConfig.getTestOnBorrow();
		String validationQuery = dataConfig.getValidationQuery();

		if (connectType.equals(JDBC)) {
			try {
				Properties p = new Properties();
				p.setProperty(DRIVER_CLASS_NAME, jdbcdriver);
				p.setProperty(URLNAME, jdbcurl);
				p.setProperty(PASS_WORD, password);
				p.setProperty(USER_NAME, username);
				p.setProperty(MAX_ACTIVE, maxActive);
				p.setProperty(MAX_IDLE, maxIdle);
				p.setProperty(MAX_WAIT, maxWait);
				p.setProperty(REMOVE_ABANDONED, removeAbandoned);
				p.setProperty(REMOVE_ABANDONED_TIMEOUT, removeAbandonedTimeout);
				p.setProperty(TEST_ON_BORROW, testOnBorrow);
				p.setProperty(VALIDATION_QUERY, validationQuery);

				defaultDS = (BasicDataSource) BasicDataSourceFactory
						.createDataSource(p);

				connection = defaultDS.getConnection();
			} catch (Exception e) {
				logger.warn(
						"->->Config dataSource failed from JDBC : [databaseType->"
								+ dataConfig.getDbType() + "], [jdbcDriver->"
								+ jdbcdriver + "], [url->" + jdbcurl
								+ "], [username->" + username
								+ "], [passowrd->" + password + "]", e);
			} finally {
				if (connection != null) {
					try {
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		} else {
			StringBuffer jndiName = new StringBuffer();
			jndiName.append(JAVA_COMP_ENV).append(dataConfig.getJndiname());

			try {
				Context initCtx = new InitialContext();
				defaultDS = (DataSource) initCtx.lookup(jndiName.toString()
						.trim());

				connection = defaultDS.getConnection();

				logger.debug("->->Config dataSource from JNDI : "
						+ jndiName.toString());

			} catch (Exception e) {
				logger.warn("->->Config dataSource failed from JNDI : "
						+ jndiName.toString(), e);
			} finally {
				if (connection != null) {
					try {
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}

		if (connection == null) {
			defaultDS = null;
		}
	}

	/**
	 * 通过读取数据库连接池的配置文件获得数据库连接池的配置信息。 如果没能解析配置文件则按照程序中的默认值生成配置信息。
	 * 
	 * @param file
	 * @return
	 */
	private static SaturnConfigInfo getSaturnConfigInfo(String file) {
		SaturnConfigInfo dataBaseConfig = new SaturnConfigInfo();
		InputStream in = null;

		try {
			URL url = DatabaseManager.class.getResource(file);
			in = url.openStream();

			Document document = Dom4jUtils.getDocment(in);
			Element root = document.getRootElement();
			Element element = root.element(XML_KEY_DATABASE);

			if (element != null) {
				dataBaseConfig
						.setDbType(element.elementText(XML_DATABASE_TYPE));

				dataBaseConfig.setConnectType(element
						.elementText(XML_CONNECT_TYPE));

				dataBaseConfig.setJndiname(element.elementText(XML_JNDINAME));
				dataBaseConfig.setJdbcdriver(element
						.elementText(XML_JDBC_DRIVER));

				dataBaseConfig.setJdbcurl(element.elementText(XML_JDBC_URL));
				dataBaseConfig.setUsername(element.elementText(XML_USERNAME));
				dataBaseConfig.setPassword(element.elementText(XML_PASSWORD));

				dataBaseConfig
						.setMaxActive(element.elementText(XML_MAX_ACTIVE));

				dataBaseConfig.setMaxIdle(element.elementText(XML_MAX_IDLE));
				dataBaseConfig.setMaxWait(element.elementText(XML_MAX_WAIT));
				dataBaseConfig.setRemoveAbandoned(element
						.elementText(XML_REMOVE_ABANDONED));

				dataBaseConfig.setRemoveAbandonedTimeout(element
						.elementText(XML_REMOVE_ABANDONED_TIMEOUT));

				dataBaseConfig.setTestOnBorrow(element
						.elementText(XML_TEST_ON_BORROW));

				dataBaseConfig.setValidationQuery(element
						.elementText(XML_VALIDATION_QUERY));

				logger.debug("->->Load database config info from saturn-config.xml");
			}
		} catch (Exception e) {
			logger.warn(
					"->->Read database config failed from \"/database/saturn-config.xml\", inital dataSource with default value.",
					e);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return dataBaseConfig;
	}
}