package com.avekshaa.cis.Java;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;

public class AndroidResponseCount {
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}

	

//public static void main(String[] args) {
		
	public int mtd(){
	
		Integer resp = null;
    	 try
	      {
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
 
    			//3.selcet the collection
    			DBCollection coll=db.getCollection("Regular");
    			//System.out.println("collection name:"+coll.getName());
 //-----------------------------------------------------------------------------------------------------------
    		
    			 resp=  (int) coll.count();  //Total docs
		//System.out.println("No of Responses from Android:"+resp);
	
			
	      }
    	 	    	 
    	 catch (Exception e) 
    	 {
 		}
	
    	 return resp;
	
		
	}


}

