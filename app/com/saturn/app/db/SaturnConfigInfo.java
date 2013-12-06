package com.saturn.app.db;

class SaturnConfigInfo {

	private String dbType = "oracle";
	private String connectType = "jdbc";
	private String jndiname = "JNDINAME";
	private String jdbcdriver = "oracle.jdbc.driver.OracleDriver";
	private String jdbcurl = "jdbc:oracle:thin:@localhost:1521:orcl";
	private String username = "orcl";
	private String password = "orcl";

	private String maxActive = "30";
	private String maxIdle = "10";
	private String maxWait = "500";
	private String removeAbandoned = "false";
	private String removeAbandonedTimeout = "120";
	private String testOnBorrow = "true";

	private String validationQuery = "SELECT COUNT(*) FROM DUAL";

	public String getDbType() {
		return dbType;
	}

	public void setDbType(String dbType) {
		if (dbType != null) {
			this.dbType = dbType;
		}
	}

	public String getConnectType() {
		return connectType;
	}

	public void setConnectType(String connectType) {
		if (connectType != null) {
			this.connectType = connectType;
		}
	}

	public String getJndiname() {
		return jndiname;
	}

	public void setJndiname(String jndiname) {
		if (jndiname != null) {
			this.jndiname = jndiname;
		}
	}

	public String getJdbcdriver() {
		return jdbcdriver;
	}

	public void setJdbcdriver(String jdbcdriver) {
		if (jdbcdriver != null) {
			this.jdbcdriver = jdbcdriver;
		}
	}

	public String getJdbcurl() {
		return jdbcurl;
	}

	public void setJdbcurl(String jdbcurl) {
		if (jdbcurl != null) {
			this.jdbcurl = jdbcurl;
		}
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		if (username != null) {
			this.username = username;
		}
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		if (password != null) {
			this.password = password;
		}
	}
	
	public String getMaxActive() {
		return maxActive;
	}

	
	public void setMaxActive(String maxActive) {
		if (maxActive != null) {
			this.maxActive = maxActive;
		}
	}

	public String getMaxIdle() {
		return maxIdle;
	}

	public void setMaxIdle(String maxIdle) {
		if (maxIdle != null) {
			this.maxIdle = maxIdle;
		}
	}
	
	public String getMaxWait() {
		return maxWait;
	}

	public void setMaxWait(String maxWait) {
		if (maxWait != null) {
			this.maxWait = maxWait;
		}
	}

	public String getRemoveAbandoned() {
		return removeAbandoned;
	}

	public void setRemoveAbandoned(String removeAbandoned) {
		if (removeAbandoned != null) {
			this.removeAbandoned = removeAbandoned;
		}
	}

	public String getRemoveAbandonedTimeout() {
		return removeAbandonedTimeout;
	}

	public void setRemoveAbandonedTimeout(String removeAbandonedTimeout) {
		if (removeAbandonedTimeout != null) {
			this.removeAbandonedTimeout = removeAbandonedTimeout;
		}
	}

	public String getTestOnBorrow() {
		return testOnBorrow;
	}

	public void setTestOnBorrow(String testOnBorrow) {
		if (testOnBorrow != null) {
			this.testOnBorrow = testOnBorrow;
		}
	}

	public String getValidationQuery() {
		return validationQuery;
	}

	public void setValidationQuery(String validationQuery) {
		if (validationQuery != null) {
			this.validationQuery = validationQuery;
		}
	}
}
