package com.avekshaa.cis.Java;


import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;

public class WebResponseCount {
	
	public static Mongo m;
	static {
		m = CommonDB.generalConnection();
	}

//public static void main(String[] args) {
		
	public long error(){
	
		long z=0;
		int resp= 0;
		try {
			
			//1.connect to mongo// host+port
			
			
			//3.selcet the collection
			
			DB cis =m.getDB("CIS");
			DBCollection Network=cis.getCollection("CISResponse");
		
		//	//System.out.println("collection name:"+coll.getName());
					
			resp=  (int) Network.count();
			
					z = Network.count(new BasicDBObject("status_Code",	new BasicDBObject("$gt", 299)));
				
	} catch (Exception e) {
		e.printStackTrace();
	} 
return z;
	}
	
	public int response(){
		
		
		int count=0;
		try {
			
			//1.connect to mongo// host+port
			
			
			//3.selcet the collection
			DB andro =m.getDB("AndroidData");
			DB cis =m.getDB("CIS");
			DBCollection Network=cis.getCollection("CISResponse");
			DBCollection cpuandmemory=andro.getCollection("Regular");
		
		//	//System.out.println("collection name:"+coll.getName());
					
			int androcount=  (int) Network.count();
			int webcount =(int) cpuandmemory.count();			
			count=androcount+webcount;
				
	} catch (Exception e) {
		e.printStackTrace();
	} 
return count;
	}
}

