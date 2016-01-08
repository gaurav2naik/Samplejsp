package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

public class UsageCalculation implements Job{

	static final Logger logger = Logger.getRootLogger();
	static ConfigurationVo vo = null;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}
	}

	public UsageCalculation() {

	}

//	public static void main(String[] args) {

		 public void execute(JobExecutionContext context)
		 throws JobExecutionException {
		DBCursor osdata = null;
		DBCursor browserdata = null;

		long now = System.currentTimeMillis();
		// System.out.println("current time 11" + now);
		System.out.println("UsageCalculation Called" + Convertor.timeInDefaultFormat(now));
		try {

			DB db = CommonDB.getConnection();
			// System.out.println(db.getName());
			DBCollection usage = db.getCollection("CISResponse");
			DBCollection insertUsage = db.getCollection("usage");
			BasicDBObject usageDetail = new BasicDBObject();
			BasicDBObject os = new BasicDBObject();
			BasicDBObject browser = new BasicDBObject();
			java.util.List Oslist = usage.distinct("OS");

			System.out.println("Total Browser: " + Oslist.size());
			BasicDBObject findObj = new BasicDBObject();
			osdata = usage.find();
			double totalos = osdata.count();
			System.out.println("TOTAL Response" + totalos);
			for (int i = 0; i < Oslist.size(); i++) {
				findObj = new BasicDBObject();
				osdata = usage.find(findObj);
//				System.out.println("browser :" + Oslist.get(i));

				// //System.out.println("TOTAL Response"+total);
				double oscount;
				oscount = usage.count(new BasicDBObject("OS", Oslist.get(i)));
				double percentage = ((oscount * 100) / totalos);
				percentage = Math.round(percentage * 1000000);
				percentage = percentage / 1000000;

				// //System.out.println("No."+Oslist.get(i)+" is "+oscount+"percentage"+percentage);
				String OSname = (String) Oslist.get(i);
				if (OSname.contains(".")) {
					// //System.out.println(OSname.substring(0,
					// OSname.indexOf(".")));
					// OSname=OSname.substring(0, OSname.indexOf("."));
					OSname = OSname.replace(".", "_");
					// //System.out.println(OSname.replace(".", "_"));
				}
				os.put(OSname, percentage);

			}
			System.out.println("OSLIST" + os);
			java.util.List Browserlist = usage.distinct("Browser");
			System.out.println("Total Browser :" + Browserlist.size());
			browserdata = usage.find(findObj);
			double totalbrowser = browserdata.count();
//			System.out.println("TOTAL Response" + totalbrowser);
			for (int i = 0; i < Browserlist.size(); i++) {
				findObj = new BasicDBObject();
				browserdata = usage.find(findObj);
//				System.out.println("browser :" + Browserlist.get(i));
				double browsercount;
				browsercount = usage.count(new BasicDBObject("Browser",
						Browserlist.get(i)));
				double percentage = ((browsercount * 100) / totalbrowser);
				percentage = Math.round(percentage * 1000000);
				percentage = percentage / 1000000;

//				System.out.println("Total COunt of " + Browserlist.get(i) + " is "
//						+ browsercount + "percentage" + percentage);
				String Browsername = (String) Browserlist.get(i);
//				System.out.println("CHECCCK" + Browserlist.get(i) + "__per_"
//						+ percentage);
				if (Browsername.contains(".")) {
					// System.out.println(OSname.substring(0,
					// OSname.indexOf(".")));
					Browsername = Browsername.replace(".", "_");
//					System.out.println(Browsername.replace(".", "_"));
				}
				browser.put(Browsername, percentage);

			}

			usageDetail.put("OS", os);
			usageDetail.put("Browser", browser);
			usageDetail.put("Time", System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat(
					"dd-MMM-yyyy HH:mm:ss.SSS");
			String timeInDateFormat = sdf.format(System.currentTimeMillis());

			usageDetail.put("TimeinFormat", timeInDateFormat);
			System.out.println("UsageDetail: " + usageDetail);
			insertUsage.insert(usageDetail);

		}

		catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		} finally {
			/*
			 * osdata.close(); browserdata.close();
			 */

		}

	}
}
