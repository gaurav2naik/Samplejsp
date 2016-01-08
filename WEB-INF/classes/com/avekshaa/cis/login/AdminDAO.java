package com.avekshaa.cis.login;

import java.util.ArrayList;
import java.util.List;

import com.avekshaa.cis.database.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

public class AdminDAO {
	public static DB m;
	static {
		m = CommonDB.getConnection();
	}

	public static AdminBean login(AdminBean bean) {

		String username = bean.getUsername();
		String password = bean.getPassword();

		DBCursor dbCursor = null;

		try {

			DBCollection dbCollection = m.getCollection("admin");
			BasicDBObject andQuery = new BasicDBObject();

			List<BasicDBObject> param = new ArrayList<BasicDBObject>();
			param.add(new BasicDBObject("UserName", username));
			param.add(new BasicDBObject("Password", password));
			andQuery.put("$and", param);
			// //System.out.println("Query: "+andQuery.toString());
			dbCursor = dbCollection.find(andQuery);
			boolean more = dbCursor.hasNext();
			// //System.out.println("more: "+more);
			while (dbCursor.hasNext()) {
				dbCursor.next();
			}

			// if user does not exist set the isValid variable to false
			if (!more) {
				// System.out
				// .println("Sorry, you are not a registered user! Please sign up first");
				bean.setValid(false);
			}

			// if user exists set the isValid variable to true
			else if (more) {
				// //System.out.println("Welcome ");
				bean.setValid(true);
			}
		}

		catch (Exception ex) {
			//System.out.println("Log In failed: An Exception has occurred! "+ ex);
		}

		finally {
			dbCursor.close();
		}

		return bean;

	}
}
