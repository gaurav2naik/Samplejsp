package com.avekshaa.cis.Java;


import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class Incident {
	public static DB db;
	static {
		db = CommonDB.getConnection();
	}


	public Map<Long, Double> incident(){
		
		TreeMap<Long,Double> map1 = new TreeMap<Long,Double>();
		DBObject exectime = null;
		DBCursor alertData=null;
		
		try {
			
			//DB db = COmmonDB.getConnection();
		       	       
			//connect to mongo
			
			//System.out.println("DB NAME:"+db.getName());
			
			
			DBCollection cisresponse = db.getCollection("CISIncident_data");
			BasicDBObject findObj = new BasicDBObject();			
			 alertData = cisresponse.find(findObj).sort(exectime);
			  alertData.limit(50);
			  alertData.sort(new BasicDBObject("_id", -1));	
		//	//System.out.println(alertData);
			List<DBObject> dbObjs = alertData.toArray();
			//System.out.println("dbObj  size :"+dbObjs.size());
			for (int i = dbObjs.size()-1; i >= dbObjs.size()-50; i--) {
				DBObject txnDataObject = dbObjs.get(i);
			Double	pererror =  (Double) txnDataObject.get("error_percentage");
		
			Long  time =(Long) txnDataObject.get("system_current_time");
		
			 
			 
			 
				double percenterror;             
			Long resptime = time;	     
                 percenterror=pererror;
	            
	            map1.put(resptime,percenterror);
	        //    //System.out.println("---------"+map1);
			
		
	                  

}
}
catch (Exception e) {
e.printStackTrace();
}
		finally{
			alertData.close();
		}
		//COmmonDB.closeConnection(); 
//System.out.println("BEFOREEE    "+map1);
return map1;
}


}
