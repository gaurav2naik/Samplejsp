package com.avekshaa.cis.premiumusers;

import java.util.ArrayList;
import java.util.List;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class GetBandwidthPremiumUser {

	static DB dbs = CommonDB.JIOConnection();
	static DB db=CommonDB.getBankConnection();

	public StringBuilder GetData(String uuid, String starttime) {
		try {
			StringBuilder sb = new StringBuilder();
			// MongoClient mc = new MongoClient("52.24.170.28",27017);
			DBCollection colls = dbs.getCollection("PlayerStateInfo");
			BasicDBObject andQuery = new BasicDBObject();
			List<BasicDBObject> obj = new ArrayList<BasicDBObject>();
			obj.add(new BasicDBObject("StartTime", Long.parseLong(starttime)));
			// obj.add(new BasicDBObject("UUID", device.replace("\r\n", "")));
			obj.add(new BasicDBObject("UUID", uuid.trim()));
			andQuery.put("$and", obj);
			DBCursor cursor = colls.find(andQuery);
			// System.out.println(cursor.toString());
			cursor.sort(new BasicDBObject("_id", -1)).limit(24);
			// System.out.println("caclculate bandwidth============");
			List<DBObject> link1_list = cursor.toArray();
			for (int i = link1_list.size() - 1; i >= 0; i--) {
				DBObject obj1 = link1_list.get(i);
				long s = (Long) obj1.get("BytesDownloaded");
				long s1 = ((Long) obj1.get("BufferDuration"));
				// System.out.println("---------"+s1);
				// long s2 = s1/1000;
				double bandwidthbytespersec = ((s * 1000) / s1);
				double bandwidthkbpersec = bandwidthbytespersec / 1000;
				// System.out.println("caclculate bandwidth============"+bandwidth);
				sb.append(bandwidthkbpersec + ",");
			}
			// System.out.println("Inside java class"+sb);
			return sb;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static int GetCrashData(String uuid, String starttime) {
		DBCollection colls = db.getCollection("Error");
		DBObject findObj = new BasicDBObject("UUID", uuid).append("StartTime",
				Long.parseLong(starttime));
		DBCursor cursor = colls.find(findObj);
		System.out.println(";;;;;;;;;;;;;;;;_-------" + +cursor.count());
		return cursor.count();
	}

	public static int GetBuffer_thrashold_count(String uuid, String starttime) {
		BasicDBObject andQuery = new BasicDBObject();
		List<BasicDBObject> obj = new ArrayList<BasicDBObject>();
		obj.add(new BasicDBObject("StartTime", Long.parseLong(starttime)));
		// obj.add(new BasicDBObject("UUID", device.replace("\r\n", "")));
		obj.add(new BasicDBObject("UUID", uuid.trim()));
		andQuery.put("$and", obj);

		// --------------Threshhold value------------------------------

		DBCollection collection3 = dbs.getCollection("ThresholdDB");
		DBCursor cursor3 = collection3.find();
		cursor3.sort(new BasicDBObject("_id", -1)).limit(1);
		DBObject Buff_thres_obj = cursor3.next();
		long threshold_buffervalue = Long.parseLong(Buff_thres_obj.get(
				"Buffer_threshold").toString());

		// ----------BufferData-----------------------------

		int count = 0;
		DBCollection collection2 = dbs.getCollection("PlayerStateInfo");
		DBCursor cursor2 = collection2.find(andQuery);
		cursor2.sort(new BasicDBObject("_id", -1)).limit(24);
		while (cursor2.hasNext()) {
			DBObject obj1 = cursor2.next();
			if ((Long) obj1.get("BufferDuration") > threshold_buffervalue) {
				count++;
			}

		}

		return count;
	}

	public static long getresponsethreshold() {

		DBCollection collection3 = db.getCollection("ThresholdDB");
		DBCursor cursor3 = collection3.find();
		cursor3.sort(new BasicDBObject("_id", -1)).limit(1);
		DBObject resp_thres_obj = cursor3.next();

		return Long.parseLong(resp_thres_obj.get("Android_threshold")
				.toString());

	}

	public static long CalculateAverageResponse(String uuid, String starttime) {
		System.out.println("SHOW = " + starttime);
		DB dbs = CommonDB.getBankConnection();
		DBCollection colls = dbs.getCollection("Regular");
		BasicDBObject andQuery = new BasicDBObject();
		List<BasicDBObject> obj = new ArrayList<BasicDBObject>();
		obj.add(new BasicDBObject("StartTime", Long.parseLong(starttime)));
		obj.add(new BasicDBObject("UUID", uuid.trim()));
		andQuery.put("$and", obj);
		DBCursor cursor = colls.find(andQuery);
		long total = 0L;
		while (cursor.hasNext()) {
			DBObject obj1 = cursor.next();
			total += (Long) obj1.get("duration");
		}
		long average = (total / cursor.size());
		return average;
	}

	/*public static void main(String args[]) {
		System.out.println(SelectPicturePath("16495d852f9be65b",
				"1449123871905"));
	}*/

	public static String SelectPicturePath(String uuid, String starttime) {
		long threshold = GetBandwidthPremiumUser.getresponsethreshold();
		int crashcount = GetCrashData(uuid, starttime);
		long average = CalculateAverageResponse(uuid, starttime);
		int buffercount = GetBandwidthPremiumUser.GetBuffer_thrashold_count(
				uuid, starttime);
		long i = (70 * threshold) / 100;
		if (crashcount >= 1) {
			return "../image/sadred.png";
		} else {
			if (average >= threshold) {
				return "../image/sadred.png";
			} else {
				/*if (buffercount >= 5) {
					return "../image/sadred.png";
				} else {*/
					if (average < i) {
						return "../image/happygreen.png";
					} else {
						return "../image/normalyellow.png";
					}
				}
			}

			/* System.out.println(i); */
		}
		// return null;
	}
