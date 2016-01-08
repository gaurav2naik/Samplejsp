package com.avekshaa.cis.Java;

import java.util.TreeMap;

import com.avekshaa.cis.database.CommonDB;
import com.avekshaa.cis.commonutil.Convertor;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class TestAvg {

	public static void main(String[] args) {
		/*long now = System.currentTimeMillis();
		long beforetime = System.currentTimeMillis() - 60000;
		// System.out.println("current time 11" + now);
		System.out.println("Usage" + Convertor.timeInDefaultFormat(now));
		DB db = CommonDB.AndroidConnection();
		DBCollection webavg = db.getCollection("Regular");
		//DBCollection regular = db.getCollection("CISResponse");
		BasicDBObject duartion = new BasicDBObject();
		duartion.put("exectime",	new BasicDBObject("$gt", beforetime).append("$lt", now));
		BasicDBObject groupFields = new BasicDBObject("_id", "$country");
		groupFields.put("TotalHit", new BasicDBObject("$sum",	1));
		DBObject group = new BasicDBObject("$group", groupFields);
		DBObject sort	= new BasicDBObject("$sort", new BasicDBObject("TotalHit",-1));
		DBObject limit = new BasicDBObject("$limit",8);
		//DBObject project = new BasicDBObject("$match", duartion);

		AggregationOutput output = webavg.aggregate( group,sort,limit);

		for (DBObject result : output.results()) {
			//
			if (!"Unknown".equals(result.get("_id"))) {
				if (!"GPS not available !!!".equals(result.get("_id"))) {				
			//	if (!(result.get("_id").equals(null))) {
				if (!"".equals(result.get("_id"))) {
						System.out.println(result);					
				//	BasicDBObject doc = new BasicDBObject();
					//doc.put("Average", (Double) result.get("averageresponse"));
				//	System.out.println((Double) result.get("averageresponse"));
					//doc.put("Current_Time", System.currentTimeMillis());
					//webavg.insert(doc);

				}
			//}
				}
			}
		
		}*/
		
		/*Mongo m =CommonDB.generalConnection();
		DB db = m.getDB("AndroidData");
		DBCollection webavg=db.getCollection("ANDROID_LIVE_AVG");
		TreeMap<String, Double> mobresavg = new TreeMap<String, Double>();
		DBCollection regular= db.getCollection("Regular");
		long now = System.currentTimeMillis();
		long beforetime = System.currentTimeMillis() - 60000;
		
		BasicDBObject  duartion = new BasicDBObject();
		duartion.put("exectime", new BasicDBObject("$gt", beforetime).append("$lt", now));
		BasicDBObject groupFields = new BasicDBObject( "_id", "");
		groupFields.put("averageresponse", new BasicDBObject( "$avg", "$duration"));
	
		
		DBObject group = new BasicDBObject("$group", groupFields);
		DBObject project = new BasicDBObject("$match",duartion);
		
		AggregationOutput output = regular.aggregate(  project,group);
		//DBObject b = output.results();
		
	 for (DBObject result : output.results()) {
if (!"Unknown".equals(result.get("_id")) ){
	        	   if (!(result.get("_id").equals(null)) ){
	        		   BasicDBObject doc = new BasicDBObject();
	        		   doc.put("Average",(Double)result.get("averageresponse"));
	        		   System.out.println((Double)result.get("averageresponse"));
	       	      //  doc.put("Current_Time",System.currentTimeMillis());
	       	     //webavg.insert(doc);
     
	           }}
	           
	        } */
		String s = "1442299776785"; 
		Long l =Long.valueOf(s);
		System.out.println(Convertor.timeInDefaultFormat(l));

	}

		
	}

