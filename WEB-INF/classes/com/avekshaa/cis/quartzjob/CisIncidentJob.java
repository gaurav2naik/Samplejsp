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
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class CisIncidentJob implements Job {
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
		db = CommonDB.getConnection();
	}

	public CisIncidentJob() {

	}

	/**
	 * This method runs as a Quartz scheduler job and takes in
	 * JobExecutionContext to read context related parameters.
	 * 
	 *
	 */
	// public static void main(String[] args) {

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		// //System.out.println("INCIDENT JOB STARTED");
		long now = System.currentTimeMillis();
		// System.out.println("current time 11" + now);
		System.out.println("CISINCIDENT" + Convertor.timeInDefaultFormat(now));

		// Pick data for a given time-window.
		// System.out.println("Incident JOB Called");
		DBCursor alertData = null;
		try {
			// DB db = CommonDB.getConnection();

			DBCollection alertDataCollection = db
					.getCollection("CISIncident_data");

			DBCollection txnDataCollection = db.getCollection("CISResponse");

			// long now = System.currentTimeMillis();
			// System.out.println("TIMEEEEE"+now);

			DBCollection coll1 = db.getCollection("DurationDB");
			// System.out.println("collection name:" + coll1.getName());

			BasicDBObject findObj = new BasicDBObject();
			alertData = coll1.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(1);
			List<DBObject> dbObjs = alertData.toArray();
			System.out.println(dbObjs);

			for (int i = dbObjs.size() - 1; i >= 0; i--)

			{
				DBObject txnDataObject = dbObjs.get(i);

				int inci = (Integer) txnDataObject.get("Incident_Duration");
				System.out.println("Duration of INCIDENT" + inci);

				// //System.out.println("vo is " + vo);
				long beforetime = System.currentTimeMillis() - inci * 1000;

				/*
				 * BasicDBObject gtQuery = new BasicDBObject();
				 * gtQuery.put("status_Code", new BasicDBObject("$gt",
				 * 299).append("$lt", 600)); gtQuery.put("exectime", new
				 * BasicDBObject("$gt", beforetime).append("$lt", now));
				 */
				// //System.out.println("Query   "+cursor);

				double x = 0.0;// total count
				x = txnDataCollection
						.count(new BasicDBObject("exectime", new BasicDBObject(
								"$gt", beforetime).append("$lt", now)));
				System.out.println("total responses:" + x);

				double z;// error count
				z = txnDataCollection.count(new BasicDBObject("status_Code",
						new BasicDBObject("$gt", 299))
						.append("exectime",
								new BasicDBObject("$gt", beforetime).append(
										"$lt", now)));
				System.out.println("error responses" + z);

				double ep;
				ep = (z / x) * 100;
				ep = Math.round(ep * 100);
				ep = ep / 100;

				System.out.println("error percentage:" + ep + "%");
				// //System.out.println("system current time:"+now);

				// create a document and store in CISIncident_data

				// DBCollection alertDataCollection =
				// db.getCollection("CISIncident_data");
				if (ep != 0) {
					BasicDBObject document = new BasicDBObject();
					document.put("error_percentage", ep);
					document.put("system_current_time", now);
					alertDataCollection.insert(document);
					System.out.println("Error percentage inserted");
				} else {
					System.out.println("Error percentage is 0%, error=" + ep);
				}

			}
		}

		catch (Exception e) {
			e.printStackTrace();
			logger.error("Unexpected error", e);
		} finally {
			alertData.close();
		}
	}
}