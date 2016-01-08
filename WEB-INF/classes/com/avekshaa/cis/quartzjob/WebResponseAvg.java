package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.util.List;
import java.util.TreeMap;

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
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class WebResponseAvg implements Job {

	static final Logger logger = Logger.getRootLogger();

	static ConfigurationVo vo = null;
	static Double AvgOfCISResponse = 0d;
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

	public WebResponseAvg() {
		// TODO Auto-generated constructor stub
	}

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		 now = System.currentTimeMillis();
		// System.out.println("current time 11" + now);
		System.out.println("AVERAGE CALCULATION OF  WEB per min called"
				+ Convertor.timeInDefaultFormat(now));

		 beforetime = now - 60*1000;
		// //System.out.println("AVERAGE CALCULTION CALLED");
		try {

			Mongo m = CommonDB.generalConnection();
			
			BasicDBObject doc = new BasicDBObject();
			DBCollection webavg = db.getCollection("WEB_LIVE_AVG");
			DBCollection regular = db.getCollection("CISResponse");

			BasicDBObject duartion = new BasicDBObject();
			duartion.put("exectime",
					new BasicDBObject("$gt", beforetime));
			BasicDBObject groupFields = new BasicDBObject("_id", "");
			groupFields.put("averageresponse", new BasicDBObject("$avg",
					"$response_time"));

			DBObject group = new BasicDBObject("$group", groupFields);
			DBObject project = new BasicDBObject("$match", duartion);

			AggregationOutput output = regular.aggregate(project, group);
			// DBObject b = output.results();
			boolean flag=true;
			for (DBObject result : output.results()) {
				System.out.println("inside for loop");
				if (!"Unknown".equals(result.get("_id"))) {
					if (!(result.get("_id").equals(null))) {
						flag=false;
						
						Double avg1 = (Double) result.get("averageresponse");
						 AvgOfCISResponse = (double) Math.round(avg1);
						doc.put("Average", AvgOfCISResponse);
						doc.put("Current_Time", System.currentTimeMillis());
						webavg.insert(doc);
						System.out.println("doc contents :"+doc);
						//checkAlertStatus();

					}
				}

			}
			if(flag){
				doc.put("Average", AvgOfCISResponse);
				doc.put("Current_Time", System.currentTimeMillis());
				webavg.insert(doc);
				System.out.println("WebresponseAvg per min : no data found"+doc.toString());
			}
		}

		catch (Exception e) {
			e.printStackTrace();
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

		for (int i = dbObjs.size() - 1; i > dbObjs.size() - 2; i--)

		{
			DBObject txnDataObject = dbObjs.get(i);
			int alertthreshold = 50/*(Integer) txnDataObject
					.get("Web_threshold")*/;
			
			if (AvgOfCISResponse > alertthreshold) {

				String msg = "Dear customer <br><br><br><h2 style='color:red'>Alert Message </h2>";
				msg = msg
						+ "Threshold exceeded in WEB LIVE RESPONSE between <b> "
						+ Convertor.timeInDefaultFormat(beforetime)
						+ "</b> and  <b> " + Convertor.timeInDefaultFormat(now)
						+ " </b> and Average is: <b>" + AvgOfCISResponse;
						
				msg = msg
						+ "<br><br> <a href='http://cis.avekshaa.com/'>Click here to check</a>'";
				msg = msg
						+ "<br><br>Thanks With Regard<br>  Team , Avekshaa Technology Pvt. Ltd";
				
				Mail mail = new Mail();
				mail.mailer(msg, email);
				// SmsAlerts.sendIncidentText(sms);
				System.out.println("MAIL Sent from Live Response");
			}
		}
	}
	public static void setMail() {
		userMail1 = db.getCollection("first").findOne();
		email = userMail1.get("Email").toString();
		System.out.println("Email :" + email);
	}
	public static void main(String[] args) throws JobExecutionException {
		new WebResponseAvg().execute(null);
	}
}