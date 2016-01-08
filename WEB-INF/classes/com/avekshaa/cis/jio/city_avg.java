package com.avekshaa.cis.jio;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class city_avg implements Job{
	static int red=0;
	static int green=0;
	static int threshold_data=175;
	static int i=0;
	static int thresh=0;
	static int cal_size=0;
	static int total_thresh_brech=0;
	static int coll_entry=1;//increment of this var after every 1 day
	static int doc_entry=1; // increment after every document is inserted
	public static DB db;
	static {
		db = CommonDB.JIOConnection();
	}
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
DBCursor alertData = null;
		
		DBCollection coll=db.getCollection("PlayerStateInfo");
	long end_time  = System.currentTimeMillis();
	long strt_time = System.currentTimeMillis()-(7*24*15*4*60000);
	Date date = new Date(end_time);
	DateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	String formatted = format.format(date);
	String formatted1 = format1.format(date);
	System.out.println(formatted);
	BasicDBObject bdb=new BasicDBObject();
	bdb.put("ReadyStateTime",new BasicDBObject("$gt", strt_time).append("$lt", end_time));
	alertData=coll.find(bdb);
	System.out.println("gdfgdgdg"+alertData.size());
	cal_size=cal_size+alertData.size();
	List<DBObject> dbObjs = alertData.toArray();
	for (int ii=0;ii<alertData.size();ii++){
		DBObject txnDataObject = dbObjs.get(ii);
		long buffer_time = (Long) txnDataObject.get("BufferDuration");
		//System.out.println(buffer_time);
		if(buffer_time>=threshold_data){
		//	thresh=thresh+red;
			red++;
		//	System.out.println(red);
		}
	}
		i++;
		
		String value="day"+String.valueOf(coll_entry);
		String doc_value=String.valueOf(doc_entry);
		System.out.println("udsejek");
		System.out.println("i is: "+i);
		
		
		
		if(i==4){
			int thres_brech=(red*100)/cal_size;
			total_thresh_brech=	total_thresh_brech+thres_brech;
			/*MongoClient client1=new MongoClient("127.0.0.1");
			DB db1=client1.getDB("buffer_avg");*/
			DBCollection coll1=db.getCollection("buffer_values");
			BasicDBObject bdb01=new BasicDBObject();
			bdb01.put("Day", value);
			bdb01.put("perc", thres_brech);
			bdb01.put("exec_time", end_time);
			bdb01.put("Start_time", formatted);
			bdb01.put("Start_date", formatted1);
			System.out.println("Data inswetred"+doc_entry);
			coll1.insert(bdb01);
			doc_entry++;
			System.out.println("first entry");
			red=0;
			i=0;
			cal_size=0;
			System.out.println();
			
		
			if(doc_entry==24){
		int	avg_brech_day=(total_thresh_brech*100)/24;
		BasicDBObject bdb1=new BasicDBObject();
		bdb1.put("avg_brech_day", avg_brech_day);
		coll1.insert(bdb1);
		doc_entry=0;
		coll_entry++;
		}
		}
		
	}
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		new city_avg().execute(null);
			}
}