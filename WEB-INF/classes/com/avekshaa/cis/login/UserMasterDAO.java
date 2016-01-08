package com.avekshaa.cis.login;

import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.avekshaa.cis.commonutil.*;
import com.avekshaa.cis.database.*;
import com.avekshaa.cis.quartzjob.AndroidAverageCalculation;
import com.avekshaa.cis.quartzjob.AvgResponseAlerts;
import com.avekshaa.cis.quartzjob.WebResponseAvg;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.WriteResult;

public class UserMasterDAO {
	static final Logger logger = Logger.getRootLogger();
	public static DB m;
	static {
		m = CommonDB.getBankConnection();
	}

	public static UserMasterBean createUser(UserMasterBean bean) {

		String username = bean.getUsername();
		String password = bean.getPassword();
		String userid = bean.getUserId();
		DBCursor dbCursor = null;

		try {
			DBCollection User = m.getCollection("first");
			BasicDBObject whereQuery = new BasicDBObject();
			whereQuery.put("UserName", username);
			dbCursor = User.find(whereQuery);
			boolean isUserAlreadyExist = dbCursor.hasNext();

			// if user does not exist set the isValid variable to false
			if (!isUserAlreadyExist) {
				// ////System.out.println("Add User");
				BasicDBObject addUser = new BasicDBObject();
				addUser.put("UserId", userid);
				addUser.put("UserName", username);
				addUser.put("Password", password);

				User.insert(addUser);
				bean.setValid(true);
			}
			// if user exists set the isValid variable to true
			else if (isUserAlreadyExist) {
				// ////System.out.println("User Already Exist");
				bean.setValid(false);
			}
		}

		catch (Exception ex) {
			// //System.out.println("Log In failed: An Exception has occurred! "+
			// ex);
			logger.error("Unexpected error", ex);
		}

		finally {
			dbCursor.close();

		}

		return bean;

	}

	public static UserMasterBean createPremiumUser(UserMasterBean bean) {

		String Puser = bean.getPremiumuser();

		DBCursor dbCursor = null;

		try {
			DBCollection PUser = m.getCollection("PremiumUser");
			BasicDBObject whereQuery = new BasicDBObject();
			whereQuery.put("PremiumUserName", Puser);
			dbCursor = PUser.find(whereQuery);
			boolean isUserAlreadyExist = dbCursor.hasNext();

			// if user does not exist set the isValid variable to false
			if (!isUserAlreadyExist) {
				// ////System.out.println("Add User");
				BasicDBObject addPUser = new BasicDBObject();
				addPUser.put("PremiumUserName", Puser);
				PUser.insert(addPUser);
				bean.setValid(true);
			}
			// if user exists set the isValid variable to true
			else if (isUserAlreadyExist) {
				// ////System.out.println("User Already Exist");
				bean.setValid(false);
			}
		}

		catch (Exception ex) {
			// //System.out.println("Log In failed: An Exception has occurred! "+
			// ex);
			logger.error("Unexpected error", ex);
		}

		finally {
			dbCursor.close();

		}

		return bean;

	}

	// Delete Premium user

	public static UserMasterBean deletePremiumUser(UserMasterBean bean) {
		String pmUser = bean.getPremiumuser().trim();
		System.out.println("inside delete UMD" + pmUser);

		DBCursor dbCursor = null;

		try {
			DBCollection premiumUser = m.getCollection("PremiumUser");
			System.out.println("Collection" + premiumUser);
			BasicDBObject query = new BasicDBObject("PremiumUserName", pmUser);
			// whereQuery.put("PremiumUserName", Puser);
			dbCursor = premiumUser.find(query);
			System.out.println("UMD count:" + premiumUser.find(query).count());
			boolean isUserExist = dbCursor.hasNext();
			System.out.println("inside delete UMD :" + isUserExist);

			// if user does exist set the isValid variable to true
			if (isUserExist) {
				// ////System.out.println("Add User");
				BasicDBObject deletePUser = new BasicDBObject();
				deletePUser.put("PremiumUserName", pmUser);
				WriteResult status = premiumUser.remove(deletePUser);
				System.out.println("Delete user status :" + status);
				bean.setValid(true);
			}
			// if user does not exist set the isValid variable to false
			else if (!isUserExist) {
				// ////System.out.println("User Already Exist");
				bean.setValid(false);
			}
		}

		catch (Exception ex) {
			// //System.out.println("Log In failed: An Exception has occurred! "+
			// ex);
			logger.error("Unexpected error", ex);
		}

		finally {
			dbCursor.close();

		}

		return bean;

	}

	public static String disableUser(String deleteUser) {
		Statement stmt = null;
		String userDeleted = "";
		try {
			// //System.out.println("In UserMasterDAO");
			// //System.out.println("Delete UserName: " + deleteUser);
			DBCollection dbCollection = m.getCollection("first");
			BasicDBObject document = new BasicDBObject();
			document.put("UserName", deleteUser);
			// DBCursor dbCursor = dbCollection.find(document);
			dbCollection.remove(document);
			userDeleted = "S";
			// //System.out.println("User Deleted Successfully...");

			/*
			 * while(dbCursor.hasNext()) { dbCollection.remove(document);
			 * //bean.setValid(true);
			 * ////System.out.println("User Deleted Successfully..."); }
			 */
		}

		catch (Exception ex) {
			userDeleted = "F";
			// //System.out.println("Log In failed: An Exception has occurred! "+
			// ex);
			logger.error("Unexpected error", ex);
		}

		finally {
		}

		return userDeleted;

	}

	public static UserMasterBean modifyUser(UserMasterBean bean) {

		String userName = bean.getUsername();
		String email = bean.getEmail();
		String mobile = bean.getMobile();
		DB db = CommonDB.getConnection();

		DBCollection dbCollection = db.getCollection("first");
		BasicDBObject updateColumns = new BasicDBObject();
		BasicDBObject updateQuery = new BasicDBObject();

		// updateColumns.put("UserName", userName);
		updateColumns.put("Email", email);
		updateColumns.put("Mobile", mobile);
		updateQuery.put("$set", updateColumns);

		BasicDBObject searchQuery = new BasicDBObject();
		searchQuery.append("UserName", userName);
		dbCollection.updateMulti(searchQuery, updateQuery);
		AndroidAverageCalculation.setMail();
		WebResponseAvg.setMail();
		// System.out.println(userName + " "+email + " "+mobile );

		return bean;
	}

}