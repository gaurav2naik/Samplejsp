package com.avekshaa.cis.engine;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.avekshaa.cis.engine.MapData;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GetChartData {

	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}

	public static DB db1;
	public static DB db2;
	static {
		db1 = CommonDB.getConnection();
		db2 = CommonDB.getBankConnection();
//		System.out.println(db1.getName());
	}

	/*
	 * public static DB db; static { db = CommonDB.getConnection(); Mongo mm =
	 * new Mongo("127.0.0.1", 27017);
	 * 
	 * // 2.connect to your DB DB db = mm.getDB("AndroidData");
	 * 
	 * }
	 */
	// public static void main(String[] args) {

	public String GenerateJSonChartDataYearWisePassPercentage(String jsonp)
			throws JSONException {

		JSONObject finalGEOJSonObj = new JSONObject();
		JSONObject THresholdData = new JSONObject();
		JSONArray datarr = new JSONArray();
		JSONArray thresholdfinal = new JSONArray();
		JSONArray finalJSONarray = new JSONArray();
		JSONObject finalJSON = new JSONObject();
		MapData cd;
		// Integer res=null;

		DBCursor alertData = null;
		DBCursor alertData1 = null;

		try {
			// DB db = COmmonDB.getConnection();
			/*
			 * Mongo mm = new Mongo("52.24.170.28", 27017);
			 * 
			 * // 2.connect to your DB DB db = mm.getDB("AndroidData");
			 */

			DBCollection cisresponse = db.getCollection("usage");
			BasicDBObject findObj = new BasicDBObject();

			DBCollection threshold = db1.getCollection("ThresholdDB");
			// System.out.println("IN threshold DAO"+coll.getName());

			// fetch name
			BasicDBObject findObj1 = new BasicDBObject();
			alertData1 = threshold.find(findObj1);
			alertData1.sort(new BasicDBObject("_id", -1));

			alertData1.limit(1);
			List<DBObject> thresholddbObjs = alertData1.toArray();
			// System.out.println(thresholddbObjs);
			/*
			 * for (int i = thresholddbObjs.size() - 1; i >= 0; i--)
			 * 
			 * {
			 */if (!thresholddbObjs.isEmpty()) {
				DBObject txnDataObject = thresholddbObjs.get(thresholddbObjs
						.size() - 1);
				Integer threshold11 = (Integer) txnDataObject
						.get("Android_threshold");
				// System.out.println("Thresolrtyd "+threshold11);
				Double yellow = 0.70 * threshold11;

				JSONObject thresholdgreen = new JSONObject();
				// JSONArray thresholdgreenArray =new JSONArray();
				JSONObject thresholdyellow = new JSONObject();
				// JSONArray thresholdyellowArray =new JSONArray();
				JSONObject thresholdred = new JSONObject();
				// JSONArray thresholdredArray =new JSONArray();

				thresholdgreen.put("color", "#008000");
				thresholdgreen.put("to", yellow);
				thresholdgreen.put("from", 0);
				// thresholdgreenArray.put(thresholdgreen);
				thresholdyellow.put("color", "#FFFF00");
				thresholdyellow.put("to", threshold11);
				thresholdyellow.put("from", yellow);
				// thresholdyellowArray.put(thresholdyellow);
				thresholdred.put("color", "#FF0000");
				thresholdred.put("from", threshold11);
				// thresholdredArray.put(thresholdred);
				thresholdfinal.put(thresholdgreen);
				thresholdfinal.put(thresholdyellow);
				thresholdfinal.put(thresholdred);
				// System.out.println(thresholdgreenArray);
				// System.out.println(thresholdyellowArray);
				// System.out.println(thresholdredArray);
				// System.out.println("FINAL THRESHOLD"+thresholdfinal);

				// }
				// System.out.println("Thresold "+res);

				alertData = cisresponse.find(findObj);
				alertData.sort(new BasicDBObject("_id", -1));

				List<DBObject> dbObjs = alertData.toArray();
				String data = null;
				DBObject dbo = dbObjs.get(0);// -----------------

				ArrayList<String> codelist = new ArrayList<String>();// code
				ArrayList<Object> avglist = new ArrayList<Object>();// avg

				for (String key : dbo.keySet()) {
					// System.out.println( "key: " + key + " value:" + dbo.get(
					// key ) );

					// STORE KEY IN LIST.....

					codelist.add(key);
					avglist.add(dbo.get(key));

					// format->'samsung'

				}

				// System.out.println("HIII"+codelist+""+avglist);

				for (int i = 1; i < codelist.size(); i++) {

					JSONObject dataspecific = new JSONObject();

					// sb.append("{name: '"+codelist.get(i)+"',data: ["+avglist.get(i)+"], stack: '"+codelist.get(i)+"'},");
					// //System.out.println("build"+sb);

					cd = new MapData();
					cd.setCode(codelist.get(i));

					/*
					 * Double d=Double.parseDouble((String)avglist.get(i));
					 * cd.setavg(d);
					 */
					cd.setavg((Double) avglist.get(i));
					dataspecific.put("code", cd.getCode());
					dataspecific.put("value", cd.getavg());
					datarr.put(dataspecific);

				}
			} else
				System.out.println("ThresholdDB is null");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (alertData != null)
				alertData.close();
			if (alertData1 != null)
				alertData1.close();
		}

		try {
			THresholdData.put("dataClasses", thresholdfinal);
			finalGEOJSonObj.put("GeoData", datarr);
			finalJSONarray.put(THresholdData);
			finalJSONarray.put(finalGEOJSonObj);
			finalJSON.put("finalGEO", finalJSONarray);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tempStr = jsonp + "(" + finalJSON.toString() + ")";
		// System.out.println(tempStr);
		// System.out.println(finalJSON.toString());
		// return tempStr;
		// String tempStr=jsonp+"("+finalJSonObj.toString()+")";
		// System.out.println("map data   "+ tempStr);
		return tempStr;
	}

	public String getMapData(String type, int numberOfDay) {
		String web = "web";
		String app = "app";
		String returnString = "";
		StringBuilder sb = new StringBuilder();

		long millisInDay = 60 * 60 * 24 * 1000;
		long currentTime = System.currentTimeMillis();
		long dateOnly = ((currentTime / millisInDay) * millisInDay) - 330 * 60 * 1000;
		DBObject findObj = new BasicDBObject("time", new BasicDBObject("$gt",
				dateOnly));
		DecimalFormat formatter = new DecimalFormat("#0.00");
		Map<String, Double> stateCodeAndSum = null;
		Map<String, Double> stateCodeAndCount = null;
		stateCodeAndSum = new HashMap<String, Double>();
		stateCodeAndCount = new HashMap<String, Double>();
		if (type.equals(app)&&numberOfDay==1) {
			System.out.println("app data");
			DBCollection OneHourAvgForAppMap = db2
					.getCollection("OneHourAvgForAppMap");
			DBCursor appCursor = OneHourAvgForAppMap.find(findObj);
			while (appCursor.hasNext()) {
				DBObject obj = appCursor.next();
				for (String key : obj.keySet()) {
					if (!key.equals("_id") && !key.startsWith("time")) {
						DBObject subObj = (DBObject) obj.get(key);
						double count = Double.parseDouble(subObj.get(
								"AppTotalCount").toString());
						double sum = Double.parseDouble(subObj.get(
								"AppTotalSum").toString());
						System.out.println(key + " :: " + sum + " :: " + count);
						if (stateCodeAndSum != null) {
							if (stateCodeAndSum.containsKey(key)) {
								double sumOfResponse = stateCodeAndSum.get(key)
										+ sum;
								stateCodeAndSum.put(key, sumOfResponse);
							} else {
								stateCodeAndSum.put(key, sum);
							}
						}
						// sum of count
						if (stateCodeAndCount != null) {
							if (stateCodeAndCount.containsKey(key)) {
								double sumOfCount = stateCodeAndCount.get(key)
										+ count;
								stateCodeAndCount.put(key, sumOfCount);
							} else {
								stateCodeAndCount.put(key, count);
							}
						}
					}
				}
			}// end of while
		}// end of if
		else if(type.equals(web)&&numberOfDay==1) {
			System.out.println("Web data");
			DBCollection OneHourAvgForAppMap = db1
					.getCollection("OneHourAvgForWebMap");
			DBCursor appCursor = OneHourAvgForAppMap.find(findObj);
			while (appCursor.hasNext()) {
				DBObject obj = appCursor.next();
				for (String key : obj.keySet()) {
					if (!key.equals("_id") && !key.startsWith("time")) {
						DBObject subObj = (DBObject) obj.get(key);
						double count = Double.parseDouble(subObj.get(
								"WebTotalCount").toString());
						double sum = Double.parseDouble(subObj.get(
								"WebTotalSum").toString());
						System.out.println(key + " :: " + sum + " :: " + count);
						if (stateCodeAndSum != null) {
							if (stateCodeAndSum.containsKey(key)) {
								double sumOfResponse = stateCodeAndSum.get(key)
										+ sum;
								stateCodeAndSum.put(key, sumOfResponse);
							} else {
								stateCodeAndSum.put(key, sum);
							}
						}
						// sum of count
						if (stateCodeAndCount != null) {
							if (stateCodeAndCount.containsKey(key)) {
								double sumOfCount = stateCodeAndCount.get(key)
										+ count;
								stateCodeAndCount.put(key, sumOfCount);
							} else {
								stateCodeAndCount.put(key, count);
							}
						}
					}
				}
			}// end of while
		}// end of else if
		else if(type.equals(app)&& numberOfDay > 6){
			System.out.println("app 7 or 30 day data");
			DBCollection OneHourAvgForAppMap = db2
					.getCollection("AppOneDayAvgForMap");
			DBObject sort = new BasicDBObject("_id",-1);
			DBCursor appCursor = OneHourAvgForAppMap.find().sort(sort).limit(numberOfDay);
			while (appCursor.hasNext()) {
				DBObject obj = appCursor.next();
				for (String key : obj.keySet()) {
					if (!key.equals("_id") && !key.startsWith("time")) {
						DBObject subObj = (DBObject) obj.get(key);
						double count = Double.parseDouble(subObj.get(
								"AppOneDayCount").toString());
						double sum = Double.parseDouble(subObj.get(
								"AppOneDaySum").toString());
						System.out.println(key + " :: " + sum + " :: " + count);
						if (stateCodeAndSum != null) {
							if (stateCodeAndSum.containsKey(key)) {
								double sumOfResponse = stateCodeAndSum.get(key)
										+ sum;
								stateCodeAndSum.put(key, sumOfResponse);
							} else {
								stateCodeAndSum.put(key, sum);
							}
						}
						// sum of count
						if (stateCodeAndCount != null) {
							if (stateCodeAndCount.containsKey(key)) {
								double sumOfCount = stateCodeAndCount.get(key)
										+ count;
								stateCodeAndCount.put(key, sumOfCount);
							} else {
								stateCodeAndCount.put(key, count);
							}
						}
					}
				}
			}// end of while
		}
		else if(type.equals(web)&&numberOfDay > 6){
			System.out.println("Web 7 or 30 day data");
			DBCollection OneHourAvgForAppMap = db1
					.getCollection("WebOneDayAvgForMap");
			DBCursor appCursor = OneHourAvgForAppMap.find(findObj);
			while (appCursor.hasNext()) {
				DBObject obj = appCursor.next();
				for (String key : obj.keySet()) {
					if (!key.equals("_id") && !key.startsWith("time")) {
						DBObject subObj = (DBObject) obj.get(key);
						double count = Double.parseDouble(subObj.get(
								"WebOneDayCount").toString());
						double sum = Double.parseDouble(subObj.get(
								"WebOneDaySum").toString());
						System.out.println(key + " :: " + sum + " :: " + count);
						if (stateCodeAndSum != null) {
							if (stateCodeAndSum.containsKey(key)) {
								double sumOfResponse = stateCodeAndSum.get(key)
										+ sum;
								stateCodeAndSum.put(key, sumOfResponse);
							} else {
								stateCodeAndSum.put(key, sum);
							}
						}
						// sum of count
						if (stateCodeAndCount != null) {
							if (stateCodeAndCount.containsKey(key)) {
								double sumOfCount = stateCodeAndCount.get(key)
										+ count;
								stateCodeAndCount.put(key, sumOfCount);
							} else {
								stateCodeAndCount.put(key, count);
							}
						}
					}
				}
			}// end of while
		}
		
			// Map formate data
		Set<String> keys = stateCodeAndSum.keySet();
		for (String key : keys) {
			double sum = stateCodeAndSum.get(key);
			double count = stateCodeAndCount.get(key);
			double stateOneDayAvg = Double.parseDouble(formatter.format(sum
					/ count));
			// sb.append("{\"hc-key\" : \""+key+"\",\"value\" : \""+stateOneDayAvg+"\"},");
			sb.append("{'hc-key' : '" + key + "','value' : '" + stateOneDayAvg
					+ "'},");
		}

		returnString = sb.toString();
		//System.out.println(returnString);
		return returnString;
	}

	public static void main(String[] args) {
		GetChartData g = new GetChartData();
		System.out.println(g.getMapData("app",7));
	}
}
