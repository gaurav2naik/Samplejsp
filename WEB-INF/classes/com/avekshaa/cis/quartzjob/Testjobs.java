package com.avekshaa.cis.quartzjob;

import java.util.ArrayList;
import java.util.List;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class Testjobs {

	public static void main(String[] args) {
		DBCursor alertData=null;

		try {
			String perc = null;

	//----------------------------------DB CONNCETION---------------------------------------------------------------------
			// 1.connect to mongo// host+port
			
		

			// 3.selcet the collection
			DB db =CommonDB.AndroidConnection();
			System.out.println("DB Name:" + db.getName());
			DBCollection coll = db.getCollection("Regular");
			DBCollection AndoidAvg= db.getCollection("Android_Avg");
			//System.out.println("collection name:" + coll.getName());
	//-----------------------------------------------------------------------------------------------------------

			java.util.List l1 = coll.distinct("Mobilename");
			
			BasicDBObject document = new BasicDBObject();
			String Device_name = null;

			for (int i = 0; i < l1.size(); i++) {
				Device_name = l1.get(i).toString();
				if (!(Device_name.startsWith("generic"))){
				List<Double> myList = new ArrayList<Double>();
	//-------------------------------------------- fetch CPU%--------------------------------------------------------
				BasicDBObject findObj1 = new BasicDBObject("Mobilename",Device_name);
				 alertData = coll.find(findObj1);
				alertData.sort(new BasicDBObject("_id", -1));
				//alertData.limit(10);
				List<DBObject> dbObjs = alertData.toArray();
				for (int i1 = 0; i1 < dbObjs.size(); i1++) {
					DBObject txnDataObject = dbObjs.get(i1);

					perc = (String) txnDataObject.get("duration");
					Double d = Double.valueOf(perc);// COVERT TO INT
			System.out.println("CPU %" + d + "IN " + Device_name);

					myList.add(d);
				//	//System.out.println("------>>.>" + myList);

				}
				
	//----------------------------------------------------------------------------------------------------------------------
				// sum of avg cpu%
				double sum = 0;

				////System.out.println("DEvice:"+Device_name+"\n"+"list" +myList+"\n "+"count: "+dbObjs.size());
				  for (Double i2 : myList) { 
					  sum += i2;
				  
				  }
						//System.out.println("sum:"+sum);

				double avg1 = (sum /dbObjs.size());
				////System.out.println("avgg:" + avg1);
				////System.out.println("-----------------");

				double avg2 = (double) Math.round(avg1);
				document.put(Device_name, avg2);
				//finalMap.put(Device_name, avg2);

			}
			////System.out.println("FINAL MAPl:" + finalMap);
		}
			AndoidAvg.insert(document);
			
		}

		catch (Exception e)

		{
			e.printStackTrace();
		}
		finally{
			alertData.close();
		}
		
	System.out.println("DONE");
	}
}
