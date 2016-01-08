package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.commonutil.Mail;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

//import com.mongodb.Mongo;

public class AvgResponseAlerts implements Job{
	static ConfigurationVo vo = null;
	// public static HashMap<String, String> userMail = new
	// HashMap<String,String>();
	public static List<DBObject> userMail = null;
	public static DBObject userMail1 = null;
	public static String email;
	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static DB m;
	static {
		m = CommonDB.getConnection();
		// userMail =m.getCollection("first").find().toArray();
		setMail();
	}

	public AvgResponseAlerts() {

	}
	//public static void main(String[] args) {
		
	

	public void execute(JobExecutionContext context)
			throws JobExecutionException {

		// System.out.println("AVG  called");

		// String currentUser = LoginServlet.getCurrentUser();
		System.out.println("AVG Response called");

		long now = System.currentTimeMillis();
		// System.out.println("current time 11" + now);
		System.out.println(Convertor.timeInDefaultFormat(now));

		// System.out.println("current time 11" + now);
		DBCursor alertData1 = null;
		// -1Hr
		// (60*60*1000)=3600000

		DBCollection coll2 = m.getCollection("DurationDB");
		// System.out.println("collection name:" + coll2.getName());

		BasicDBObject findObj1 = new BasicDBObject();
		alertData1 = coll2.find(findObj1);
		alertData1.sort(new BasicDBObject("_id", -1));
		alertData1.limit(1);
		List<DBObject> dbObjs2 = alertData1.toArray();
		// System.out.println(dbObjs2);

		for (int j = dbObjs2.size() - 1; j >= 0; j--)

		{
			DBObject txnDataObject2 = dbObjs2.get(j);
			int averagealerts = (Integer) txnDataObject2.get("Average_Alerts");
			 System.out.println("DURATION OF LIVE:" + averagealerts);

			long beforetime = System.currentTimeMillis() - averagealerts*1000;

			DBCollection coll = m.getCollection("CISResponse");

			BasicDBObject gtQuery = new BasicDBObject();

			// gtQuery.put("UAID", new BasicDBObject("$eq","app123"));

			gtQuery.put("exectime",
					new BasicDBObject("$gt", beforetime).append("$lt", now)); // within
																				
			BasicDBObject gtQuery1 = new BasicDBObject("response_time", 1)
					.append("_id", 0);

			ArrayList<Integer> list11 = new ArrayList<Integer>();

			DBCursor cursor = coll.find(gtQuery, gtQuery1);
			List<DBObject> list = cursor.toArray();
			// System.out.println("Query sss   " + cursor);
			// System.out.println("AVG LIST"+list);

			for (int i = 0; i < list.size() - 1; i++) {
				DBObject txnDataObject = list.get(i);
				double responseTi = Double.parseDouble(txnDataObject.get(
						"response_time").toString());
				Integer resp = (int) responseTi;

				// System.out.println("Response time:" + resp);
				// //System.out.println("----inside loop");
				list11.add(resp);

			}
			cursor.close();
			// System.out.println("response times:" + list11);

			// find the sum of responses
			int sum = 0;

			for (int i : list11) {
				sum += i;
			}
			 System.out.println("sum of responses:" + sum);

			double x;// total count
			x = coll.count(new BasicDBObject("exectime", new BasicDBObject(
					"$gt", beforetime).append("$lt", now)));
			 System.out.println("Total responses Count:" + x);

			Double avg;
			avg = sum / x;

			avg = (double) Math.round(sum / x);
			System.out.println("Average:" + avg);

			// ------------------------------------<<--FETCH--->>------------------------------------------------------------
			DBCursor alertData = null;

			try {

				// System.out.println("DB Name:" + m.getName());

				// 3.selcet the collection
				DBCollection coll1 = m.getCollection("ThresholdDB");
				 System.out.println("collection name avg:" + coll1.getName());

				BasicDBObject findObj = new BasicDBObject();
				alertData = coll1.find(findObj);
				alertData.sort(new BasicDBObject("_id", -1));
				alertData.limit(1);// LIMIT-LAST 1 DATA
				List<DBObject> dbObjs = alertData.toArray();

				for (int i = dbObjs.size() - 1; i > dbObjs.size() - 2; i--)

				{
					DBObject txnDataObject = dbObjs.get(i);
					int alertthreshold = 1000;/*(Integer) txnDataObject
							.get("Web_threshold");*/
					// System.out.println("THRESHOLD-->" + alertthreshold);
					// System.out.println(avg+"_____"+alertthreshold);

					/*
					 * 
					 * String msg =
					 * "Threshold exceeded in LIVE RESPONSE between " +
					 * beforetime + " and " + now + "and Average is:" + avg;
					 * String email = "monisha.baptist@avekshaa.com";
					 * 
					 * Mail mail = new Mail(); mail.mailer(msg, email);
					 * 
					 * //System.out.println("mail sent from LIVE RESPONSE");
					 */

					// 3000>2--->true
					if (avg > alertthreshold) {

						String msg = "Dear customer <br><br><br><h2 style='color:red'>Alert Message </h2>";
						msg = msg
								+ "Threshold exceeded in WEB LIVE RESPONSE between <b> "
								+ Convertor.timeInDefaultFormat(beforetime)
								+ "</b> and  <b> "
								+ Convertor.timeInDefaultFormat(now)
								+ " </b> and Average is: <b>" + avg
								+ "  </b>Check your CIS Incident";
						msg = msg
								+ "<br><br> <a href='http://cis.avekshaa.com/'>Click here to check</a>'";
						msg = msg
								+ "<br><br>Thanks With Regard<br>  Team , Avekshaa Technology Pvt. Ltd";
						// String email = "pushkar.kumar@avekshaa.com";
						// String email = userMail.get(currentUser);
						/*
						 * String sms
						 * ="Threshold exceeded in LIVE RESPONSE between " +
						 * Convertor.timeInDefaultFormat(beforetime)+ " and " +
						 * Convertor.timeInDefaultFormat(now) +
						 * "and Average is:" + avg+"  Check your CIS Incident";
						 */
						Mail mail = new Mail();
						mail.mailer(msg, email);
						// SmsAlerts.sendIncidentText(sms);
						 System.out.println("MAIL Sent from Live Response");

					}
				}

			}

			catch (Exception e) {
				e.printStackTrace();
				// logger.error("Unexpected error",e);
			} finally {
				alertData.close();
			}

			// create a document and store in AVG colln

			DBCollection coll3 = m.getCollection("AVG");
			BasicDBObject document = new BasicDBObject();
			document.put("avg_response", avg);
			document.put("system_current_time", now);
			// coll3.insert(document);
			// System.out.println("stored..");

		}
		alertData1.close();
	}

	public static void setMail() {
		userMail1 = m.getCollection("first").findOne();
		email = userMail1.get("Email").toString();
		System.out.println("Email :"+email);
	}
}