package com.avekshaa.cis.jio;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.bson.types.ObjectId;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class DashBoardQuartz implements Job {
	static int cal_size = 0;
	static int coll_entry = 1;// increment of this var after every 1 day
	static int doc_entry = 1; // increment after every document is inserted
	static DB db;
	static int red = 0;
	static {
		db = CommonDB.getBankConnection();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("DashBoardQuartz called at"+new SimpleDateFormat("HH:mm:ss").format(new Date()));
		// TODO Auto-generated method stub

		// One Day (Number of Hits)
		DBCursor regularData = null;
		DBCollection coll = db.getCollection("Regular");
		long end_time = System.currentTimeMillis();
		long strt_time = end_time - ( 60 * 60*1000);

		Date date = new Date(end_time);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
		String formatted = format.format(date);
		String formatted1 = format1.format(date);
		//System.out.println(formatted);

		DBObject search = new BasicDBObject();
		search.put("request_time",
				new BasicDBObject("$gt", strt_time));

		//System.out.println(search);
		regularData = coll.find(search);
		int count = regularData.size();
		//System.out.println(count);
		String value = "day" + String.valueOf(coll_entry);
		String doc_value = String.valueOf(doc_entry);

		DBCollection hitsColl = db.getCollection("hits");
		BasicDBObject insertObj = new BasicDBObject();
		insertObj.put("Day", value);
		insertObj.put("hour", doc_value);
		insertObj.put("hits", count);
		insertObj.put("exec_time", end_time);
		insertObj.put("Start_time", formatted);
		insertObj.put("Start_date", formatted1);
		// bdb01.put(doc_value, total);
		hitsColl.insert(insertObj);
		System.out.println("DashBoardQuartz hits inserted : " + insertObj);
		doc_entry++;
		System.out.println("hits:"+insertObj);
		// end of one day

		// City Average (%buffering)
		DBCollection thresholdColl = db.getCollection("ThresholdDB");
		DBObject sortObj = new BasicDBObject("_id", -1);
		List<DBObject> thList = thresholdColl.find().sort(sortObj).limit(1)
				.toArray();
		int thresholdValue=0;
		if (thList.size() > 0) {
			DBObject obj = thList.get(0);

			thresholdValue = Integer.parseInt(obj.get("Buffer_threshold")
					.toString());
		}
		DBCursor alertData = null;

		DBCollection PlayerStateInfoColl = db.getCollection("PlayerStateInfo");
		BasicDBObject bdb = new BasicDBObject();
		bdb.put("ReadyStateTime",
				new BasicDBObject("$gt", strt_time));
//		bdb.put("BufferDuration", new BasicDBObject("$gt",thresholdValue));
		alertData = PlayerStateInfoColl.find(bdb);
//		System.out.println("gdfgdgdgffffffffffffffffffff" + alertData.size());
		//red = alertData.size();
		
		cal_size = alertData.size();
		if (cal_size <= 0) {
			cal_size = 1;
		}
	
		List<DBObject> dbObjsList = alertData.toArray();
		for (int ii = 0; ii < dbObjsList.size(); ii++) {
			DBObject txnDataObject = dbObjsList.get(ii);
			long buffer_time = (Long) txnDataObject.get("BufferDuration");
			// System.out.println(buffer_time);
			if (buffer_time >= thresholdValue) {
				// thresh=thresh+red;
				red++;
				// System.out.println(red);
			}

		}
		//System.out.println("red Vale: " + red);

		int thres_brech = (red * 100) / cal_size;

		DBCollection bufferValuesColl = db.getCollection("buffer_values");
		BasicDBObject insertObj1 = new BasicDBObject();
		// bdb01.put("Day", value);
		insertObj1.put("perc", thres_brech);
		insertObj1.put("exec_time", end_time);
		insertObj1.put("Start_time", formatted);
		insertObj1.put("Start_date", formatted1);
		//System.out.println("Data inswetred" + doc_entry);
		//bufferValuesColl.insert(insertObj1);
		System.out.println("DashBoardQuartz buffer inserted : " + insertObj1);
		doc_entry++;
		//System.out.println("first entry");
		red = 0;
		cal_size = 0;
		// end of City Average

		// Fatal Error(Crash report)
		DBCursor errorCursor = null;
		DBCollection errorColl = db.getCollection("Error");

		DBObject findQ = new BasicDBObject("_id", new BasicDBObject("$gt",
				new ObjectId(new Date(strt_time))));
		//System.out.println("bdbd ios :" + findQ.toString());
		errorCursor = errorColl.find(findQ);
		int size = errorCursor.size();
		//System.out.println("inse size is: " + size);

		DBCollection cal_errorColl = db.getCollection("cal_error");
		BasicDBObject insertObj2 = new BasicDBObject();
		insertObj2.put("Day", value);
		insertObj2.put("hours", size);
		insertObj2.put("exec_time", end_time);
		insertObj2.put("Start_time", formatted);
		insertObj2.put("Start_date", formatted1);
		cal_errorColl.insert(insertObj2);
		System.out.println("Cal_error : " + insertObj2);
		doc_entry++;
	}

	public static void main(String[] args) throws Exception {
		new DashBoardQuartz().execute(null);
	}
}
