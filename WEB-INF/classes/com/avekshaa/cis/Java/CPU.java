package com.avekshaa.cis.Java;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CPU {
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}

	// public static void main(String[] args) {

	public Map<String, Double> mtd() {

		HashMap<String, Double> finalMap = new HashMap<String, Double>();
		DBCursor alertData = null;

		try {

			// 3.selcet the collection
			DBCollection coll = db.getCollection("Android_Avg");
			// System.out.println("collection name:" + coll.getName());
			// -----------------------------------------------------------------------------------------------------------
			BasicDBObject findObj = new BasicDBObject();
			alertData = coll.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));

			List<DBObject> dbObjs = alertData.toArray();
			if (!dbObjs.isEmpty()) {

				DBObject dbo = dbObjs.get(0);

				// System.out.println(dbo);
				for (String key : dbo.keySet()) {
					if (!key.startsWith("_id")) {
						// System.out.println(dbo.get( key ).toString());
						String Device = key;
						// Integer Response = Integer.parseInt(dbo.get( key
						// ).toString()) ;

						// double responseTi = Double.parseDouble(dbo.get( key
						// ).toString().toString());
						Double responseTime = Double.valueOf(dbo.get(key)
								.toString());

						/*
						 * System.out.println(key);
						 * System.out.println(dbo.get(key).toString());
						 */
						finalMap.put(Device, responseTime);

					}
				}

				// ----------------------------------------------------------------------------------------------------------------------
				// sum of avg cpu%

			}
			else

			System.out.println("Android_Avg is null");
		}

		catch (Exception e)

		{
			e.printStackTrace();
		} finally {
			if (alertData != null)
				alertData.close();
		}
		return finalMap;

	}

}
