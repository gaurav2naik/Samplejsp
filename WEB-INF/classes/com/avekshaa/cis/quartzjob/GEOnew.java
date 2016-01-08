package com.avekshaa.cis.quartzjob;

import java.io.IOException;
import java.util.*;

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

public class GEOnew implements Job {
	static final Logger logger = Logger.getRootLogger();

	static ConfigurationVo vo = null;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static DB db1;
	static {
		db1 = CommonDB.AndroidConnection();
	}

	// DB db2 = CommonDB.getConnection();
	// CIS

	public static DB db2;
	static {
		db2 = CommonDB.getConnection();
	}

	public GEOnew() {

	}

	/**
	 * This method runs as a Quartz scheduler job and takes in
	 * JobExecutionContext to read context related parameters.
	 *
	 *
	 */
	// public static void main(String[] args) {

	@SuppressWarnings("rawtypes")
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		long now = System.currentTimeMillis();

		// System.out.println("current time 11" + now);
		System.out.println("GEO CALCULATION"
				+ Convertor.timeInDefaultFormat(now));

		Collection<String> hs1 = new HashSet<String>();
		Collection<String> hs2 = new HashSet<String>();
		DBCursor alertData = null;
		BasicDBObject document = new BasicDBObject();
		DBCollection insertUsage = db1.getCollection("usage");

		try {

			DBCollection collAnd = db1.getCollection("Regular");
			hs1 = collAnd.distinct("country");
			System.out.println("hs1" + hs1);

			DBCollection collWeb = db2.getCollection("CISResponse");
			hs2 = collWeb.distinct("Country");
			System.out.println("hs2" + hs2);

			Collection set3 = new HashSet<String>();
			set3.addAll(hs1);
			set3.addAll(hs2);

			// System.out.println("set3 : " + set3);// union of hs1 & hs2
			String Code = null;
			// iterate though union hashset

			/*
			 * for (Object s : set3) { System.out.println("country:"+s);
			 */
			Iterator iterator1 = set3.iterator();

			// check values
			while (iterator1.hasNext()) {
				Double AvgOfRegular = 0d;
				Double AvgOfCISResponse = 0d;
				String Country = iterator1.next().toString();

				// fetch only response time
				if (!(Country.length() == 0)) {
					if (!(Country.startsWith("GPS"))) {
						if (!(Country.startsWith("Unkn"))) {

							Code = MapCode.Code(Country);
							if (!Code.startsWith("INVA")) {

								List<Double> response = new ArrayList<Double>();
								System.out.println("country:" + Country);
								// Start!!!Query for getting data in avg
								DBObject match1 = new BasicDBObject("$match",
										new BasicDBObject("country", Country));
								DBObject group1 = new BasicDBObject("$group",
										new BasicDBObject("_id", "$country")
												.append("average1",
														new BasicDBObject(
																"$avg",
																"$duration")));
								AggregationOutput output1 = collAnd.aggregate(
										match1, group1);
								for (DBObject results1 : output1.results()) {
									AvgOfRegular = Double.valueOf(results1.get(
											"average1").toString());
									System.out
											.println("AverageOfRegular for Country:"
													+ Country
													+ " ->"
													+ AvgOfRegular);
								}
								Double resp1 = Double.valueOf(AvgOfRegular);
								// end
								if (resp1 != 0d) {
									response.add(resp1);
									System.out
											.println("Adding Response for Regular :"
													+ Country + " " + resp1);
								}
								//
								DBObject match2 = new BasicDBObject("$match",
										new BasicDBObject("Country", Country));
								DBObject group2 = new BasicDBObject(
										"$group",
										new BasicDBObject("_id", "$Country")
												.append("average2",
														new BasicDBObject(
																"$avg",
																"$response_time")));
								AggregationOutput output2 = collWeb.aggregate(
										match2, group2);
								for (DBObject results2 : output2.results()) {
									AvgOfCISResponse = Double.valueOf(results2
											.get("average2").toString());
									System.out
											.println("AverageofCISRespone for Country :"
													+ Country
													+ " ->"
													+ AvgOfCISResponse);
								}

								Double resp2 = Double.valueOf(AvgOfCISResponse);
								if (resp2 != 0d) {
									response.add(resp2);
									System.out
											.println("Adding Response for CISResponse :"
													+ Country + " " + resp2);
								}

								// end
								/*
								 * BasicDBObject query = new BasicDBObject();
								 * query.put("country", Country); alertData =
								 * collAnd.find(query); alertData.sort(new
								 * BasicDBObject("$natural", -1));
								 * 
								 * 
								 * List<DBObject> dbObjs = alertData.toArray();
								 * //System.out.println(dbObjs);
								 * 
								 * for (int i = dbObjs.size() - 1; i >= 0; i--)
								 * 
								 * { DBObject txnDataObject = dbObjs.get(i); //
								 * System
								 * .out.println(txnDataObject.get("duration"
								 * ).toString()); Double resp =
								 * Double.valueOf(txnDataObject
								 * .get("duration").toString());
								 * response.add(resp);
								 * //System.out.println("respp:"+resp);.
								 * 
								 * 
								 * }
								 */

								/*
								 * BasicDBObject cis = new BasicDBObject();
								 * cis.put("Country", Country); alertData =
								 * collWeb.find(cis); alertData.sort(new
								 * BasicDBObject("$natural", -1));
								 * 
								 * List<DBObject> dbObjs1 = alertData.toArray();
								 * 
								 * //System.out.println(dbObjs);
								 * 
								 * for (int i = dbObjs1.size() - 1; i >= 0; i--)
								 * 
								 * { DBObject txnDataObject = dbObjs1.get(i);
								 * double responseTi =
								 * Double.parseDouble(txnDataObject.get(
								 * "response_time").toString()); double
								 * responseTime = (double) responseTi;
								 * response.add(responseTime);
								 * //System.out.println("respp:"+resp); }
								 */

								// System.out.println("----------");

								// System.out.println("respp:"+response);

								// ------
								double sum = 0;

								for (Double i2 : response) {
									sum += i2;

								}
								// System.out.println("sum:" + sum);
								// System.out.println(myList);
								double avg1 = (sum / response.size());
								System.out.println("Total Avg for Country:"
										+ Country + " ->" + avg1);
								System.out.println("-----------------");

								double avg2 = (double) Math.round(avg1);

								// finalMap.put(Device_name, avg2);
								// System.out.println("Country:"+Country +
								// " avg:" + avg2 +" Code "+Code);
								document.put(Code, avg2);

							}

						}
					}
				}

			}
			// insertUsage.insert(document);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("Finally of Geo New");
		}

	}
}