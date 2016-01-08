package com.avekshaa.cis.jio;

import java.io.IOException;
import java.text.DecimalFormat;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

public class ApplicationVersionBufferScheduler implements Job {
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
		db = CommonDB.getBankConnection();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out
				.println("ApplicationVersionBufferScheduler called by quartz");
		long now = System.currentTimeMillis();
		long beforeTime = now - (3600 * 1000);
		try {
			// DBCollection PlayerColl = db.getCollection("PlayerStateInfo");
			DBCollection RegularColl = db.getCollection("Regular");
			DBCollection insertRegularAve = db
					.getCollection("AppVersionResponseUsage");

			// collections for IOS
			DBCollection IOSDataColl = db.getCollection("IOSData");
			DBCollection IOSInsertUsage = db
					.getCollection("IOSAppVersionResponseUsage");

			BasicDBObject IOSDocument = new BasicDBObject();
			// match and group Object for IOS
			DBObject bufferingMatch = new BasicDBObject("$match",
					new BasicDBObject("request_time", new BasicDBObject("$gt",
							beforeTime)));
			DBObject bufferingGroup = new BasicDBObject("$group",
					new BasicDBObject("_id", "$App_ver").append(
							"IOSAppAvgResponse", new BasicDBObject("$avg",
									"$duration")));

			AggregationOutput output1 = IOSDataColl.aggregate(bufferingMatch,
					bufferingGroup);
			boolean flagIfOutputNull = false;
			for (DBObject results1 : output1.results()) {
				flagIfOutputNull = true;
				String IOSAppVer = results1.get("_id").toString();
				String IOSappVersion = IOSAppVer.replace(".", "_");
				double avgResponse = Double.parseDouble(new DecimalFormat(
						"##.##").format(results1.get("IOSAppAvgResponse")));

				System.out.println("IOSAppAvgResponse for  : " + IOSappVersion
						+ " ->" + avgResponse);

				IOSDocument.put(IOSappVersion, avgResponse);
			}

			if (flagIfOutputNull) {
				IOSInsertUsage.insert(IOSDocument);
				System.out
						.println("IOS App Ver data inserted : " + IOSDocument);
			} else {
				System.out
						.println("no data found:ApplicationVersionBufferSchedular");
			}

			// match and group Object for Response
			BasicDBObject responseDocument = new BasicDBObject();
			DBObject responseMatch = new BasicDBObject("$match",
					new BasicDBObject("request_time", new BasicDBObject("$gt",
							beforeTime)));
			DBObject responseGroup = new BasicDBObject("$group",
					new BasicDBObject("_id", "$App_ver").append(
							"AvgResponseTime", new BasicDBObject("$avg",
									"$duration")));
			AggregationOutput outputOfAvgResponse = RegularColl.aggregate(
					responseMatch, responseGroup);
			boolean flagIfOutputNull1 = false;
			for (DBObject result : outputOfAvgResponse.results()) {
				flagIfOutputNull1 = true;
				String appVer = result.get("_id").toString();
				String appVersion = appVer.replace(".", "_");
				double avgResponse = Double.parseDouble(new DecimalFormat(
						"##.##").format(result.get("AvgResponseTime")));

				System.out.println("App Ver : " + appVersion
						+ "   AvgResponse : " + avgResponse);
				responseDocument.put(appVersion, avgResponse);
			}
			if (flagIfOutputNull1) {
				insertRegularAve.insert(responseDocument);
				System.out.println("Response data inserted : "
						+ responseDocument);
			} else {
				System.out
						.println("no data found:ApplicationVersionBufferSchedular");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		new ApplicationVersionBufferScheduler().execute(null);
	}

}