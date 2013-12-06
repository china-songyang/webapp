package com.saturn.app.db;

import java.sql.Connection;

public interface ITransaction {
	
	public abstract int execute(Connection connection);
}
