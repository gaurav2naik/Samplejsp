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

public class AndroidLive {
	public static DB db;
	static {
		db = CommonDB.getBankConnection();
	}

//public static void main(String[] args) {
	

	public TreeMap<Long, String> getResponseTimesForScatterGraph(String startTime,
			String endTime, String sourceEndpointInp, String targetEndpointInp) {
		DBCursor alertData = null;
		DBObject exectime = null;
		TreeMap<Long, String> finalmap = new TreeMap<Long, String>();
		try {
			
			
			
			//3.select the collection
			DBCollection coll=db.getCollection("Regular");
			//System.out.println("coll name"+coll.getName());
			
			BasicDBObject findObj = new BasicDBObject();
			alertData = coll.find(findObj).sort(exectime);
			alertData.sort(new BasicDBObject("_id", -1));
	
			alertData.limit(40);
			List<DBObject> dbObjs = alertData.toArray();

			for (int i = dbObjs.size() - 1; i >= 0; i--)

			{
				DBObject txnDataObject = dbObjs.get(i);
			
				String act = (String) txnDataObject.get("acitvity_name");
				long respX = (Long)txnDataObject.get("response_time");
			
				long durY = (Long) txnDataObject.get("duration");
				
				
				finalmap.put(respX, act + "_" + durY);
				
				//System.out.println("FINAL"+finalmap);
				
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
			//logger.error("Unexpected error", e);
		} 
		finally 
		{
			alertData.close();
		}
		return finalmap;
	}

}