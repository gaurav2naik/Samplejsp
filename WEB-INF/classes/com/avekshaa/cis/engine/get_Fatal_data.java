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

public class get_Fatal_data {
	public TreeMap<Long, Integer> Fatal_Detail_current() {
		JSONObject finaljson = new JSONObject();
		// String finalResulst =null;
		TreeMap<Long, Integer> rexecandresp = new TreeMap<Long, Integer>();
		try {
			Long curr_time = System.currentTimeMillis();
			Date date = new Date(curr_time);
			DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			String formatted = format.format(date);

			DB db = CommonDB.getBankConnection();
			DBCollection regular = db.getCollection("cal_error");

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
					int error_size = (Integer) DataObject.get("hours");
//					System.out.println("statys time and creash: " + start_time
//							+ "  " + error_size);
					rexecandresp.put(start_time, error_size);

				}
//			} else {
//				for (int i = 0; i < alertData.size(); i++) {
//					DBObject DataObject = dbObjs.get(i);
//					String start_time = (String) DataObject.get("Start_time");
//					int error_size = (Integer) DataObject.get("hours");
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
System.out.println("data :"+rexecandresp);
		return rexecandresp;

	}
public static void main(String[] args) {
	new get_Fatal_data().Fatal_Detail_current();
}
}
