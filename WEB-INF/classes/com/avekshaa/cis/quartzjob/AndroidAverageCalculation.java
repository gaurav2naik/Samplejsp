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

public class AndroidAverageCalculation implements Job {

	static final Logger logger = Logger.getRootLogger();

	static ConfigurationVo vo = null;
	static Double AvgOfRegular = 0d;
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
	public static DB cisDB;
	static {
		db = CommonDB.getBankConnection();
		cisDB = CommonDB.getConnection();
		setMail();
	}

	public AndroidAverageCalculation() {

	}

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		int count = 0;
		double sum = 0d;
		now = System.currentTimeMillis();
		beforetime = now - (60 * 60 * 1000);
		System.out.println("AVERAGE CALCULATION OF ANDRO "
				+ Convertor.timeInDefaultFormat(now) + " " + now);
		System.out.println("before time:" + beforetime);
		try {

			BasicDBObject doc = new BasicDBObject();
			DBCollection andavg = db.getCollection("ANDROID_LIVE_AVG");
			// TreeMap<String, Double> mobresavg = new TreeMap<String,
			// Double>();
			DBCollection regular = db.getCollection("Regular");

			DBObject match1 = new BasicDBObject("$match", new BasicDBObject(
					"request_time", new BasicDBObject("$gt", beforetime)));
			DBObject group1 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "")
					.append("average1", new BasicDBObject("$avg", "$duration"))
					.append("Totalcount", new BasicDBObject("$sum", 1))
					.append("SumOfDuration",
							new BasicDBObject("$sum", "$duration")));
			AggregationOutput output1 = regular.aggregate(match1, group1);
			System.out.println("output" + output1.toString());
			boolean flag = true;
			for (DBObject results1 : output1.results()) {
				flag = false;
				Double avg = Double
						.valueOf(results1.get("average1").toString());
				AvgOfRegular = (double) Math.round(avg);
				count = Integer.parseInt(results1.get("Totalcount").toString());
				sum = Double.valueOf(results1.get("SumOfDuration").toString());
				System.out.println("AverageOfRegular " + AvgOfRegular);

				doc.put("Average", AvgOfRegular);
				System.out.println("Android average response:" + AvgOfRegular);
				doc.put("Current_Time", System.currentTimeMillis());
				doc.put("Totalcount", count);
				doc.put("SumOfDuration", sum);
				System.out.println("androidavg document contents:"
						+ doc.toString());
				andavg.insert(doc);
				// checkAlertStatus();
			}
			if (flag) {
				AvgOfRegular = 0d;
				doc.put("Average", AvgOfRegular);
				doc.put("Current_Time", System.currentTimeMillis());
				doc.put("Totalcount", count);
				doc.put("SumOfDuration", sum);
				System.out
						.println("inside else, no dataFound" + doc.toString());
				andavg.insert(doc);
			}

		}

		catch (Exception e) {
			System.out.println(e);
		}

	}

	private static void checkAlertStatus() {
		// TODO Auto-generated method stub

		DBCollection coll1 = cisDB.getCollection("ThresholdDB");
		System.out.println("collection name avg:" + coll1.getName());

		BasicDBObject findObj = new BasicDBObject();
		DBCursor alertData = coll1.find(findObj);
		alertData.sort(new BasicDBObject("_id", -1));
		alertData.limit(1);// LIMIT-LAST 1 DATA
		List<DBObject> dbObjs = alertData.toArray();

		/*
		 * for (int i = dbObjs.size() - 1; i > dbObjs.size() - 2; i--)
		 * 
		 * {
		 */
		DBObject txnDataObject = dbObjs.get(0);
		int alertthreshold = (Integer) txnDataObject.get("Android_thresholds");

		if (AvgOfRegular > alertthreshold) {

			String msg = "Dear customer <br><br><br><h2 style='color:red'>Alert Message </h2>";
			msg = msg
					+ "Threshold exceeded in Android LIVE RESPONSE between <b> "
					+ Convertor.timeInDefaultFormat(beforetime)
					+ "</b> and  <b> " + Convertor.timeInDefaultFormat(now)
					+ " </b> and Average is: <b>" + AvgOfRegular;

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

	// }

	public static void setMail() {
		userMail1 = cisDB.getCollection("first").findOne();
		email = userMail1.get("Email").toString();
		System.out.println("Email :" + email);
	}

	public static void main(String[] args) throws JobExecutionException {
		new AndroidAverageCalculation().execute(null);
	}
}