package com.avekshaa.cis.engine;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import org.apache.log4j.Logger;
public class MobvsDes {

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}
	static final Logger logger = Logger.getRootLogger();
	public Map mobVsDesk(String startTime, String endTime,	String sourceEndpointInp, String targetEndpointInp) {

		TreeMap<String, Double> map1 = new TreeMap<String, Double>();
		TreeMap<String, Double> map2 = new TreeMap<String, Double>();
		Map<Map, Map> map3 = new HashMap<Map, Map>();
		List<Object> exectimes = new ArrayList<Object>();
		ArrayList<Object> responsetime = new ArrayList<Object>();
		List<Object> Devices = new ArrayList<Object>();
		String Device = null;
		int res_time = 0;
		DBObject exectime = null;
		DBCursor alertData=null;
		try {
			DBCollection cisresponse = db.getCollection("CISResponse");
			
			BasicDBList DeviceType =new BasicDBList();
			BasicDBObject mobile =new BasicDBObject("Device", "Desktop");
			BasicDBObject desktop =new BasicDBObject("Device", "Mobile");
			DeviceType.add(mobile);
			DeviceType.add(desktop);
			BasicDBObject findObj = new BasicDBObject("$or", DeviceType);
			 alertData = cisresponse.find(findObj).sort(exectime);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(50);
			List<DBObject> dbObjs = alertData.toArray();
			////System.out.println(dbObjs);
			for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 50; i--) {
				DBObject txnDataObject = dbObjs.get(i);
				Device = (String) txnDataObject.get("Device");
				double responseTi = Double.parseDouble(txnDataObject.get(
						"response_time").toString());
				res_time = (int) responseTi;
				long exectime1 = (Long) txnDataObject.get("exectime");
				String DtimeInDateFormat1 = Convertor
						.timeInHighChartFormat(exectime1);
		
				exectimes.add(DtimeInDateFormat1);
				responsetime.add(res_time);
				Devices.add(Device);
			

				if (Device.equals("Desktop")) {
					double mobiley;
					String mobilex = DtimeInDateFormat1;
					mobiley = res_time;
					map1.put(mobilex, mobiley);

				}

				else if (Device.equals("Mobile")) {

					double mobiley;
					String mobilex = DtimeInDateFormat1;
					mobiley = res_time;
					map2.put(mobilex, mobiley);
				}
			}
			map3.put(map1, map2);
		}

		catch (Exception e) {
			 ////System.out.println(e);
			 logger.error("Unexpected error",e);
		}
		finally{
			 alertData.close();
		}

		//System.out.println("MAAAAAAAAAAAAAAAAAP3"+map3);
		return map3;
	}

	public Map mobvsdeskCust(String startTime, String endTime,
			String sourceEndpointInp, String targetEndpointInp) {

		// //System.out.println("startTime  IP "+startTime);
		long t1 = Convertor.timeInMilisecond(startTime);
		long t2 = Convertor.timeInMilisecond(endTime);

		List IPS = new ArrayList<Object>();
		DBObject exectime = null;

		TreeMap<String, Double> map1 = new TreeMap<String, Double>();
		TreeMap<String, Double> map2 = new TreeMap<String, Double>();
		Map<Map, Map> map3 = new HashMap<Map, Map>();
		List<Object> exectimes = new ArrayList<Object>();
		ArrayList<Object> responsetime = new ArrayList<Object>();
		List<Object> Devices = new ArrayList<Object>();
		String Device = null;
		Integer res_time = 0;
		DBCursor cursor=null;
		try {

			DBCollection cisresponse = db.getCollection("CISResponse");

BasicDBList DeviceType =new BasicDBList();
BasicDBObject mobile =new BasicDBObject("Device", "Desktop");
BasicDBObject desktop =new BasicDBObject("Device", "Mobile");
DeviceType.add(mobile);
DeviceType.add(desktop);
BasicDBObject gtQuery = new BasicDBObject("$or", DeviceType);

		
			gtQuery.put("exectime",
					new BasicDBObject("$gt", t1).append("$lt", t2));

			 cursor = cisresponse.find(gtQuery).sort(exectime);
			cursor.sort(new BasicDBObject("_id", -1));
			cursor.limit(205);

			List<DBObject> dbObjs = cursor.toArray();

			// //System.out.println("BEFORE LOOOOOOOOP"+dbObjs.size());
			if (dbObjs.size() > 200) {
				for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 200; i--) {

					DBObject txnDataObject = dbObjs.get(i);
					Device = (String) txnDataObject.get("Device");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					res_time = (int) responseTi;
					long exectime1 = (Long) txnDataObject.get("exectime");
					String DtimeInDateFormat1 = Convertor
							.timeInHighChartFormat(exectime1);

					exectimes.add(DtimeInDateFormat1);
					responsetime.add(res_time);
					Devices.add(Device);
					if (Device.equals("Desktop")) {
						double mobiley;
						String mobilex = DtimeInDateFormat1;
						mobiley = res_time;

						map1.put(mobilex, mobiley);

					}

					else if (Device.equals("Mobile")) {

						double mobiley;
						String mobilex = DtimeInDateFormat1;
						mobiley = res_time;

						map2.put(mobilex, mobiley);
						// //System.out.println("---------"+map2);

					}

				}

			} else {
				for (int i = dbObjs.size() - 1; i >= 0; i--) {

					DBObject txnDataObject = dbObjs.get(i);

					// ////System.out.println("txnDataObject"+txnDataObject);
					Device = (String) txnDataObject.get("Device");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					res_time = (int) responseTi;
					// ////System.out.println(res_time);
					long exectime1 = (Long) txnDataObject.get("exectime");

					// ////System.out.println("EXEC TIMKE IN MILIS"+exectime1);

					String DtimeInDateFormat1 = Convertor
							.timeInHighChartFormat(exectime1);
					// ////System.out.println("DtimeInDateFormat1"+DtimeInDateFormat1);
					exectimes.add(DtimeInDateFormat1);
					responsetime.add(res_time);
					Devices.add(Device);
					// ////System.out.println(exectimes.size()+"ffff "+responsetime.size()+" "+dbObjs.size());

					if (Device.equals("Desktop")) {
						double mobiley;
						String mobilex = DtimeInDateFormat1;
						mobiley = res_time;

						map1.put(mobilex, mobiley);

						// //System.out.println("---------"+map1);

					}

					else if (Device.equals("Mobile")) {

						double mobiley;
						String mobilex = DtimeInDateFormat1;
						mobiley = res_time;

						map2.put(mobilex, mobiley);
						// //System.out.println("---------"+map2);

					}

				}
			}
			map3.put(map1, map2);
			 //System.out.println("----->"+map3);
		} catch (Exception e) {
			// //System.out.println(e);
			logger.error("Unexpected error", e);
		}
		finally{
			cursor.close();
		}
		return map3;
	}

}