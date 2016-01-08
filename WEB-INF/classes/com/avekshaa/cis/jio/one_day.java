package com.avekshaa.cis.jio;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

public class one_day implements Job {

	static int i = 0;
	static int total = 0;
	static int totalCounter = 0;
	static int coll_entry = 1;// increment of this var after every 1 day
	static int doc_entry = 1; // increment after every document is inserted
	public static DB db;
	static {
		db = CommonDB.JIOConnection();
	}

	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		DBCursor alertData = null;

		DBCollection coll = db.getCollection("Regular");
		long end_time = System.currentTimeMillis();
		long strt_time = System.currentTimeMillis() - (60*60*1000 );

		Date date = new Date(end_time);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
		String formatted = format.format(date);
		String formatted1 = format1.format(date);
		System.out.println(formatted);

		BasicDBObject bdb = new BasicDBObject();
		bdb.put("request_time",
				new BasicDBObject("$gt", strt_time).append("$lt", end_time));
		alertData = coll.find(bdb);
		int count = alertData.size();
		totalCounter++;
		i++;// cal 4 times in an hour
		total = total + count;

		String value = "day" + String.valueOf(coll_entry);
		String doc_value = String.valueOf(doc_entry);

		System.out.println(i);
		System.out.println(count);

		if (i == 4) {
			/*
			 * MongoClient client1=new MongoClient("52.24.170.28"); DB
			 * db1=client1.getDB("NewJIOData");
			 */
			DBCollection newcoll = db.getCollection("hits");
			BasicDBObject bdb01 = new BasicDBObject();
			bdb01.put("Day", value);
			bdb01.put("hour", doc_value);
			bdb01.put("hits", total);
			bdb01.put("exec_time", end_time);
			bdb01.put("Start_time", formatted);
			bdb01.put("Start_date", formatted1);
			// bdb01.put(doc_value, total);
			newcoll.insert(bdb01);

			i = 0;
			total = 0;
			doc_entry++;
			System.out.println("enter badhao" + doc_entry);

			if (doc_entry == 24) {
				DBCollection newcoll1 = db.getCollection("avg");
				BasicDBObject bdb1 = new BasicDBObject();
				bdb1.put("total_avg", totalCounter);
				bdb1.put("Day", value);
				newcoll1.insert(bdb1);
				coll_entry++;
				doc_entry = 1;
				totalCounter = 0;
			}
		}

	}
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		new one_day().execute(null);
			}
}
