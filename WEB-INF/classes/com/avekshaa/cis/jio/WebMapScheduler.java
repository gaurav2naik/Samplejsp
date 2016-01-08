package com.avekshaa.cis.jio;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.database.CommonDB;
import com.avekshaa.cis.quartzjob.MapCode;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class WebMapScheduler implements Job {
	static ConfigurationVo vo = null;
	public static long todayTime;
	static {
		try {
			vo = Configuration.configure();
			todayTime = System.currentTimeMillis();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("Web Schedule called by quartz");
		DecimalFormat formatter = new DecimalFormat("#0.00");
		long nowTime = System.currentTimeMillis();
		long endTime = nowTime - (1000 * 60 * 60);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowTime1 = sdf.format(nowTime);
		String todayTime1 = sdf.format(todayTime);

		try {
			Date date1 = sdf.parse(nowTime1);
			Date date2 = sdf.parse(todayTime1);
			System.out.println("todayTime1 data format : " + date2
					+ "   nowTime1 data format :" + date1);
			System.out.println("date1 and dat2 are same");
			try {
				DBCollection PlayerColl = db.getCollection("CISResponse");
				DBCollection insertColl = db.getCollection("OneHourAvgForWebMap");

				BasicDBObject document = new BasicDBObject();
				DBObject match1 = new BasicDBObject("$match",
						new BasicDBObject("exectime", new BasicDBObject(
								"$gt", endTime)));
				DBObject group1 = new BasicDBObject("$group",
						new BasicDBObject("_id", "$State").append(
								"TotalCount", new BasicDBObject("$sum", 1))
								.append("TotalSum",
										new BasicDBObject("$sum",
												"$response_time")));
				AggregationOutput output1 = PlayerColl
						.aggregate(match1, group1);
				boolean flagIfOutputNull = false;
				for (DBObject results1 : output1.results()) {
					flagIfOutputNull = true;
					System.out.println("result : " + results1);
					String stateName = results1.get("_id").toString();
					String stateCode = MapCode.GetStateCode(stateName);
					if (!stateCode.startsWith("INVA")) {
						DBObject subObj = new BasicDBObject();
						double TotalCount = Double.parseDouble(results1.get(
								"TotalCount").toString());
						double TotalSum = Double.parseDouble(results1.get(
								"TotalSum").toString());
						double avgWebResponse = Double.parseDouble(formatter
								.format(TotalSum / TotalCount));

						subObj.put("WebTotalCount", TotalCount);
						subObj.put("WebTotalSum", TotalSum);
						subObj.put("WebOneHourAvg", avgWebResponse);

						System.out.println("AverageOfMap for : " + stateName
								+ "->" + stateCode + " ->" + avgWebResponse);
						document.put(stateCode, subObj);
					} else {
						flagIfOutputNull = false;
					}
				}
				if (document.size() > 0)
					flagIfOutputNull = true;
				if (flagIfOutputNull) {
					document.put("time", nowTime);
					System.out.println("in side if" + document);
					// inserting into DB
					insertColl.insert(document);
				} else {
					System.out.println("no data found:Web Map  Schedular");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (date2.compareTo(date1) < 0) {
				Map<String, Double> stateCodeAndSum = new HashMap<String, Double>();
				Map<String, Double> stateCodeAndCount = new HashMap<String, Double>();
				long millisInDay = 60 * 60 * 24 * 1000;
				long currentTime = todayTime;
				long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
				DBObject oneDayFindObj = new BasicDBObject("time",
						new BasicDBObject("$gt", dateOnly));
				DBCollection oneDayColl = db.getCollection("OneHourAvgForWebMap");
				DBCollection WebOneDayAvgForMap = db
						.getCollection("WebOneDayAvgForMap");
				DBCursor cur = oneDayColl.find(oneDayFindObj);
				while (cur.hasNext()) {
					DBObject resultObj = cur.next();
					Set<String> keys = resultObj.keySet();
					for (String key : keys) {
						if (!key.startsWith("time") && !key.startsWith("_id")) {
							DBObject subReslut = (DBObject) resultObj.get(key);
							double totalSum = Double.parseDouble(subReslut.get(
									"WebTotalSum").toString());
							double totalCount = Double.parseDouble(subReslut
									.get("WebTotalCount").toString());
							// sum of response
							if (stateCodeAndSum != null) {
								if (stateCodeAndSum.containsKey(key)) {
									double sumOfResponse = stateCodeAndSum
											.get(key) + totalSum;
									stateCodeAndSum.put(key, sumOfResponse);
								} else {
									stateCodeAndSum.put(key, totalSum);
								}
							}
							// sum of count
							if (stateCodeAndCount != null) {
								if (stateCodeAndCount.containsKey(key)) {
									double sumOfCount = stateCodeAndCount
											.get(key) + totalCount;
									stateCodeAndCount.put(key, sumOfCount);
								} else {
									stateCodeAndCount.put(key, totalCount);
								}
							}

						}
					}
				}
				BasicDBObject oneDayInsertObj = new BasicDBObject();
				Set<String> stateKet = stateCodeAndCount.keySet();
				for (String key : stateKet) {
					DBObject stateData = new BasicDBObject();
					double sum = stateCodeAndSum.get(key);
					double count = stateCodeAndCount.get(key);
					double stateOneDayAvg = Double.parseDouble(formatter
							.format(sum / count));
					stateData.put("WebOneDayCount", count);
					stateData.put("WebOneDaySum", sum);
					stateData.put("WebOneDayAvg", stateOneDayAvg);
					oneDayInsertObj.put(key, stateData);
				}
				if (oneDayInsertObj.size() > 0) {
					oneDayInsertObj.put("time", nowTime);
					WebOneDayAvgForMap.insert(oneDayInsertObj);
					System.out.println("data of one day " + oneDayInsertObj);
				}

				todayTime = nowTime;

			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		WebMapScheduler j = new WebMapScheduler();
		j.execute(null);

	}
}
