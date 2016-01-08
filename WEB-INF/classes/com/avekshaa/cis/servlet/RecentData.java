package com.avekshaa.cis.servlet;

import java.util.List;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class RecentData {

	static final Logger logger = Logger.getRootLogger();
//	public static DB db; 
//	static {
//		db = CommonDB.getConnection();
//	}

	String getTAble(String IP) {
		DBCursor alertData = null;
		String a = "<table id='t01' >";
		try {
			
			//1.connect to mongo// host+port
			Mongo m=new Mongo("127.0.0.1",27017);
		
			//2.connect to your DB
			DB db=m.getDB("CIS");
			//System.out.println("DB Name:"+db.getName());
			
			//3.selcet the collection
			DBCollection coll=db.getCollection("CISDetails");
			//System.out.println("collection name:"+coll.getName());
			
			

			
	
			BasicDBObject findObj = 
					new BasicDBObject();
			alertData = coll.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(1);
			List<DBObject> dbObjs = alertData.toArray();
			
			
			
for (int i = 0; i < 1; i++) {
				
				DBObject txnDataObject = dbObjs.get(i);
				Double status = (Double) txnDataObject.get("throughPut");
				
				a = a + "<tr><td>" + status + "</td></tr>";
				
			//	a = a + "<tr><td>Response Time</td><td>" + res_time
						//+ "ms</td></tr>";
				a = a + "<tr> <th colspan='2'> </th></tr>";
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.error("Unexpected error",e);
		} finally {
			alertData.close();

		}
//System.out.println(a);
		a = a + "</table>";

		return a;
	}
}
