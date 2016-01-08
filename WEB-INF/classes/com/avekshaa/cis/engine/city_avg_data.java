package com.avekshaa.cis.engine;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;

import org.json.JSONObject;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class city_avg_data {
	public TreeMap<Long, Integer> buffer_perc_detail() {
		JSONObject finaljson = new JSONObject();
		// String finalResulst =null;
		TreeMap<Long, Integer> rexecandresp = new TreeMap<Long, Integer>();
		try {
			Long curr_time = System.currentTimeMillis();
			Date date = new Date(curr_time);
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			String formatted = format.format(date);
//			System.out.println(formatted);
			// MongoClient client=new MongoClient("192.168.0.201");
			// DB db=client.getDB("buffer_avg");
			DB db = CommonDB.JIOConnection();
			DBCollection regular = db.getCollection("buffer_values");

			/* if("asc".equals("ss")){ */
			BasicDBObject bdb = new BasicDBObject("Start_date", formatted);
			DBCursor alertData = null;
			alertData = regular.find(bdb).sort(new BasicDBObject("_id",-1)).limit(24);
//			System.out.println("size is: " + alertData.size());
			List<DBObject> dbObjs = alertData.toArray();
//			if (dbObjs.size() > 24) {
				for (int i = 0; i < dbObjs.size(); i++) {
					DBObject DataObject = dbObjs.get(i);
					Long start_time = (Long) DataObject.get("exec_time");
					int error_size = (Integer) DataObject.get("perc");
//					System.out.println("statys time and creash: " + start_time
//							+ "  " + error_size);
					rexecandresp.put(start_time, error_size);

				}
//			} else {
//
//				for (int i = 0; i < alertData.size(); i++) {
//					DBObject DataObject = dbObjs.get(i);
//					String start_time = (String) DataObject.get("Start_time");
//					int error_size = (Integer) DataObject.get("perc");
//					System.out.println("statys time and creash: " + start_time
//							+ "  " + error_size);
//					rexecandresp.put(start_time, error_size);
//
//				}
//			}
			// }
		} catch (Exception e)

		{
			e.printStackTrace();
		}
//		System.out.println("city avg data : "+rexecandresp);
		return rexecandresp;

	}
	public static void main(String[] args) {
		new one_day_hits_data().hits_detail();
	}
}
