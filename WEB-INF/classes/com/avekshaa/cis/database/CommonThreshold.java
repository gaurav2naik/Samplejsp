package com.avekshaa.cis.database;

import java.util.List;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CommonThreshold {

	public static int getAndroidThreshold() {
		DBCursor alertData = null;
		int res = 0;
		try {
			DB db = CommonDB.getBankConnection();

			// 3.select the collection
			DBCollection coll = db.getCollection("ThresholdDB");
			DBObject findObj = new BasicDBObject();
			alertData = coll.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(1);
			List<DBObject> dbObjs = alertData.toArray();
			for (int i = dbObjs.size() - 1; i >= 0; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				 res = (Integer) txnDataObject.get("Android_threshold");
				 System.out.println("THRES:"+res);
			}
		} catch (Exception e) {

		}
		
		return res;
	}
	
	public static int getWebThreshold() {
		DBCursor alertData = null;
		int res = 0;
		try {
			DB db = CommonDB.getBankConnection();

			// 3.select the collection
			DBCollection coll = db.getCollection("ThresholdDB");
			DBObject findObj = new BasicDBObject();
			alertData = coll.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(1);
			List<DBObject> dbObjs = alertData.toArray();
			for (int i = dbObjs.size() - 1; i >= 0; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				 res = (Integer) txnDataObject.get("Web_threshold");
				 System.out.println("THRES:"+res);
			}
		} catch (Exception e) {

		}
		
		return res;
	}
	
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CommonThreshold.getAndroidThreshold();
	}

}
