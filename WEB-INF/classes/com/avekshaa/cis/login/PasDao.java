package com.avekshaa.cis.login;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

public class PasDao {
	static final Logger logger = Logger.getRootLogger();
	public static DB m;
	static {
		m = CommonDB.getConnection();
	}

	public static PasBean login(PasBean user) {

		String username = user.getUsername();
		String password = user.getPassword();
		DBCursor dbCursor = null;

		try {

			DBCollection dbCollection = m.getCollection("first");
			BasicDBObject andQuery = new BasicDBObject();
			List<BasicDBObject> param = new ArrayList<BasicDBObject>();
			param.add(new BasicDBObject("UserName", username));
			param.add(new BasicDBObject("Password", password));
			andQuery.put("$and", param);
			dbCursor = dbCollection.find(andQuery);
			boolean more = dbCursor.hasNext();
			while (dbCursor.hasNext()) {
				dbCursor.next();
			}

			// if user does not exist set the isValid variable to false
			if (!more) {
				System.out
						.println("Sorry, you are not a registered user! Please sign up first");
				user.setValid(false);
			}

			// if user exists set the isValid variable to true
			else if (more) {
				// //System.out.println("Welcome ");
				user.setValid(true);
			}
		}

		catch (Exception ex) {
			//System.out.println("Log In failed: An Exception has occurred! "+ ex);
			logger.error("Unexpected error",ex);
			
			
			
			
		}

		finally {
			dbCursor.close();
		}

		return user;

	}
}
