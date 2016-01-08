package com.avekshaa.cis.Java;

import java.util.Date;
import java.util.TreeMap;
import java.util.List;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class AndroidMap {
	public static DB db;
	static {
		db = CommonDB.getBankConnection();
	}

	// public static void main(String[] args) {

	public TreeMap<Long, Double> mtd() {

		TreeMap<Long, Double> finalMap = new TreeMap<Long, Double>();
		DBCursor alertData = null;

		try {

			// long now = System.currentTimeMillis();
			// System.out.println("current time"+now);
			// long beforetime = System.currentTimeMillis()- (24 * 60 * 60 *
			// 1000);
			long millisInDay = 60 * 60 * 24 * 1000;
			long currentTime = new Date().getTime();
			long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			// Date clearDate = new Date(dateOnly);
			// System.out.println("clear date"+clearDate+
			// "current time :"+currentTime+" date only"+dateOnly);

			Double avg = null;
			Long curTim = null;
			// ----------------------------------DB
			// CONNCETION---------------------------------------------------------------------
			
			DBCollection coll = db.getCollection("ANDROID_LIVE_AVG");
			// System.out.println("collection name:" + coll.getName());
			// -----------------------------------------------------------------------------------------------------------
			// fetch key and value
			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("Current_Time", new BasicDBObject("$gt", dateOnly));

			alertData = coll.find(findObj1);
			alertData.limit(50); // last 1
			alertData.sort(new BasicDBObject("_id", -1));

			List<DBObject> dbObjs = alertData.toArray(); // return finalMap;
			for (int i1 = 0; i1 < dbObjs.size(); i1++)

			{
				DBObject txnDataObject = dbObjs.get(i1);
				avg = (Double) txnDataObject.get("Average");

				curTim = (Long) txnDataObject.get("Current_Time");

				// System.out.println("avggg---->>:"+avg);

				// System.out.println("current---->>:"+curTim);

				finalMap.put(curTim, avg);// store in map

				// System.out.println("FINAL MAPl:" + finalMap);

			}

		}

		catch (Exception e)

		{
			e.printStackTrace();
		} finally {
			alertData.close();
		}

		return finalMap;

	}

	public TreeMap<Long, Double> getDataForPerMin() {

		TreeMap<Long, Double> finalMap = new TreeMap<Long, Double>();
		DBCursor alertData = null;

		try {

			long now = System.currentTimeMillis();
			// System.out.println("current time"+now);
			long beforetime = System.currentTimeMillis() - (60 * 60 * 1000);

			Double avg = null;
			Long curTim = null;
			// ----------------------------------DB
			// CONNCETION---------------------------------------------------------------------
			// 1.connect to mongo// host+port
			/*
			 * Mongo m = new Mongo("52.24.170.28", 27017);
			 * 
			 * // 2.connect to your DB DB db = m.getDB("AndroidData");
			 */
			// System.out.println("DB Name:" + db.getName());

			// 3.selcet the collection
			DBCollection coll = db.getCollection("AndroidAvgPerMin");

			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("Current_Time", new BasicDBObject("$gt", beforetime));

			alertData = coll.find(findObj1);
			alertData.limit(60); // last 1
			System.out.println("one hour data size:"+alertData.size());
			alertData.sort(new BasicDBObject("_id", -1));

			List<DBObject> dbObjs = alertData.toArray(); // return finalMap;
			for (int i1 = 0; i1 < dbObjs.size(); i1++)

			{
				DBObject txnDataObject = dbObjs.get(i1);
				avg = (Double) txnDataObject.get("Average");

				curTim = (Long) txnDataObject.get("Current_Time");

				// System.out.println("avggg---->>:"+avg);

				// System.out.println("current---->>:"+curTim);

				finalMap.put(curTim, avg);// store in map

				// System.out.println("FINAL MAPl:" + finalMap);

			}

		}

		catch (Exception e)

		{
			e.printStackTrace();
		} finally {
			alertData.close();
		}

		return finalMap;

	}

}