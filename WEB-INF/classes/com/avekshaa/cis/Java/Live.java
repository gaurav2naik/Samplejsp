package com.avekshaa.cis.Java;


import java.util.List;
import java.util.Map;
import java.util.TreeMap;






import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class Live {

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	public Map<Long, String> getResponseTimesForScatterGraph(String startTime,
			String endTime, String sourceEndpointInp, String targetEndpointInp) {
		DBCursor alertData = null;
		DBObject exectime = null;
		TreeMap<Long, String> rexecandresp = new TreeMap<Long, String>();
		try {

			//System.out.println("DB Name:"+db.getName());
			
			//3.select the collection
			DBCollection coll=db.getCollection("CISResponse");
			//System.out.println("coll name"+coll.getName());
			
			
			
			
			
			BasicDBObject findObj = new BasicDBObject();
			alertData = coll.find(findObj).sort(exectime);
			alertData.sort(new BasicDBObject("_id", -1));
	
			alertData.limit(40);
			List<DBObject> dbObjs = alertData.toArray();

			for (int i = dbObjs.size() - 1; i >= 0; i--)

			{
				DBObject txnDataObject = dbObjs.get(i);
				String IP = (String) txnDataObject.get("IP_Address");
				String URI = (String) txnDataObject.get("URI");
				Long execTime = (Long) txnDataObject.get("exectime");
				/*
				 * Integer responseTime = (Integer) txnDataObject
				 * .get("response_time");
				 */
				double responseTi = Double.parseDouble(txnDataObject.get(
						"response_time").toString());
				int responseTime = (int) responseTi;
				rexecandresp.put(execTime, IP + "&&" + URI + "&&" + responseTime);
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.error("Unexpected error", e);
		} finally {
			alertData.close();
		}
		////System.out.println("Before Return"+rexecandresp);
		return rexecandresp;
	}

}