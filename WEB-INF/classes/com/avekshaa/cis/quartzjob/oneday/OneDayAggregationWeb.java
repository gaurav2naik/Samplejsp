package com.avekshaa.cis.quartzjob.oneday;

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
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class OneDayAggregationWeb implements Job {
	public static DB db;
	static {
		db = CommonDB.getConnection();
		
	}
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		System.out.println("OneDayAggregationWeb Called");
		
		long millisInDay = 60 * 60 * 24 * 1000;
		long currentTime = new Date().getTime();
		long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
		
		DBCollection cisResponseColl=db.getCollection("CISResponse");
		DBCollection col=db.getCollection("OneHourWebAvg");
		DBCollection coll=db.getCollection("OneDayAvgOfWeb");
		System.out.println("Date Only: "+dateOnly);
		//--------------------------------------OneDayAvgResponseTime-------------------------------//
		DBObject match1 = new BasicDBObject("$match", new BasicDBObject(
				"time", new BasicDBObject("$gte", dateOnly)));
		
		DBObject group1 = new BasicDBObject("$group", new BasicDBObject(
				"_id", "").append("OneDayTotalSum", new BasicDBObject("$sum",
				"$OneHourAvgResponseTime.OneHourTotalSum")).append("OneDayTotalcount", new BasicDBObject("$sum","$OneHourAvgResponseTime.OneHourTotalcount"))
				.append("OneDayTotalErrorCount", new BasicDBObject("$sum","$OneHourErrorCount")));
		
		AggregationOutput output1 = col.aggregate(match1, group1);
		
		System.out.println("output" + output1.toString());
		for (DBObject results1 : output1.results()) {
			int OneDayTotalCount=Integer.parseInt(results1.get("OneDayTotalcount").toString());
			double OneDayTotalSum=Double.valueOf(results1.get("OneDayTotalSum").toString());
			int OneDayTotalErrorCount=Integer.parseInt(results1.get("OneDayTotalErrorCount").toString());
			double OneDayAvg=0d;
			if(OneDayTotalCount!=0)
			 OneDayAvg = OneDayTotalSum/OneDayTotalCount;
			System.out.println("OneDayTotalSum " + OneDayTotalSum + " ::"+" OneDayTotalcount :"+OneDayTotalCount+":: OneDayAvg :"+OneDayAvg);
	        
			BasicDBObject doc = new BasicDBObject();
			BasicDBObject innerdoc = new BasicDBObject();
			innerdoc.put("OneDayTotalSum", OneDayTotalSum);
			innerdoc.put("OneDayTotalcount", OneDayTotalCount);
			innerdoc.put("OneDayAvg", OneDayAvg);
			doc.put("time",currentTime );
			doc.put("OneDayAvgResponseTime", innerdoc);
			
			//------------------------OneDAyHIts--------------------------------------------------//
			
			doc.put("OneDayHits",OneDayTotalCount);
			//------------------------------OneDayErrorCount--------------------------------------//
			
			doc.put("OneDayErrorCount",OneDayTotalErrorCount);
			
			//------------------------------------OneDayAvgResponseTimeForMap----------------------//
			
			BasicDBObject document = new BasicDBObject();
			BasicDBObject innerdocument = new BasicDBObject();
			DBObject match11 = new BasicDBObject("$match", new BasicDBObject(
					"exectime", new BasicDBObject("$gte", dateOnly)));
			DBObject group11 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "$State").append("TotalCount", new BasicDBObject("$sum",1)).append("TotalSum", new BasicDBObject("$sum","$response_time")));
			
			AggregationOutput output11 = cisResponseColl.aggregate(match11, group11);
			boolean flagIfOutputNull=false;
			for (DBObject results11 : output11.results()) {
				flagIfOutputNull=true;
				int TotalCount=Integer.parseInt(results11.get("TotalCount").toString());
				Double TotalSum=Double.valueOf(results11.get("TotalSum").toString());
				String stateName = results11.get("_id").toString();
				String stateCode = MapCode.GetStateCode(stateName);
				if (!stateCode.startsWith("INVA")) {
					double avgResponseTime=0d;
					if(TotalCount!=0)
					avgResponseTime = TotalSum/TotalCount;
					System.out.println("one Day AvgResponseTime forMAp : " + stateName
							+ "->" + stateCode + " ->" + avgResponseTime);
					System.out.println("Total Count:"+TotalCount+" :: TotalSum :"+TotalSum);
					innerdocument.put("OneDayavg", avgResponseTime);
					innerdocument.put("OneDaySum", TotalSum);
					innerdocument.put("OneDayCount", TotalCount);
					document.put(stateCode, innerdocument);
				}

			}
			if(flagIfOutputNull)
			doc.put("OneDayAvgResponseForMap",document);
			else {
				System.out.println("no data found:JIOMAp Schedular");
			}
			System.out.println("doc : "+doc);
			coll.insert(doc);
			
		}
		
	}
	public static void main(String[] args) throws JobExecutionException {
		new OneDayAggregationWeb().execute(null);
	}
	}


