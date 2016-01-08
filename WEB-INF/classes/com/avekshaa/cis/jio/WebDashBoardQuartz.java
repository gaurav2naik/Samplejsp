package com.avekshaa.cis.jio;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.database.CommonDB;
import com.avekshaa.cis.quartzjob.MapCode;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

public class WebDashBoardQuartz implements Job {
	static DB db;
	static {
		db = CommonDB.getConnection();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		System.out.println("In side WebDashBoardQuartz");
		long startTime = System.currentTimeMillis();
		long endTime = startTime - (60*60*1000);
		int OneHourTotalCount = 0;
		int OneHourErrorCount = 0;
		double OneHourTotalSum = 0d;
		double OneHourAvg = 0d;

		DBCollection CISResponse = db.getCollection("CISResponse");
		DBCollection oneHourWebAvg = db.getCollection("OneHourWebAvg");

		// match obj
		DBObject match = new BasicDBObject("$match", new BasicDBObject(
				"exectime", new BasicDBObject("$gte", endTime)));
		DBObject group = new BasicDBObject("$group", new BasicDBObject("_id",
				"").append("OneHourTotalSum",
				new BasicDBObject("$sum", "$response_time")).append(
				"OneHourTotalcount", new BasicDBObject("$sum", 1)));
		AggregationOutput output1 = CISResponse.aggregate(match, group);
		System.out.println("output" + output1.toString());

		BasicDBObject innerdoc = new BasicDBObject();
		BasicDBObject doc = new BasicDBObject();
		boolean dataFlag=true;
			for (DBObject results1 : output1.results()) {
				dataFlag=false;
				System.out.println("hhhhhhhh");
				OneHourTotalCount = Integer.parseInt(results1.get(
						"OneHourTotalcount").toString());
				OneHourTotalSum = Double.valueOf(results1
						.get("OneHourTotalSum").toString());

				if (OneHourTotalCount != 0)
					OneHourAvg = OneHourTotalSum / OneHourTotalCount;
				System.out.println("OneDayTotalSum " + OneHourTotalSum + " ::"
						+ " OneDayTotalcount :" + OneHourTotalCount
						+ ":: OneDayAvg :" + OneHourAvg);

				innerdoc.put("OneHourTotalSum", OneHourTotalSum);
				innerdoc.put("OneHourTotalcount", OneHourTotalCount);
				innerdoc.put("OneHourAvg", OneHourAvg);
				doc.put("time", new Date().getTime());
				doc.put("OneHourAvgResponseTime", innerdoc);

				// ------------------------------OneHourHits--------------------------------------//
				doc.put("OneHourHits", OneHourTotalCount);

				// ------------------------------OneHourErrorCount--------------------------------------//
				DBObject errorSearch = new BasicDBObject();
				errorSearch.put("exectime", new BasicDBObject("$gte", endTime));
				errorSearch.put("status_Code", new BasicDBObject("$gt", 399));
				OneHourErrorCount = CISResponse.find(errorSearch).count();
				doc.put("OneHourErrorCount", OneHourErrorCount);

				// --------------------OneHourAvgResponseTimeForMap----------------------//

				BasicDBObject document = new BasicDBObject();
				BasicDBObject innerdocument = new BasicDBObject();
				DBObject match11 = new BasicDBObject("$match",
						new BasicDBObject("exectime", new BasicDBObject("$gt",
								endTime)));
				DBObject group11 = new BasicDBObject("$group",
						new BasicDBObject("_id", "$State")
								.append("AvgResponseTime",
										new BasicDBObject("$avg",
												"$response_time"))
								.append("TotalCount",
										new BasicDBObject("$sum", 1))
								.append("TotalSum",
										new BasicDBObject("$sum",
												"$response_time")));

				AggregationOutput mapoutput11 = CISResponse.aggregate(match11,
						group11);
				boolean flagIfOutputNull = false;
				for (DBObject results11 : mapoutput11.results()) {
					flagIfOutputNull = true;
					int TotalCount = Integer.parseInt(results11.get(
							"TotalCount").toString());
					Double TotalSum = Double.valueOf(results11.get("TotalSum")
							.toString());
					String stateName = results11.get("_id").toString();
					String stateCode = MapCode.GetStateCode(stateName);
					if (!stateCode.startsWith("INVA")) {
						double avgResponseTime = Double.parseDouble(results11
								.get("AvgResponseTime").toString());
						System.out.println("one Day AvgResponseTime forMAp : "
								+ stateName + "->" + stateCode + " ->"
								+ avgResponseTime);
						System.out.println("Total Count:" + TotalCount
								+ " :: TotalSum :" + TotalSum);
						innerdocument.put("OneHouravg", avgResponseTime);
						innerdocument.put("OneHourSum", TotalSum);
						innerdocument.put("OneHourCount", TotalCount);
						document.put(stateCode, innerdocument);
					}

				}
				if (flagIfOutputNull)
					doc.put("OneHourAvgResponseForMap", document);
				else {
					System.out.println("no data found:JIOMAp Schedular");
				}

				 oneHourWebAvg.insert(doc);
				System.out.println("doc : " + doc);
			}
		if(dataFlag){
			innerdoc.put("OneHourTotalSum", OneHourTotalSum);
			innerdoc.put("OneHourTotalcount", OneHourTotalCount);
			innerdoc.put("OneHourAvg", OneHourAvg);
			doc.put("time", new Date().getTime());
			doc.put("OneHourAvgResponseTime", innerdoc);
			doc.put("OneHourErrorCount", OneHourErrorCount);
			doc.put("OneHourHits", OneHourTotalCount);
			oneHourWebAvg.insert(doc);
			System.out.println("inside else doc :"+doc);
		}

	}

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		new WebDashBoardQuartz().execute(null);
	}

}
