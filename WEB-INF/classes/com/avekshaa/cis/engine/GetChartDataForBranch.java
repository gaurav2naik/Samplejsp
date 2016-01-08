package com.avekshaa.cis.engine;

import java.text.DecimalFormat;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class GetChartDataForBranch {
	static DB db = null;
	static {
		db = CommonDB.getConnection();
	}

	public String getTopFiveUsersWithHighestResponse() {
		System.out.println("getTopFiveUsersWithHighestResponse called");
		String data = "";
		StringBuilder sb = new StringBuilder();
		try {

			long time = System.currentTimeMillis();
			long beforetime = time - (60 * 60 * 1000);

			DBCollection cisResponse = db.getCollection("CISResponse");
			// System.out.println("count: " + cisResponse.count());
			DBObject match = new BasicDBObject("$match", new BasicDBObject(
					"exectime", new BasicDBObject("$gt", beforetime)));
			DBObject groupFields = new BasicDBObject("_id", "$IP_Address");
			groupFields.put("averageresponse", new BasicDBObject("$avg",
					"$response_time"));
			DBObject group = new BasicDBObject("$group", groupFields);
			// group.put("$sort", new BasicDBObject("totalhit",-1));
			DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
					"averageresponse", -1));
			DBObject limit = new BasicDBObject("$limit", 5);
			AggregationOutput output = cisResponse.aggregate(match, group,
					sort, limit);

			for (DBObject result : output.results()) {
				String branchUser = (String) result.get("_id");
				double avgResponseTimeForBranchUser = (Double) result
						.get("averageresponse");
				double formattedAvg = Double.parseDouble(new DecimalFormat(
						"##.##").format(avgResponseTimeForBranchUser));
				// System.out.println("User :" + branchUser +
				// " :: Avg Response :"
				// + avgResponseTimeForBranchUser);

				sb.append("{\"name\":\"<b>Users :</b>" + branchUser
						+ "<br><b>Avg Response :</b>" + formattedAvg
						+ "\", \"y\":" + formattedAvg + "},");

			}
		} catch (Exception e)

		{
			e.printStackTrace();
		}

		// DBCursor cur = bufferUsage.find(findObj);

		data = sb.toString();
		data = data.substring(0, data.length() - 1);
		data = "[" + data + "]";
		// System.out.println(data);
		return data;
	}

	// Top five user with highest error
	public String getTopFiveUsersWithHighestError() {
		System.out.println("getTopFiveUsersWithHighestError called");
		String data = "";
		StringBuilder sb = new StringBuilder();
		try {
			long time = System.currentTimeMillis();
			long beforetime = time - (60 * 60 * 1000);

			DBCollection cisResponse = db.getCollection("CISResponse");
			// System.out.println("count: " + cisResponse.count());
			DBObject match = new BasicDBObject("$match", new BasicDBObject(
					"exectime", new BasicDBObject("$gt", beforetime)).append(
					"status_Code", new BasicDBObject("$gt", 399)));
			DBObject groupFields = new BasicDBObject("_id", "$IP_Address");
			groupFields.put("Count", new BasicDBObject("$sum", 1));
			DBObject group = new BasicDBObject("$group", groupFields);
			// group.put("$sort", new BasicDBObject("totalhit",-1));
			DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
					"Count", -1));
			DBObject limit = new BasicDBObject("$limit", 5);
			AggregationOutput output = cisResponse.aggregate(match, group,
					sort, limit);

			for (DBObject result : output.results()) {
				String branchUser = (String) result.get("_id");
				int errorCount = (int) result.get("Count");

				// System.out.println("User :" + branchUser
				// + " :: Total Error Count :" + errorCount);

				sb.append("{\"name\":\"<b>Users :</b>" + branchUser
						+ "<br><b>Error Count :</b>" + errorCount
						+ "\", \"y\":" + errorCount + "},");

			}
		} catch (Exception e)

		{
			e.printStackTrace();
		}

		data = sb.toString();
		data = data.substring(0, data.length() - 1);
		data = "[" + data + "]";
		// System.out.println(data);
		return data;
	}

	public String getTopFiveURL() {
		String data = "";
		try {
			DB db = CommonDB.getConnection();
			long time = System.currentTimeMillis();
			long beforetime = time - (60 * 60 * 1000);

			StringBuilder sb = new StringBuilder();
			DBCollection cisResponse = db.getCollection("CISResponse");
			DBObject match = new BasicDBObject("$match", new BasicDBObject(
					"exectime", new BasicDBObject("$gt", beforetime)));
			DBObject groupFields = new BasicDBObject("_id", "$URI");
			groupFields.put("averageresponse", new BasicDBObject("$avg",
					"$response_time"));
			DBObject group = new BasicDBObject("$group", groupFields);
			// group.put("$sort", new BasicDBObject("totalhit",-1));
			DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
					"averageresponse", -1));
			DBObject limit = new BasicDBObject("$limit", 5);
			AggregationOutput output = cisResponse.aggregate(match, group,
					sort, limit);

			for (DBObject result : output.results()) {
				String URI = (String) result.get("_id");
				double avgResponseTimeOfURI = (Double) result
						.get("averageresponse");
				double formattedAvg = Double.parseDouble(new DecimalFormat(
						"##.##").format(avgResponseTimeOfURI));
				// System.out.println("URI :"+URI+" :: Avg Response :"+avgResponseTimeOfURI);
				sb.append("{y:" + formattedAvg + ",extra:\"" + URI + "\"},");

			}
			data = sb.toString();
		} catch (Exception e)

		{
			e.printStackTrace();
		}
		return data;

	}

	public double getApdexScore() {
		double apdexScore = 0d;
		try {
			DB db = CommonDB.getConnection();
			DBCollection coll = db.getCollection("web_APDEX");
			DBObject sortObj = new BasicDBObject("_id", -1);
			DBCursor cur = coll.find().sort(sortObj).limit(1);
			apdexScore = (double) cur.next().get("Apdex");
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("Apdex Score :" + apdexScore);
		return apdexScore;

	}

	public static void main(String[] args) {
		new GetChartDataForBranch().getTopFiveUsersWithHighestError();
	}
}
