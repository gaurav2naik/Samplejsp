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
import com.avekshaa.cis.commonutil.Mail;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

;

public class GeoMapAvgResponse implements Job {
	static final Logger logger = Logger.getRootLogger();

	

	static ConfigurationVo vo = null;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}


	public GeoMapAvgResponse() {

	}
/**
	 * This method runs as a Quartz scheduler job and takes in
	 * JobExecutionContext to read context related parameters.
	 * 
	 *
	 */

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		DBCursor alertData=null;
		
		try {
//			String CPU = null;
			
			// ----------------------------------DB
			// CONNCETION---------------------------------------------------------------------
			// 1.connect to mongo// host+port
			
			DBCollection mobReg = db.getCollection("Regular");
			DBCollection insertUsage = db.getCollection("usage");
			
			java.util.List Countrylist = mobReg.distinct("country");
//System.out.println(Countrylist);
			String Countryname = null;
			String Code =null;
			BasicDBObject document = new BasicDBObject();
			for (int i = 0; i < Countrylist.size(); i++) {
				Countryname = Countrylist.get(i).toString();
				
				
				List<Double> myList = new ArrayList<Double>();
				// -------------------------------------------- fetch AVG
				// %--------------------------------------------------------
				
				if((!Countryname.startsWith("GPS not"))||(Countryname.length()==0))
				{
					 Code=MapCode.Code(Countryname);
					 if (!Code.startsWith("INVA"))
					 {
					 
				//	//System.out.println("Country   "+Countryname+"___"+Code);
				BasicDBObject findObj1 = new BasicDBObject("country",	Countryname);
				 alertData = mobReg.find(findObj1);
				//alertData.sort(new BasicDBObject("_id", -1));
				// alertData.limit(10);
				List<DBObject> dbObjs = alertData.toArray();
			//	//System.out.println(dbObjs);
				for (int i1 = 0; i1 < dbObjs.size(); i1++) {
					DBObject txnDataObject = dbObjs.get(i1);

				//	CPU = (String) txnDataObject.get("duration");
					Double d = Double.valueOf(txnDataObject.get("duration").toString());
				//	 //System.out.println("CPU %" + CPU);

					myList.add(d);
					// //System.out.println("------>>.>" + myList);

				}
				

				// ----------------------------------------------------------------------------------------------------------------------
				// sum of avg cpu%
				double sum = 0;

				for (Double i2 : myList) {
					sum += i2;

				}
			//	//System.out.println("sum:" + sum);
			//	//System.out.println(myList);
				double avg1 = (sum / dbObjs.size());
			//	//System.out.println("avgg:" + avg1);
				////System.out.println("-----------------");

				double avg2 = (double) Math.round(avg1);

				// finalMap.put(Device_name, avg2);
				//System.out.println(Countryname + "    " + avg2+"   "+Code);
				
				document.put(Code, avg2);
				
				
				
				}}
			}
			//System.out.println(document);
			insertUsage.insert(document);
			
			// //System.out.println("FINAL MAPl:" + finalMap);
		}

		catch (Exception e)

		{
			e.printStackTrace();
		}
	finally{
	alertData.close();
	}
		
	}

}
