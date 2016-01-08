package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

public class AndroidAvgCalculation implements Job{
	
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


	public AndroidAvgCalculation(){
		
	}
	public void execute(JobExecutionContext context)
            throws JobExecutionException {
		System.out.println("Device wise Android avg response time :AndroidAvg called");
			//HashMap<String, Double> finalMap = new HashMap<String, Double>();
		DBCursor alertData=null;
		
		long now = System.currentTimeMillis();
		//System.out.println("current time 11" + now);
		System.out.println("DEVICE WISE AVG RESPONSE"+Convertor.timeInDefaultFormat(now));

		try {
			String perc = null;

	//----------------------------------DB CONNCETION---------------------------------------------------------------------
			// 1.connect to mongo// host+port
			
		

			DB db = CommonDB.AndroidConnection();
			 DBCollection regular= db.getCollection("Regular");
			 DBCollection AndroidAvg =db.getCollection("Android_Avg");
			 BasicDBObject doc = new BasicDBObject();
				
				DBObject groupFields = new BasicDBObject( "_id", "$Mobilename");
				groupFields.put("averageresponse", new BasicDBObject( "$avg", "$duration"));
				DBObject group = new BasicDBObject("$group", groupFields);
			//	group.put("$sort", new BasicDBObject("totalhit",-1));
	DBObject sort	= new BasicDBObject("$sort", new BasicDBObject("averageresponse",-1));
	//	DBObject limit = new BasicDBObject("$limit",5);
			AggregationOutput output = regular.aggregate( group ,sort	 );
			
			for (DBObject result : output.results()) {		
			
				
				if (!(result.get("_id").toString().startsWith("generic"))){
						

					double avg1 = (Double)(result.get("averageresponse"));
				

					double avg2 = (double) Math.round(avg1);


					doc.put(result.get("_id").toString(), avg2);
				//finalMap.put(Device_name, avg2);

			}
			////System.out.println("FINAL MAPl:" + finalMap);
		}
		//	System.out.println(doc);
			AndroidAvg.insert(doc);
			
		}

		catch (Exception e)

		{
			e.printStackTrace();
		}
		
	// return finalMap;

}
  }

