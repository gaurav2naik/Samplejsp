package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.util.List;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.commonutil.Mail;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class AvgResponsePerMinWeb implements Job {

	static final Logger logger = Logger.getRootLogger();

	static ConfigurationVo vo = null;
	static Double AvgOfResPerMin = 0d;
	static long beforetime = 0l;
	static long now = 0l;
	public static DBObject userMail1 = null;
	public static String email;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}
	}
	public static DB db;
	
	static {
		db = CommonDB.getConnection();
		
		setMail();
	}

	public AvgResponsePerMinWeb() {

	}
//public static void main(String[] args) {
	

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		
		now = System.currentTimeMillis();
		beforetime =now - (60*1000);
		System.out.println("AvgResponsePerMin "
				+ Convertor.timeInDefaultFormat(now) + " " + now);
		System.out.println("before time:" + beforetime);
		try {
			
			BasicDBObject doc = new BasicDBObject();
			DBCollection webavgpermin = db.getCollection("WebAvgResponsePerMin");
			
			DBCollection cisResponse = db.getCollection("CISResponse");

			
			DBObject match1 = new BasicDBObject("$match", new BasicDBObject(
					"exectime",
					new BasicDBObject("$gt", beforetime)));
			DBObject group1 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "").append("average1", new BasicDBObject("$avg",
					"$response_time")));
			AggregationOutput output1 = cisResponse.aggregate(match1, group1);
			System.out.println("output" + output1.toString());
			boolean flag=true;
			for (DBObject results1 : output1.results()) {
				flag=false;
				Double avg = Double
						.valueOf(results1.get("average1").toString());
				AvgOfResPerMin = (double) Math.round(avg);
				doc.put("Average", AvgOfResPerMin);
				System.out.println("AvgResponsePerMin:" + AvgOfResPerMin);
				doc.put("Current_Time", System.currentTimeMillis());
				System.out.println("AvgResponsePerMin contents:"
						+ doc.toString());
				webavgpermin.insert(doc);
				//checkAlertStatus();
			}
			if(flag){
				doc.put("Average", AvgOfResPerMin);
				doc.put("Current_Time", System.currentTimeMillis());
				System.out.println("AvgResponsePerMin contents:No data Found"
						+ doc.toString());
				webavgpermin.insert(doc);
			}

		}

		catch (Exception e) {
			System.out.println(e);
		}

	}

	private static void checkAlertStatus() {
		// TODO Auto-generated method stub
		
		DBCollection coll1 =db.getCollection("ThresholdDB");
		System.out.println("collection name avg:" + coll1.getName());

		BasicDBObject findObj = new BasicDBObject();
		DBCursor alertData = coll1.find(findObj);
		alertData.sort(new BasicDBObject("_id", -1));
		alertData.limit(1);// LIMIT-LAST 1 DATA
		List<DBObject> dbObjs = alertData.toArray();
		
		/*for (int i = dbObjs.size() - 1; i > dbObjs.size() - 2; i--)

		{*/
			DBObject txnDataObject = dbObjs.get(0);
			int alertthreshold = (Integer) txnDataObject
					.get("Android_threshold");
			
			if (AvgOfResPerMin > alertthreshold) {

				String msg = "Dear customer <br><br><br><h2 style='color:red'>Alert Message </h2>";
				msg = msg
						+ "Threshold exceeded in Android LIVE RESPONSE between <b> "
						+ Convertor.timeInDefaultFormat(beforetime)
						+ "</b> and  <b> " + Convertor.timeInDefaultFormat(now)
						+ " </b> and Average is: <b>" + AvgOfResPerMin;
						
				msg = msg
						+ "<br><br> <a href='http://cis.avekshaa.com/'>Click here to check</a>'";
				msg = msg
						+ "<br><br>Thanks With Regard<br>  Team , Avekshaa Technology Pvt. Ltd";
				
				Mail mail = new Mail();
				mail.mailer(msg, email);
				// SmsAlerts.sendIncidentText(sms);
				System.out.println("MAIL Sent from Live Response");
			}else{
				System.out.println("AvgResponsePerMin , mail not sent, avg is below Threshold");
			}
		}
//	}

	public static void setMail() {
		userMail1 = db.getCollection("first").findOne();
		email = userMail1.get("Email").toString();
		System.out.println("Email :" + email);
	}
	public static void main(String[] args) throws JobExecutionException {
		new AvgResponsePerMinWeb().execute(null);
	}
}