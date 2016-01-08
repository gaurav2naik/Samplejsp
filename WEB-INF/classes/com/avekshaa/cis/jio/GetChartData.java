package com.avekshaa.cis.jio;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.avekshaa.cis.engine.ExceptionDataCalculate;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class GetChartData {
	public static Map<Integer, String> day;
	public static String ctData;
	public static String ThirtyDayCategoryData;
	public static String responseCategoriesData;
	static {
		day = new HashMap<Integer, String>();

		day.put(0, "Sun");
		day.put(1, "Mon");
		day.put(2, "Tue");
		day.put(3, "Wed");
		day.put(4, "Thr");
		day.put(5, "Fri");
		day.put(6, "Sat");
	}

	public String getPieChartData() {
		String data = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection bufferUsage = db.getCollection("PlayerBufferUsage");
		DBObject findObj = new BasicDBObject("avgBufferDuration",
				new BasicDBObject("$lt", 1000));
		DBObject findObj1 = new BasicDBObject("avgBufferDuration",
				new BasicDBObject("$gt", 1000));
		int count = bufferUsage.find(findObj).count();
		int count1 = bufferUsage.find(findObj1).count();
		// DBCursor cur = bufferUsage.find(findObj);
		sb.append("{'name':'<b>Suffering Users</b>','y':" + count1 + "},");// :"+count1+"
		sb.append("{'name':'<b>Happy Users</b>','y':" + count + "},");// :"+count+"</b>

		data = sb.toString();
		// System.out.println(data);
		return data;
	}

	public String getIOSAppVerResponse() {
		String data = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection IOSUsage = db.getCollection("IOSAppVersionResponseUsage");
		DBObject sort = new BasicDBObject("_id", -1);
		DBCursor cur = IOSUsage.find().sort(sort).limit(1);
		while (cur.hasNext()) {
			DBObject obj = cur.next();

			for (String key : obj.keySet()) {
				// System.out.println(key);
				if (!key.equals("_id"))
					sb.append("{\"name\":\""
							+ "<b>App "
							+ key.replace("_", ".")
							+ "</b><br>Avg time :"
							+ obj.get(key)
							+ "<b> ms\",\"y\":"
							+ obj.get(key)
							+ ",\"url\":\"PieChartDetailData.jsp?device=ios&type=app&version="
							+ key.replace("_", ".") + "\"},");
			}
		}

		data = sb.toString();
		data = "[" + data.substring(0, data.length() - 1) + "]";
		// System.out.println("get IOS Ver return "+data);
		return data;
	}

	public String getIOSVersionResponse() {
		String data = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection bufferUsage = db.getCollection("IOSVersionResponseUsage");
		DBObject sort = new BasicDBObject("_id", -1);
		DBCursor cur = bufferUsage.find().sort(sort).limit(1);
		while (cur.hasNext()) {
			DBObject obj = cur.next();
			for (String key : obj.keySet()) {
				if (!key.equals("_id"))
					sb.append("{\"name\":\""
							+ "<b>IOS "
							+ key.replace("_", ".")
							+ " </b><br>Avg Time :"
							+ obj.get(key)
							+ "<b> ms</b>\",\"y\":"
							+ obj.get(key)
							+ ",\"url\":\"PieChartDetailData.jsp?device=ios&type=os&version="
							+ key.replace("_", ".") + "\"},");
			}
		}

		data = sb.toString();
		data = "[" + data.substring(0, data.length() - 1) + "]";
		return data;

	}

	public String getApplicationVersionResponse() {
		String data = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		// System.out.println(db.getName());
		DBCollection bufferUsage = db.getCollection("AppVersionResponseUsage");
		DBObject sort = new BasicDBObject("_id", -1);
		DBCursor cur = bufferUsage.find().sort(sort).limit(1);
		while (cur.hasNext()) {
			DBObject obj = cur.next();

			for (String key : obj.keySet()) {
				// System.out.println(key);
				if (!key.equals("_id"))
					sb.append("{\"name\":\""
							+ "<b>App "
							+ key.replace("_", ".")
							+ "</b><br>Avg Response Time :"
							+ obj.get(key)
							+ "<b> ms\",\"y\":"
							+ obj.get(key)
							+ ",\"url\":\"PieChartDetailData.jsp?device=android&type=app&version="
							+ key.replace("_", ".") + "\"},");
			}
		}

		data = sb.toString();
		data = "[" + data.substring(0, data.length() - 1) + "]";
		// System.out.println(data);
		return data;
	}

	public String getAndroidVersionResponse() {
		String data = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		// System.out.println(db.getName());
		DBCollection bufferUsage = db
				.getCollection("AndroidVersionResponseUsage");
		DBObject sort = new BasicDBObject("_id", -1);
		DBCursor cur = bufferUsage.find().sort(sort).limit(1);
		while (cur.hasNext()) {
			DBObject obj = cur.next();

			for (String key : obj.keySet()) {
				System.out.println("Android app ver: " + key);
				if (!key.equals("_id"))
					sb.append("{\"name\":\""
							+ "<b>Android "
							+ key.replace("_", ".")
							+ "</b><br>Avg Response Time :"
							+ obj.get(key)
							+ "<b> ms\",\"y\":"
							+ obj.get(key)
							+ ",\"url\":\"PieChartDetailData.jsp?device=android&type=os&version="
							+ key.replace("_", ".") + "\"},");
			}
		}

		data = sb.toString();
		data = "[" + data.substring(0, data.length() - 1) + "]";
		// System.out.println(data);
		return data;
	}

	public String getDataForHits(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		StringBuilder ctsb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection coll = db.getCollection("OneDayAvgOfApp");
		// DBCursor cur = null;
		if (numberOfDay == 1) {

		} else if (numberOfDay >= 7) {
			DBObject sortObj = new BasicDBObject("_id", -1);
			List<DBObject> dataList = coll.find().sort(sortObj)
					.limit(numberOfDay).toArray();
			// while (cur.hasNext()) {
			for (int i = dataList.size() - 1; i >= 0; i--) {
				DBObject obj = dataList.get(i);
				Date d = new Date(Long.parseLong(obj.get("time").toString()));
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				// System.out.println(d);
				// System.out.println(day.get(d.getDay()));
				ctsb.append("'" + day.get(d.getDay()) + "',");
				// System.out.println(obj.get("OneDayAvgResponseTime"));
				// System.out.println(obj.get("OneDayHits"));
				sb.append("{y:" + obj.get("OneDayHits") + ",extra:'" + time
						+ "'},");
				// System.out.println(obj.get("OneDayErrorCount"));
				// System.out.println(obj.get("OneDayAvgResponseForMap"));

			}
		} else if (numberOfDay == 30) {

		}
		returnString = sb.toString();
		ctData = ctsb.toString();
		System.out.println("################  ctData :" + ctData);
		System.out.println("getDataForHits return : " + returnString);
		return returnString;
	}

	public String getAppDataForResponce(int numberOfDay) {
		String returnData = "";
		StringBuilder sb = new StringBuilder();
		StringBuilder categories = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection coll = db.getCollection("OneDayAvgOfApp");
		DBCursor cur = null;
		if (numberOfDay >= 7) {
			DBObject sortObj = new BasicDBObject("_id", -1);
			cur = coll.find().sort(sortObj).limit(numberOfDay);
			List<DBObject> dataList = coll.find().sort(sortObj)
					.limit(numberOfDay).toArray();
			// while (cur.hasNext())
			for (int i = dataList.size() - 1; i >= 0; i--) {
				DBObject obj = dataList.get(i);
				DBObject obj1 = (DBObject) obj.get("OneDayAvgResponseTime");
				double avg = Double.parseDouble(new DecimalFormat("##.##")
						.format(obj1.get("OneDayAvg")));
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				// SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				String timeInDateFormat = Convertor.timeInDefaultFormat(Long
						.parseLong(obj.get("time").toString()));
				categories.append("'" + timeInDateFormat + "',");
				sb.append("{y:" + avg + ",extra:'" + time + "'},");
				// System.out.println(avg);

			}
		} else if (numberOfDay == 30) {
			DBObject sortObj = new BasicDBObject("_id", -1);
			cur = coll.find().sort(sortObj).limit(30);
			while (cur.hasNext()) {
				DBObject obj = cur.next();
				DBObject obj1 = (DBObject) obj.get("OneDayAvgResponseTime");
				double avg = Double.parseDouble(new DecimalFormat("##.##")
						.format(obj1.get("OneDayAvg")));
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				sb.append("{y:" + avg + ",extra:'" + time + "'}");
				// System.out.println(avg);

			}
		}

		returnData = sb.toString();
		System.out.println("getAppDataForResponce return " + returnData);
		return returnData;
	}

	public String getDataForCrash(int numberOfDay) {
		String returnData = "";
		StringBuilder sb = new StringBuilder();
		StringBuilder category = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection coll = db.getCollection("OneDayAvgOfApp");
		// DBCursor cur = null;
		if (numberOfDay >= 7) {
			DBObject sortObj = new BasicDBObject("_id", -1);
			List<DBObject> dataList = coll.find().sort(sortObj)
					.limit(numberOfDay).toArray();
			// while (cur.hasNext()) {
			for (int i = dataList.size() - 1; i >= 0; i--) {
				DBObject obj = dataList.get(i);
				int crashCout = Integer.parseInt(obj.get("OneDayErrorCount")
						.toString());
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				SimpleDateFormat format = new SimpleDateFormat("dd-MM");
				String CategoryTime = format.format(Long.parseLong(obj.get(
						"time").toString()));
				sb.append("{y:" + crashCout + ",extra:'" + time + "'},");
				// System.out.println(crashCout);
				category.append("'" + CategoryTime + "',");
			}
		} else if (numberOfDay == 30) {

		}
		ThirtyDayCategoryData = category.toString();
		returnData = sb.toString();
		System.out.println("getDataForCrash return : " + returnData);
		return returnData;
	}

	public String getDataForMap(int numberOfDay) {
		String returnData = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getBankConnection();
		DBCollection coll = db.getCollection("OneDayAvgOfApp");
		DBCursor cur = null;
		if (numberOfDay == 7) {
			DBObject sortObj = new BasicDBObject("_id", -1);
			cur = coll.find().sort(sortObj).limit(7);
			while (cur.hasNext()) {
				DBObject obj = cur.next();
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				DBObject obj1 = (DBObject) obj.get("OneDayAvgResponseForMap");

				// System.out.println(obj1);
				for (String key : obj1.keySet()) {
					// System.out.println(key);
					DBObject keyObj = (DBObject) obj1.get(key);
					// System.out.println(keyObj.get("OneDayavg"));
					double avg = Double.parseDouble(new DecimalFormat("##.##")
							.format(keyObj.get("OneDayavg")));
					sb.append("{\"hc-key\" : \"" + key + "\",\"value\" : \""
							+ avg + "\"},");
				}

			}
		} else if (numberOfDay == 30) {

		}

		returnData = sb.toString();
		// System.out.println(returnData);
		return returnData;
	}

	public String getWebResposeData(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getConnection();
		DBCursor cur = null;
		if (numberOfDay == 1) {
			long millisInDay = 60 * 60 * 24 * 1000;
			long currentTime = new Date().getTime();
			long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			DBCollection coll = db.getCollection("OneHourWebAvg");
			// System.out.println(dateOnly);
			DBObject sort = new BasicDBObject("_id", -1);
			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("time", new BasicDBObject("$gt", dateOnly));
			cur = coll.find(findObj1);
			while (cur.hasNext()) {
				DBObject obj = cur.next();
				// System.out.println(Long.parseLong(obj
				// .get("time").toString()));
				String time = Convertor.timeInDefaultFormat(Long.parseLong(obj
						.get("time").toString()));
				// System.out.println(time);
				DBObject obj1 = (DBObject) obj.get("OneHourAvgResponseTime");

				double avg = Double.parseDouble(new DecimalFormat("##.##")
						.format(obj1.get("OneHourAvg")));
				sb.append("{y:" + avg + ",extra:'" + time + "'},");
				// System.out.println(avg);
			}
		}
		if (numberOfDay >= 7) {
			DBCollection coll = db.getCollection("OneDayAvgOfWeb");
			DBObject sort = new BasicDBObject("_id", -1);
			List<DBObject> resultList = coll.find().sort(sort)
					.limit(numberOfDay).toArray();
			// System.out.println(resultList.size());
			for (int i = resultList.size() - 1; i >= 0; i--) {
				DBObject obj = resultList.get(i);
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				// System.out.println(obj.get("OneDayAvgResponseTime"));
				DBObject obj1 = (DBObject) obj.get("OneDayAvgResponseTime");
				double avg = Double.parseDouble(new DecimalFormat("##.##")
						.format(obj1.get("OneDayAvg")));
				// System.out.println(avg);
				sb.append("{y:" + avg + ",extra:'" + time + "'},");
			}
		}

		returnString = sb.toString();
		System.out.println("getWebResposeData return " + returnString);
		return returnString;
	}

	public String getWebHitsData(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getConnection();
		DBCursor cur = null;
		if (numberOfDay == 1) {
			long millisInDay = 60 * 60 * 24 * 1000;
			long currentTime = new Date().getTime();
			long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			DBCollection coll = db.getCollection("OneHourWebAvg");
			// System.out.println(dateOnly);
			// DBObject sort = new BasicDBObject("_id",-1);
			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("time", new BasicDBObject("$gt", dateOnly));
			cur = coll.find(findObj1);
			while (cur.hasNext()) {
				DBObject obj = cur.next();

				String time = Convertor.timeInDefaultFormat(Long.parseLong(obj
						.get("time").toString()));
				int webHits = Integer.parseInt(obj.get("OneHourHits")
						.toString());

				sb.append("{y:" + webHits + ",extra:'" + time + "'},");
				// System.out.println(webHits);
			}
		}
		if (numberOfDay >= 7) {
			DBCollection coll = db.getCollection("OneDayAvgOfWeb");
			DBObject sort = new BasicDBObject("_id", -1);
			List<DBObject> resultList = coll.find().sort(sort)
					.limit(numberOfDay).toArray();
			for (int i = resultList.size() - 1; i >= 0; i--) {
				DBObject obj = resultList.get(i);
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				// System.out.println(obj.get("OneDayAvgResponseTime"));
				int crashCount = Integer.parseInt(obj.get("OneDayHits")
						.toString());

				// System.out.println(avg);
				sb.append("{y:" + crashCount + ",extra:'" + time + "'},");
			}
		}

		returnString = sb.toString();
		System.out.println("getWebHitsData return :" + returnString);
		return returnString;
	}

	public String getWebCrashData(int numberOfDay) {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		DB db = CommonDB.getConnection();
		DBCursor cur = null;
		if (numberOfDay == 1) {
			long millisInDay = 60 * 60 * 24 * 1000;
			long currentTime = new Date().getTime();
			long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
			DBCollection coll = db.getCollection("OneHourWebAvg");
			// System.out.println(dateOnly);
			// DBObject sort = new BasicDBObject("_id",-1);
			BasicDBObject findObj1 = new BasicDBObject();
			findObj1.put("time", new BasicDBObject("$gt", dateOnly));
			cur = coll.find(findObj1);
			while (cur.hasNext()) {
				DBObject obj = cur.next();
				String time = Convertor.timeInDefaultFormat(Long.parseLong(obj
						.get("time").toString()));
				int webCrashCount = Integer.parseInt(obj.get(
						"OneHourErrorCount").toString());

				sb.append("{y:" + webCrashCount + ",extra:'" + time + "'},");
				// System.out.println("webCrashCount "+webCrashCount);
			}
		}
		if (numberOfDay >= 7) {
			DBCollection coll = db.getCollection("OneDayAvgOfWeb");
			DBObject sort = new BasicDBObject("_id", -1);
			List<DBObject> resultList = coll.find().sort(sort)
					.limit(numberOfDay).toArray();
			for (int i = resultList.size() - 1; i >= 0; i--) {
				DBObject obj = resultList.get(i);
				String time = Convertor.timeInDateFormat(Long.parseLong(obj
						.get("time").toString()));
				// System.out.println(obj.get("OneDayAvgResponseTime"));
				int crashCount = Integer.parseInt(obj.get("OneDayErrorCount")
						.toString());

				// System.out.println(avg);
				sb.append("{y:" + crashCount + ",extra:'" + time + "'},");
			}
		}

		returnString = sb.toString();
		System.out.println("getWebCrashData Return : " + returnString);
		return returnString;
	}

	public String getWebAvgResponsePerMin() {
		String returnString = "";
		StringBuilder sb = new StringBuilder();
		long now = System.currentTimeMillis();
		// System.out.println("current time"+now);
		long beforetime = System.currentTimeMillis() - (60 * 60 * 1000);
		DBCursor alertData = null;
		DB db = CommonDB.getConnection();
		System.out.println(db.getName());
		DBCollection coll = db.getCollection("WebAvgResponsePerMin");
		/* DBCollection coll = db.getCollection("WEB_LIVE_AVG"); */
		BasicDBObject findObj1 = new BasicDBObject();
		System.out.println(beforetime);
		findObj1.put("Current_Time", new BasicDBObject("$gt", beforetime));

		alertData = coll.find(findObj1);
		alertData.limit(60); // last 1
		System.out.println("one hour data size:" + alertData.size());
		alertData.sort(new BasicDBObject("_id", -1));
		List<DBObject> dbObjs = alertData.toArray();

		for (int i1 = dbObjs.size() - 1; i1 >= 0; i1--)

		{
			DBObject txnDataObject = dbObjs.get(i1);
			double avg = (Double) txnDataObject.get("Average");

			long curTim = (Long) txnDataObject.get("Current_Time");

			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
			String timeInDateFormat = sdf.format(curTim);

			sb.append("{y:" + avg + ",extra:'" + timeInDateFormat + "'},");
			// System.out.println("FINAL MAPl:" + timeInDateFormat);

		}

		returnString = sb.toString();
		return returnString;
	}

	public static int getDashBoardCircleData(String day) {
		DB db1 = CommonDB.getBankConnection();
		DB db2 = CommonDB.getBankConnection();
		DBCollection col = db1.getCollection("Regular");
		long dateOnly = ExceptionDataCalculate.CalculateDay(day);
		int totalAppHits = col.find().count();
		return 0;

	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(new GetChartData().getWebAvgResponsePerMin());
		/*
		 * long time = System.currentTimeMillis(); Date dd = new Date(time);
		 * System.out.println(dd); System.out.println(day.get(dd.getDay()));
		 */
	}

}
