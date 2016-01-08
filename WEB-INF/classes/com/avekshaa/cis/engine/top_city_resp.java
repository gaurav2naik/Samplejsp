package com.avekshaa.cis.engine;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

public class top_city_resp {
	public String countryTopFivaMaxAvgResponse(int numberOfDay) {

		long millisInDay = 0l;
		long currentTime = 0l;
		long dateOnly = 0l;
		if (numberOfDay == 1) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			System.out.println("App one day cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("App one day cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 7) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			System.out.println("App 7 day cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("App 7 day cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 30) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(System.currentTimeMillis()-(7*24*60*60*1000))));
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(dateOnly)));
		}
		StringBuilder sb = new StringBuilder();
		String rexecandresp = "";
		try {

			DB db = CommonDB.getBankConnection();
			DBCollection regular = db.getCollection("Regular");
			DBObject match = new BasicDBObject("$match", new BasicDBObject(
					"country", "India").append("request_time",
					new BasicDBObject("$gt", dateOnly)));
			DBObject groupFields = new BasicDBObject("_id", "$city");
			groupFields.put("averageresponse", new BasicDBObject("$avg",
					"$duration"));
			DBObject group = new BasicDBObject("$group", groupFields);
			// group.put("$sort", new BasicDBObject("totalhit",-1));
			DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
					"averageresponse", -1));
			DBObject limit = new BasicDBObject("$limit", 5);
			AggregationOutput output = regular.aggregate(match, group, sort,
					limit);

			for (DBObject result : output.results()) {
				String city_name = (String) result.get("_id");
				double city_value = (Double) result.get("averageresponse");
				double fAvg = Double.parseDouble(new DecimalFormat("##.##")
						.format(city_value));
				double negativeFAvg = 0 - fAvg;
				if (!city_name.equals("null"))
					sb.append("{y:" + negativeFAvg + ",extra:'" + city_name
							+ "'},");
				// rexecandresp.put(city_name, city_value);
			}
		} catch (Exception e)

		{
			e.printStackTrace();
		}

		rexecandresp = sb.toString();
		System.out.println("top five cities" + rexecandresp);
		return rexecandresp;

	}

	public String getWebTopCities(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		long millisInDay = 0l;
		long currentTime = 0l;
		long dateOnly = 0l;
		if (numberOfDay == 1) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			System.out.println("~~~~one day cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("~~~~one day cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 7) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			System.out.println("!!!!!!!!!cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("!!!!!!!!!cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 30) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(System.currentTimeMillis()-(7*24*60*60*1000))));
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(dateOnly)));
		}
		DB db = CommonDB.getConnection();
		DBCollection coll = db.getCollection("CISResponse");
		DBObject matchObj = new BasicDBObject("$match", new BasicDBObject(
				"Country", "India").append("exectime", new BasicDBObject("$gt",
				dateOnly)));
		DBObject groupFields = new BasicDBObject("_id", "$City");
		groupFields.put("avgWebResponse", new BasicDBObject("$avg",
				"$response_time"));
		DBObject groupObj = new BasicDBObject("$group", groupFields);
		DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
				"avgWebResponse", -1));
		DBObject limit = new BasicDBObject("$limit", 5);
		AggregationOutput output = coll.aggregate(matchObj, groupObj, sort,
				limit);

		for (DBObject result : output.results()) {
			String city_name = (String) result.get("_id");
			double city_value = (Double) result.get("avgWebResponse");
			double fAvg = Double.parseDouble(new DecimalFormat("##.##")
					.format(city_value));
			sb.append("{y:" + fAvg + ",extra:'" + city_name + "'},");
			// /rexecandresp.put(city_name, city_value);
		}

		returnString = sb.toString();
		System.out.println(returnString);
		return returnString;
	}

	public String getWebTopTenCities(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		long millisInDay = 0l;
		long currentTime = 0l;
		long dateOnly = 0l;
		if (numberOfDay == 1) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			System.out.println("~~~~one day cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("~~~~one day cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 7) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			System.out.println("!!!!!!!!!cuTime : "
					+ new SimpleDateFormat().format(new Date(currentTime)));
			System.out.println("!!!!!!!!!cuTime : "
					+ new SimpleDateFormat().format(new Date(dateOnly)));
		} else if (numberOfDay == 30) {
			millisInDay = 60 * 60 * 24 * 1000;
			currentTime = new Date().getTime();
			dateOnly = (((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000)
					- (7 * 24 * 60 * 60 * 1000);
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(System.currentTimeMillis()-(7*24*60*60*1000))));
			// System.out.println("cuTime : "+new SimpleDateFormat().format(new
			// Date(dateOnly)));
		}
		DB db = CommonDB.getConnection();
		DBCollection coll = db.getCollection("CISResponse");
		DBObject matchObj = new BasicDBObject("$match", new BasicDBObject(
				"Country", "India").append("exectime", new BasicDBObject("$gt",
				dateOnly)));
		DBObject groupFields = new BasicDBObject("_id", "$City");
		groupFields.put("avgWebResponse", new BasicDBObject("$avg",
				"$response_time"));
		DBObject groupObj = new BasicDBObject("$group", groupFields);
		DBObject sort = new BasicDBObject("$sort", new BasicDBObject(
				"avgWebResponse", -1));
		DBObject limit = new BasicDBObject("$limit", 10);
		AggregationOutput output = coll.aggregate(matchObj, groupObj, sort,
				limit);

		for (DBObject result : output.results()) {
			String city_name = (String) result.get("_id");
			double city_value = (Double) result.get("avgWebResponse");
			double fAvg = Double.parseDouble(new DecimalFormat("##.##")
					.format(city_value));
			sb.append("{y:" + fAvg + ",extra:'" + city_name + "'},");
			// /rexecandresp.put(city_name, city_value);
		}

		returnString = sb.toString();
		System.out.println(returnString);
		return returnString;
	}

	public static void main(String[] args) {
		new top_city_resp().getWebTopCities(30);
	}
}
