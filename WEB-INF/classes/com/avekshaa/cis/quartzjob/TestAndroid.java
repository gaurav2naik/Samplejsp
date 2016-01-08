package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public  class TestAndroid  {

	static final Logger logger = Logger.getRootLogger();
	
	static ConfigurationVo vo = null;
	
	static{
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			//e.printStackTrace();
			logger.error("Unexpected error",e);
		}
	}
	public static MongoClient m;
	static {
		try {
			m = new MongoClient("52.24.170.28");
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		
	
		long now = System.currentTimeMillis();
		System.out.println("current time 11" + now);
		System.out.println("AVERAGE CALCULATION OF ANDRO "+Convertor.timeInDefaultFormat(now));
	
        long beforetime = System.currentTimeMillis() - 60000; 
        System.out.println("bef"+beforetime);
        	System.out.println("AVERAGE CALCULTION CALLED");
		
		 
	        try {

	    		DB db = m.getDB("AndroidData");
	    		DBCollection andavg=db.getCollection("ANDROID_LIVE_AVG");
	    		
	    		DBCollection regular= db.getCollection("Regular");
	    	
	    		
	    		 DBObject match1 = new BasicDBObject("$match",
                         new BasicDBObject("request_time", new BasicDBObject("$gt",beforetime).append("$lt", now)));
                 DBObject group1 = new BasicDBObject("$group",
                         new BasicDBObject("_id", "").append(
                                 "average1", new BasicDBObject("$avg",
                                         "$duration")));
                 AggregationOutput output1=regular.aggregate(match1, group1);
                 System.out.println("output"+output1.toString());
                 for (DBObject results1:output1.results())
                 {
                 	 Double AvgOfRegular = Double.valueOf(results1.get("average1").toString());
                     System.out.println("AverageOfRegular "+AvgOfRegular);
                     BasicDBObject doc = new BasicDBObject();
	        		   doc.put("Average",AvgOfRegular);
	        		   System.out.println("Android average response:"+AvgOfRegular);
	       	        doc.put("Current_Time",System.currentTimeMillis());
	       	        System.out.println("androidavg document contents:"+doc.toString());
	       	     andavg.insert(doc);
                 }
	    		//DBObject b = output.results();
	    		
	          }

	        catch (Exception e) {
	            System.out.println(e);
	        }
	        
		
}

	
	
}