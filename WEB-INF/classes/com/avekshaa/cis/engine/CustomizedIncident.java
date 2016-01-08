package com.avekshaa.cis.engine;


import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.log4j.Logger;

import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
public class CustomizedIncident 
{
	

	
	static final Logger logger = Logger.getRootLogger();
	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	public Map<Long, Double> incident(String startTime, String endTime) {
		DBCursor cursor = null;
		TreeMap<Long, Double> map1 = new TreeMap<Long, Double>();
		// //System.out.println("Start Time"+startTime);
		// //System.out.println("End TIME"+endTime);

		long t2 = Convertor.timeInMilisecond(startTime);
		long t1 = Convertor.timeInMilisecond(endTime);

		// Pick data for a given time-window.
		try {
			DBCollection alertDataCollection = db
					.getCollection("CISIncident_data");
			BasicDBObject gtQuery = new BasicDBObject();
			gtQuery.put("system_current_time",
					new BasicDBObject("$gt", t2).append("$lt", t1));
			cursor = alertDataCollection.find(gtQuery);
			// //System.out.println("Query   "+cursor);
			List<DBObject> dbObjs = cursor.toArray();
			// //System.out.println("dbObj  size :"+dbObjs.size());
			for (int i = dbObjs.size() - 1; i >= 0; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				Double pererror = (Double) txnDataObject
						.get("error_percentage");
				Long time = (Long) txnDataObject.get("system_current_time");
				double percenterror;
				Long resptime = time;
				percenterror = pererror;
				map1.put(resptime, percenterror);

			}
		} catch (Exception e) {
			
			
			logger.error("Unexpected error",e);
			
			
		} finally {
			cursor.close();
		}

		return map1;

	}

}
