package com.avekshaa.cis.quartzjob.oneday;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.sun.org.apache.bcel.internal.generic.NEW;

public class DashBoardQuartz implements Job {

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
	public static MongoClient m;
	static {
		m = CommonDB.generalConnection();
		
	}

	public DashBoardQuartz() {

	}

	// public static void main(String[] args) {

	public void execute(JobExecutionContext context)
			throws JobExecutionException {

		
		long millisInDay = 60 * 60 * 24 * 1000;
		long currentTime = new Date().getTime();
		long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
		long pm=dateOnly+12*60*60*1000;
		long am=dateOnly+11*60*60*1000;
		System.out.println("12 pm :"+new SimpleDateFormat().format(new Date(pm)) +" :"+new SimpleDateFormat().format(new Date(dateOnly)));
		System.out.println("date only:"+dateOnly);
		
		try {
			DB db = m.getDB("CIS");
			DBCollection andavg = db.getCollection("CISResponse");
			// TreeMap<String, Double> mobresavg = new TreeMap<String,
			// Double>();
			//DBCollection regular = db.getCollection("Regular");
			//DBCollection android_live_avg = db.getCollection("ANDROID_LIVE_AVG");

			DBObject match1 = new BasicDBObject("$match", new BasicDBObject(
					"exectime", new BasicDBObject("$gte", am).append("$lte", pm)));
			DBObject group1 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "").append("average1", new BasicDBObject("$sum",
					"$page_size")).append("count", new BasicDBObject("$sum",1)));
			AggregationOutput output1 = andavg.aggregate(match1, group1);
			System.out.println("output" + output1.toString());
			for (DBObject results1 : output1.results()) {
				Double avg=Double.parseDouble((results1.get("average1").toString()));
				System.out.println("count1 " + results1.get("count").toString());
				System.out.println("avg " + avg);
				AvgOfRegular = (double) Math.round(avg);
				System.out.println("AverageOfRegular " + AvgOfRegular);
				BasicDBObject doc = new BasicDBObject();
				doc.put("Average", AvgOfRegular);
				System.out.println("Android average response:" + AvgOfRegular);
				doc.put("Current_Time", System.currentTimeMillis());
				System.out.println("androidavg document contents:"
						+ doc.toString());
				//andavg.insert(doc);
				
			}
			
			//-----------------------------------------------------------------------
			/*DBObject match11 = new BasicDBObject("$match", new BasicDBObject(
					"Current_Time", new BasicDBObject("$gte", dateOnly)));
			DBObject group11 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "").append("average1", new BasicDBObject("$avg",
					"$Average")).append("count", new BasicDBObject("$sum",1)));
			AggregationOutput output11 = android_live_avg.aggregate(match11, group11);
			System.out.println("output" + output11.toString());
			for (DBObject results1 : output11.results()) {
				Double avg = Double
						.valueOf(results1.get("average1").toString());
				AvgOfRegular = avg;
				System.out.println("Average of Average !!!: " + AvgOfRegular);
				System.out.println("count " + results1.get("count").toString());
				BasicDBObject doc = new BasicDBObject();
				doc.put("Average", AvgOfRegular);
				System.out.println("Android average response:" + AvgOfRegular);
				doc.put("Current_Time", System.currentTimeMillis());
				System.out.println("androidavg document contents:"
						+ doc.toString());
				//andavg.insert(doc);
				
			}*/

		}

		catch (Exception e) {
			System.out.println(e);
		}

	}

	public static void main(String[] args) throws JobExecutionException {
		new DashBoardQuartz().execute(null);
	}
}