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
public class Live {

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}
	static final Logger logger = Logger.getRootLogger();
	///public static void main(String[] args) {
		

	public Map<Long, String> getResponseTimesForScatterGraph(String startTime,String endTime, String sourceEndpointInp, String targetEndpointInp) {
		DBCursor alertData = null;
		DBObject exectime = null;
		TreeMap<Long, String> rexecandresp = new TreeMap<Long, String>();
		try {
			DBCollection cisresponse = db.getCollection("CISResponse");
			BasicDBObject search = new BasicDBObject();
			search.put("exectime",
					new BasicDBObject("$lt",System.currentTimeMillis() ));
			BasicDBObject findObj = new BasicDBObject();
			findObj.put("response_time", 1);
			findObj.put("IP_Address", 1);
			findObj.put("URI", 1);
			findObj.put("exectime", 1);
			findObj.put("_id", 0);
			
			alertData = cisresponse.find(search , findObj).sort(exectime);
			
			alertData.sort(new BasicDBObject("_id", -1));
			// //System.out.println("alert d daata" + alertData);
			alertData.limit(40);
			List<DBObject> dbObjs = alertData.toArray();
System.out.println(dbObjs);
			for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 40; i--)

			{
				DBObject txnDataObject = dbObjs.get(i);
				String IP = (String) txnDataObject.get("IP_Address");
				String URI = (String) txnDataObject.get("URI");
				Long execTime = (Long) txnDataObject.get("exectime");
				
				/* Integer responseTime = (Integer) txnDataObject
				 .get("response_time");*/
				 
				double responseTi = Double.parseDouble(txnDataObject.get(
						"response_time").toString());
				int responseTime = (int) responseTi;
				//System.out.println(responseTime);
				rexecandresp.put(execTime, IP + "&&" + URI + "&&" + responseTime);
				//System.out.println(execTime+"  "+IP + "&&" + URI + "&&" + responseTime);
			}
		} catch (Exception e) {
			e.printStackTrace();
			//logger.error("Unexpected error", e);
		} finally {
			alertData.close();
		}
		//System.out.println(rexecandresp);
		return rexecandresp;
	}

}