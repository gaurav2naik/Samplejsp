package com.avekshaa.cis.servlet;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.bson.types.ObjectId;

import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class CreateTableRecentTen {
	static final Logger logger = Logger.getRootLogger();
	static String Error_Detail;
	public static DB db, db2;
	static {
		db = CommonDB.getConnection();
		db2 = CommonDB.getBankConnection();
	}

	String getTAble(String IP, String URL) {
		DBCursor alertData = null;

		String a = "<table id='t01' >";
		a = a + "<tr><td>Date & Time</td><td>Response Time</td></tr>";
		try {
			DBCollection cisresponse = db.getCollection("CISResponse");
			BasicDBObject findObj = new BasicDBObject();
			findObj.put("IP_Address", IP);
			findObj.put("URI", URL);
			alertData = cisresponse.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(10);
			// //System.out.println("alert d daata"+findObj);
			List<DBObject> dbObjs = alertData.toArray();
			// //System.out.println("BEFORE COndition"+dbObjs.size());
			int size = dbObjs.size();
			// //System.out.println("DBO SIZE "+size);
			if (size > 10) {
				for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 10; i--) {
					// //System.out.println("INSIDE LOOOP 1");
					DBObject txnDataObject = dbObjs.get(i);

					String DTime = (String) txnDataObject.get("Date");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					int res_time = (int) responseTi;

					a = a + "<tr><td>" + DTime + "</td><td>" + res_time
							+ "</td></tr>";

				}
			} else {
				for (int i = dbObjs.size() - 1; i >= 0; i--) {
					DBObject txnDataObject = dbObjs.get(i);
					String DTime = (String) txnDataObject.get("Date");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					int res_time = (int) responseTi;
					a = a + "<tr><td>" + DTime + "</td><td>" + res_time
							+ "</td></tr>";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Unexpected error", e);
		} finally {
			alertData.close();

		}

		a = a + "</table>";

		return a;
	}

	String getIncident(String startTime, String endTime) {
		Long start = Convertor.timeInMilisecond(startTime);
		Long end = Convertor.timeInMilisecond(endTime);
		System.out.println("Start Time"+start+" EndTime: "+end);
		DBCursor alertData = null;
		DBCursor dd = null;

		String a = "<table id='t01' align='center' bgcolor='#99ccff' ;title='Incident Data' ; border='4' ; bordercolor='black';  cellpadding='6'>";
		a = a
				+ "		<tr><td><b>IP</b></td><td><b>URI</b></td><td><b>Time</b></td><td><b>Device</b></td><td><b>Status Code</b></td><td><b>Remarks</b></td></tr>";
		try {
			DBCollection cisresponse = db.getCollection("CISResponse");
			BasicDBObject findObj = new BasicDBObject();
			findObj.put("exectime",
					new BasicDBObject("$gt", start).append("$lt", end));
			findObj.put("status_Code", new BasicDBObject("$gt", 299));
			alertData = cisresponse.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(100);
			// //System.out.println("alert d daata"+findObj);
			List<DBObject> dbObjs = alertData.toArray();
			// //System.out.println("BEFORE COndition"+dbObjs.size());
			int size = dbObjs.size();
			// //System.out.println("DBO SIZE "+size);
			if (size > 100) {
				for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 100; i--) {
					// //System.out.println("INSIDE LOOOP 1");
					DBObject txnDataObject = dbObjs.get(i);
					String IP = (String) txnDataObject.get("IP_Address");
					String URI = (String) txnDataObject.get("URI");
					Long execTime = (Long) txnDataObject.get("exectime");
					String formtime = Convertor.timeInDefaultFormat(execTime);
					/*
					 * double responseTi = Double.parseDouble(txnDataObject.get(
					 * "response_time").toString()); int responseTime = (int)
					 * responseTi;
					 */
					String Device = (String) txnDataObject.get("Device");
					/*
					 * Integer status =(Integer)
					 * txnDataObject.get("status_Code");
					 */
					double status = Double.parseDouble(txnDataObject.get(
							"status_Code").toString());
					int responseTime = (int) status;
					String errorstatur = Integer.toString(responseTime);
					DBCollection errorlist = db.getCollection("Errorlist");
					BasicDBObject err = new BasicDBObject();
					dd = errorlist.find(err);

					List<DBObject> dbObjs1 = dd.toArray();
					// //System.out.println("error detail"+dbObjs1);
					for (int j = dbObjs1.size() - 1; j > dbObjs1.size() - 2; j--) {
						try {

							DBObject txnDataOb = dbObjs1.get(j);
							Error_Detail = (String) txnDataOb.get(errorstatur);
							// //System.out.println(Error_Detail+"  "+errorstatur);

						} catch (Exception e) {
							e.printStackTrace();
						}
						a = a + "<tr><td>" + IP + "</td><td>" + URI
								+ "</td><td>" + formtime + "</td><td>" + Device
								+ "</td><td>" + status + "</td><td>"
								+ Error_Detail + "</td></tr>";

					}
					// //System.out.println(IP+URI+execTime+status+Device+" error "+status+" --> "+
					// Error_Detail);

				}
			} else if (size > 0 && size < 201) {
				for (int i = dbObjs.size() - 1; i >= 0; i--) {
					DBObject txnDataObject = dbObjs.get(i);
					String IP = (String) txnDataObject.get("IP_Address");
					String URI = (String) txnDataObject.get("URI");
					Long execTime = (Long) txnDataObject.get("exectime");
					String formtime = Convertor.timeInDefaultFormat(execTime);
					/*
					 * double responseTi = Double.parseDouble(txnDataObject.get(
					 * "response_time").toString()); int responseTime = (int)
					 * responseTi;
					 */
					String Device = (String) txnDataObject.get("Device");
					/*
					 * Integer status =(Integer)
					 * txnDataObject.get("status_Code");
					 */
					double status = Double.parseDouble(txnDataObject.get(
							"status_Code").toString());
					int responseTime = (int) status;
					String errorstatur = Integer.toString(responseTime);
					DBCollection errorlist = db.getCollection("Errorlist");
					BasicDBObject err = new BasicDBObject();
					dd = errorlist.find(err);

					List<DBObject> dbObjs1 = dd.toArray();
					// //System.out.println("error detail"+dbObjs1);
					for (int j = dbObjs1.size() - 1; j > dbObjs1.size() - 2; j--) {
						try {

							DBObject txnDataOb = dbObjs1.get(j);
							Error_Detail = (String) txnDataOb.get(errorstatur);
							// //System.out.println(Error_Detail+"  "+errorstatur);

						} catch (Exception e) {
							e.printStackTrace();
						}
						a = a + "<tr><td>" + IP + "</td><td>" + URI
								+ "</td><td>" + formtime + "</td><td>" + Device
								+ "</td><td>" + status + "</td><td>"
								+ Error_Detail + "</td></tr>";

					}
				}
			} else {
				a = a
						+ "<tr><td>NO DATA</td><td>NO DATA</td><td>NO DATA</td><td>NO DATA</td><td>NO DATA</td><td>NO DATA</td></tr>";

			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Unexpected error", e);
		} finally {
			if (alertData != null) {
				alertData.close();
			}

			if (dd != null) {
				dd.close();
			}

		}

		a = a + "</table>";

		return a;

	}
	public static List getIncidentTableData(Long date) throws Exception {
		//System.out.println(" Inside getIncidentTableData Start Time: "+date);
		
		DBCollection cisresponse = db.getCollection("CISResponse");
		DBObject findObj=new BasicDBObject();
		DBCursor alertData = null;
		findObj.put("exectime",
				new BasicDBObject("$gt", date));
		findObj.put("status_Code", new BasicDBObject("$gt", 399));
		alertData = cisresponse.find(findObj);
		alertData.sort(new BasicDBObject("_id", -1));
		alertData.limit(100);
		
		List<DBObject> returnList=alertData.toArray();
		System.out.println("list size :"+returnList.size()+returnList.toString());
		return returnList;
	}
	
	
// data for App version
	@SuppressWarnings("rawtypes")
	public static List getAndroidTableData(String type,String appVersion) throws Exception {
		System.out.println("android vertion = "+appVersion);
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		DBCollection coll = db2.getCollection("Regular");
		DBObject findQ1 = null;
		if(type.equals("os")){
		System.out.println("inside if");
			findQ1 = new BasicDBObject("Android_ver", appVersion);
		}
		else if(type.equals("app"))
			findQ1 = new BasicDBObject("App_ver", appVersion);
		DBObject sort = new BasicDBObject("_id", -1);
		List<DBObject> listLastData = coll.find(findQ1).sort(sort).limit(1)
				.toArray();
		List<DBObject> returnList=null;
		if(listLastData.size()>0){
		DBObject lastData = listLastData.get(0);
		// DBCursor cur1 = coll1.find({_id: {$lt:new ObjectId( Math.floor(new
		// Date(new Date()-1000*60*60*24*60).getTime()/1000).toString(16) +
		// "0000000000000000" )}}));
		// db.collection.find({_id: {$lt:new ObjectId( Math.floor(new Date(new
		// Date()-1000*60*60*24*60).getTime()/1000).toString(16) +
		// "0000000000000000" )}})
		
		//tacking time form last object	
		ObjectId o = new ObjectId(lastData.get("_id").toString());
		long time = o.getTime() - 60000 * 60;
		System.out.println(time);
		DBObject findq =null;
		if(type.equals("os"))
			findq = new BasicDBObject("_id", new BasicDBObject("$gt",new ObjectId(new Date(time)))).append("Android_ver", appVersion);
		else if (type.equals("app")) {
			findq = new BasicDBObject("_id", new BasicDBObject("$gt",new ObjectId(new Date(time)))).append("App_ver", appVersion);
		}
		System.out.println(lastData.get("_id") + "  "+ sdf.format(new Date(time)) + " " + sdf.format(new Date(o.getTime())));
		/*DBCursor cur2 = coll.find(findq);
		while (cur2.hasNext()) {
			DBObject obj1 = cur2.next();
			System.out.println(obj1.get("_id"));
		}*/
		returnList = coll.find(findq).toArray();
		}
		System.out.println(returnList);
		return returnList;
	}

// data for android ver
	public static List getIOSTableData(String type,String androidVersion) throws Exception {
		System.out.println("ios version = "+androidVersion);
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		DBCollection coll = db2.getCollection("IOSData");
		DBObject findQ1 = null;
		if(type.equals("app")){
			System.out.println("in side if");
			findQ1 = new BasicDBObject("App_ver", androidVersion);
		}
		else if (type.equals("os")) {
			findQ1 = new BasicDBObject("os_version", androidVersion);
		}
		DBObject sort = new BasicDBObject("_id", -1);
		List<DBObject> listLastData = coll.find(findQ1).sort(sort).limit(1)
				.toArray();
		List<DBObject> returnList=null;
		System.out.println(listLastData.size());
		if(listLastData.size()>0){
		DBObject lastData = listLastData.get(0);
		
		//tacking time form last object	
		ObjectId o = new ObjectId(lastData.get("_id").toString());
		System.out.println("Obj id = "+o.toString());
		long time = o.getTime() - (60000 * 60);
		System.out.println(time);
		DBObject findq = null;
		if(type.equals("app")){
			findq = new BasicDBObject("_id", new BasicDBObject("$gte",new ObjectId(new Date(time)))).append("App_ver", androidVersion);
		}
		else if (type.equals("os")) {
			findq = new BasicDBObject("_id", new BasicDBObject("$gte",new ObjectId(new Date(time)))).append("os_version", androidVersion);
		}
		BasicDBList findList = new BasicDBList();
		findList.add(findq);
		//findList.add(findQ1);
		System.out.println(lastData.get("_id") + "  "+ sdf.format(new Date(time)) + " " + sdf.format(new Date(o.getTime())));
		returnList = coll.find(findq).toArray();
		System.out.println("ret list size "+returnList.size());
		}
		return returnList;
	}

	
	
	public static void main(String[] args) throws Exception {
		Long start = 1450253572000l;
		Long end = 1450339975000l;
		//List ll=getIncidentTableData(start,end);
	}
}
