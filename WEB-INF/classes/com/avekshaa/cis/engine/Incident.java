package com.avekshaa.cis.engine;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import org.apache.log4j.Logger;

public class Incident {

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}
	static final Logger logger = Logger.getRootLogger();

	public Map<Long, Double> incident(/*
									 * String startTime, String endTime, String
									 * sourceEndpointInp, String
									 * targetEndpointInp
									 */) {
		DBCursor alertData = null;
		TreeMap<Long, Double> map1 = new TreeMap<Long, Double>();
		DBObject exectime = null;

		try {

			DBCollection cisresponse = db.getCollection("CISIncident_data");
			BasicDBObject findObj = new BasicDBObject();
			alertData = cisresponse.find(findObj).sort(exectime);
			alertData.limit(50);
			alertData.sort(new BasicDBObject("_id", -1));
			// //System.out.println(alertData);
			List<DBObject> dbObjs = alertData.toArray();
			// //System.out.println("dbObj  size :"+dbObjs.size());
			for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 50; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				Double pererror = (Double) txnDataObject
						.get("error_percentage");
				Long time = (Long) txnDataObject.get("system_current_time");
				// //System.out.println(time);
				double percenterror;
				Long resptime = time;
				percenterror = pererror;
				map1.put(resptime, percenterror);
				// //System.out.println("---------"+map1);

				/*int a = 10, b = 0, ans;
				ans = a / b;
				//System.out.println("here" + ans);*/

			}
		} catch (Exception e) {
			// e.printStackTrace();
			logger.error(e);

		} finally {
			alertData.close();
		}

		return map1;
	}

}
