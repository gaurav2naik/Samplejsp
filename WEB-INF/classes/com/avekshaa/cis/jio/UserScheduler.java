package com.avekshaa.cis.jio;

import java.io.IOException;
import java.text.DecimalFormat;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

public class UserScheduler implements Job {
	static ConfigurationVo vo = null;

	static {
		try {
			vo = Configuration.configure();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static DB db;
	static {
		db = CommonDB.JIOConnection();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("UserSchedule called by quartz");
		// TODO Auto-generated method stub
		long now = System.currentTimeMillis();
		long beforeTime = now - (3600 * 1000);
		try {
			DBCollection PlayerColl = db.getCollection("PlayerStateInfo");
			DBCollection insertBufferUsage = db
					.getCollection("PlayerBufferUsage");
			BasicDBList l = new BasicDBList();
			l.add("$BytesDownloaded");
			l.add("$BufferDuration");

			DBObject project = new BasicDBObject("$project", new BasicDBObject(
					"UUID", 1).append("ByteRate",
					new BasicDBObject("$divide", l)).append("BufferDur",
					"$BufferDuration"));
			DBObject match1 = new BasicDBObject("$match", new BasicDBObject(
					"BufferStateTime", new BasicDBObject("$gt", beforeTime)));
			DBObject group1 = new BasicDBObject("$group", new BasicDBObject(
					"_id", "$UUID").append("avgBufferDuration",
					new BasicDBObject("$avg", "$BufferDur")).append(
					"avgByteRate", new BasicDBObject("$avg", "$ByteRate")));
			AggregationOutput output1 = PlayerColl.aggregate(match1, project,
					group1);
			for (DBObject results1 : output1.results()) {

				double avgByteRate = Double.parseDouble(new DecimalFormat(
						"##.##").format(results1.get("avgByteRate")));
				double avgBufferDuration = Double
						.parseDouble(new DecimalFormat("##.##").format(results1
								.get("avgBufferDuration")));
				String uuid = results1.get("_id").toString();
				System.out.println("UUID :" + uuid + " avgByteRate :"
						+ avgByteRate + " avgBufferDuration : "
						+ avgBufferDuration);
				DBObject insertObj = new BasicDBObject();
				DBObject obj1 = new BasicDBObject("UUID", uuid);
				DBObject c = PlayerColl.findOne(obj1);
				// System.out.println(c.get("city"));

				insertObj.put("UUID", uuid);
				insertObj.put("avgBufferDuration", avgBufferDuration);
				insertObj.put("avgByteRate", avgByteRate);
				insertObj.put("state", c.get("state"));
				insertObj.put("city", c.get("city"));
				insertObj.put("Android_ver", c.get("Android_ver"));
				insertObj.put("App_ver", c.get("App_ver"));

				System.out.println(insertObj.toString());
				insertBufferUsage.insert(insertObj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		UserScheduler u = new UserScheduler();
		u.execute(null);
	}
}