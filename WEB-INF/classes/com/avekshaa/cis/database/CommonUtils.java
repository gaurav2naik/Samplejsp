package com.avekshaa.cis.database;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.TreeMap;

import org.apache.log4j.Logger;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.commonutil.Convertor;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CommonUtils {
	static final Logger logger = Logger.getRootLogger();
	static String Error_Detail;

	static ConfigurationVo vo = null;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("Unexpected error", e);
		}
	}
	public static DB db;
	static {
		db = CommonDB.getBankConnection();
	}
	/*public static DB db1;
	static {
		db1 = CommonDB.AndroidConnection();
	}*/
	public static DB db2;
	static {
		db2 = CommonDB.getConnection();
	}

	static TreeMap<Object, Object> mapOfIPandURI = null;

	/**
	 * This is a public method which is called from a UI layer (search screen)
	 * to fetch distict IP Addres Present in Database
	 * 
	 * 
	 * 
	 * @throws DatabaseConnectionException
	 *             if it can't connect to MongoDB database.
	 */

	public static List<DBObject> getAllIPandURL() {
		java.util.List<DBObject> l1 = null;
		if (null == l1) {

			try {

				DBCollection cisresponse = db2.getCollection("CISResponse");

				l1 = cisresponse.distinct("IP_Address");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return l1;

	}

	public static List<DBObject> getPremiumdevice() {
		java.util.List<DBObject> l1 = null;
		if (null == l1) {

			try {

				DBCollection Regular = db.getCollection("PremiumUser");

				l1 = Regular.distinct("PremiumUserName");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return l1;

	}

	public static Collection<String> getdevice() {
		/*
		 * java.util.List<DBObject> allldevicename = null;
		 * java.util.List<DBObject> addeddevice = null; java.util.List<DBObject>
		 * leftdevice = null;
		 */
		Collection<String> allldevicename = new HashSet<String>();
		Collection<String> addeddevice = new HashSet<String>();

		try {

			DBCollection Regular = db.getCollection("Regular");

			allldevicename = Regular.distinct("UUID");

			DBCollection cisresponse = db.getCollection("PremiumUser");

			addeddevice = cisresponse.distinct("PremiumUserName");
			allldevicename.removeAll(addeddevice);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return allldevicename;

	}

	// Getting Premium Devices List
	@SuppressWarnings("unchecked")
	public static Collection<String> getPremiumDevices() {
		Collection<String> premiumDevices = new HashSet<>();
		try {
			DBCollection PMUser = db.getCollection("PremiumUser");

			premiumDevices = PMUser.distinct("PremiumUserName");
			System.out.println("premium user list: " + premiumDevices);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return premiumDevices;
	}

	// end

	public static HashMap<String, String> getIncident(String startTime) {

		DBCursor alertData = null;
		DBObject exectime = null;
		DBCursor dd = null;
		int ErrorCode = 299;

		LinkedHashMap<String, String> rexecandresp = new LinkedHashMap<String, String>();
		try {
			DBCollection cisresponse = db2.getCollection("CISResponse");
			DBObject findObj = new BasicDBObject("status_Code",
					new BasicDBObject("$gt", ErrorCode));
			DBObject orderBy = new BasicDBObject("_id", -1);
			alertData = cisresponse.find(findObj).sort(orderBy);

			alertData.limit(100);
			System.out.println("alert data" + alertData);
			List<DBObject> dbObjs = alertData.toArray();

			for (int i = 0; i <= dbObjs.size() - 1; i++)

			{
				DBObject txnDataObject = dbObjs.get(i);
				String IP = (String) txnDataObject.get("IP_Address");
				String URI = (String) txnDataObject.get("URI");
				Long execTime = (Long) txnDataObject.get("exectime");
				String formtime = Convertor.timeInDefaultFormat(execTime);
				/*
				 * double responseTi = Double.parseDouble(txnDataObject.get(
				 * "response_time").toString()); int responseTime = (int)
				 * responseTi;
				 */
				String Device = (String) txnDataObject.get("Device");
				/* Integer status =(Integer) txnDataObject.get("status_Code"); */
				double status = Double.parseDouble(txnDataObject.get(
						"status_Code").toString());
				int responseTime = (int) status;
				String errorstatus = Integer.toString(responseTime);
				DBCollection errorlist = db2.getCollection("Errorlist");
				BasicDBObject err = new BasicDBObject();
				dd = errorlist.find(err);

				List<DBObject> dbObjs1 = dd.toArray();
				// //System.out.println("error detail"+dbObjs1);
				for (int j = dbObjs1.size() - 1; j > dbObjs1.size() - 2; j--) {
					try {

						DBObject txnDataOb = dbObjs1.get(j);
						Error_Detail = (String) txnDataOb.get(errorstatus);
						// //System.out.println(Error_Detail+"  "+errorstatur);

					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				// System.out.println("time :"+formtime+""
				// +IP+URI+execTime+status+Device+" error "+status+" --> "+
				// Error_Detail);
				rexecandresp.put(formtime, IP + "_" + URI + "_" + errorstatus
						+ "_" + Error_Detail + "_" + Device);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// logger.error("Unexpected error", e);
		} finally {
			dd.close();
			alertData.close();

		}
		// System.out.println("Before return Incident"+rexecandresp);
		return rexecandresp;
	}
}
/*
 * double z;// error count z = txnDataCollection.count(new
 * BasicDBObject("status_Code", new BasicDBObject("$gt",
 * 299)).append("exectime", new BasicDBObject("$gt", beforetime).append("$lt",
 * now)));
 */
