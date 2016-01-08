package com.avekshaa.cis.Java;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class CpuPercentLineGraph {
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}


	//public static void main(String[] args) {

		 public Map<String, Double> mtd(){

				HashMap<String, Double> finalMap = new HashMap<String, Double>();
				DBCursor alertData=null;

		try {
			String perc = null;

// ----------------------------------DB CONNCETION---------------------------------------------------------------------
			// 1.connect to mongo// host+port
			
			//System.out.println("DB Name:" + db.getName());

			// 3.selcet the collection
			DBCollection coll = db.getCollection("Regular");
			//System.out.println("collection name:" + coll.getName());
// -----------------------------------------------------------------------------------------------------------

			
			java.util.List l1 = coll.distinct("acitvity_name");  //Distinct Activity
			

			String activityName = null;

			for (int i = 0; i < l1.size(); i++) 
			{
				activityName = l1.get(i).toString();
				List<Double> myList = new ArrayList<Double>();
				
				
				
// ----------------------fetch CPU%----------------------------------------------------------------
				BasicDBObject findObj1 = new BasicDBObject("acitvity_name",activityName);
				 alertData = coll.find(findObj1);
				alertData.sort(new BasicDBObject("_id", -1));
				//alertData.limit(10);
				List<DBObject> dbObjs = alertData.toArray();
				for (int i1 = 0; i1 < dbObjs.size(); i1++) 
				{
					DBObject txnDataObject = dbObjs.get(i1);

					//perc = (String) txnDataObject.get("Cpu%");       //cpu percent
					Double d = Double.valueOf(String.valueOf((Long) txnDataObject.get("Cpu")));
					myList.add(d);
			

				}
//---------------------------------------------------------------------------------------------------------
				
				
				
				
				
//--------------------sum of avg cpu%--------------------------------------------------------------------
				double sum = 0;

				//System.out.println("Activity="+activityName+"\n"+"LIst Content="+myList+"\n"+"Size OF list="+dbObjs.size());
				  for (Double i2 : myList) { 
					  sum += i2;
				  
				  }
//--------------------------------------------------------------------------------------------------------				
				  
				//System.out.println("SUMM:" + sum );

				double avg1 = (sum / dbObjs.size());   //avg of CPU%
				//System.out.println("avgg:" + avg1);
				
				
				//System.out.println("---------------");

				double avg2 = (double) Math.round(avg1);//ROUNDED VALUE
				////System.out.println("Rounded Avg:" + avg2);

				
				finalMap.put(activityName,avg2);//store in map 

			}
			//System.out.println("FINAL MAPl:" + finalMap);
		}

		catch (Exception e)

		{
			e.printStackTrace();
		}
		finally{
			alertData.close();
			
		}
		 return finalMap;

	}

}
