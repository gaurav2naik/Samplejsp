package com.avekshaa.cis.Java;

import java.awt.List;
import java.util.Map;
import java.util.TreeMap;





import com.avekshaa.cis.database.CommonDB;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;

public class DistinctUser {
	public static DB db;
	static {
		db = CommonDB.getConnection();
	}


//public static void main(String[] args) {
		
	public int mtd(){
	
		Integer us = null;
    	 try
	      {
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
    		//1.connect to mongo// host+port
    			
    			//System.out.println("DB Name:"+db.getName());
    			
    			
    			//3.selcet the collection
    			DBCollection coll=db.getCollection("CISResponse");
    			//System.out.println("collection name:"+coll.getName());
 //-----------------------------------------------------------------------------------------------------------
    		
    			  us=  coll.distinct("IP_Address").size();  //DISTINCT
		//System.out.println("No of user"+us);
			
			// return l1.size();
			
	      }
    	 	    	 
    	 catch (Exception e) 
    	 {
 			//System.out.println(e);
 		}
	  return us ;
	
		
	}


}
