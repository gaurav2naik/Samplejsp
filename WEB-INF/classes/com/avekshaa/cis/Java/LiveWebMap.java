package com.avekshaa.cis.Java;

import java.util.ArrayList;
import java.util.TreeMap;
import java.util.List;
import java.util.Map;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class LiveWebMap {
	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	// public static void main(String[] args) {

	public TreeMap<Long, Double> mtd() {

		TreeMap<Long, Double> finalMap = new TreeMap<Long, Double>();
		DBCursor alertData = null;

		try {
			Double avg = null;
			Long curTim = null;

			long now = System.currentTimeMillis();
			// System.out.println("current time"+now);
			long beforetime = System.currentTimeMillis() - 60*1000;
			

			// 3.selcet the collection
			DBCollection coll = db.getCollection("WEB_LIVE_AVG");
			// System.out.println("collection name:" + coll.getName());
			// -----------------------------------------------------------------------------------------------------------

			// fetch key and value
			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("Current_Time",new BasicDBObject("$gt", beforetime).append("$lt", now));

			alertData = coll.find(findObj1);
			alertData.limit(60); // last 1
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