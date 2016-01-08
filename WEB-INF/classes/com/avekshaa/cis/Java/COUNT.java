package com.avekshaa.cis.Java;


import com.avekshaa.cis.database.CommonDB;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class COUNT {
	public static MongoClient m;
	static {
		m = CommonDB.generalConnection();
	}


//public static void main(String[] args) {
		
	public String mtd(){
	
		Integer resp1 = null;
		Integer resp2 = null;
		Integer sum = null;
		Integer foo =null;
		String ss=null;
		//Integer kval =null;
		
    	 try
	      {
   //----------------------------------WEBBBBBBBB---------------------------------------------------------------------
    		//1.connect to mongo// host+port
    			DB db=m.getDB("CIS");
    			//System.out.println("DB Name:"+db.getName());
    			
    			
    			//3.selcet the collection
    			DBCollection coll=db.getCollection("CISResponse");
    			//System.out.println("collection name:"+coll.getName());
 
    		
    			 resp1=  (int) coll.count();  //Total docs
		//System.out.println("No of Responses from WEB:"+resp1);
		
		
	//------------------ANDROID--------------------------------------------------------------
		//1.connect to mongo// host+port
		
		//2.connect to your DB
		DB db2=m.getDB("AndroidData");
		//System.out.println("DB Name:"+db2.getName());
		
		
		//3.selcet the collection
		DBCollection coll2=db2.getCollection("Regular");
		//System.out.println("collection name:"+coll2.getName());
//-----------------------------------------------------------------------------------------------------------
	
		 resp2=  (int) coll2.count();  //Total docs
//System.out.println("No of Responses from Android:"+resp2);

 sum=resp1+resp2;
//System.out.println("SUM---------------------"+sum);

if(sum>1000000000)   //1000000000
{
	
	sum=sum/1000000000;
 ss=Integer.toString(sum).concat("G");         //convert int to string
	
}
else if(sum>1000000)  //10,0     //1 lakh
{
	sum=sum/1000000;
	 ss=Integer.toString(sum).concat("M");

	
}
else if(sum>1000)  //10,0000     //1 lakh
{
	sum=sum/1000;
	 ss=Integer.toString(sum).concat("K");

	
}


	      }
    	 	    	 
    	 catch (Exception e) 
    	 {
 			//System.out.println(e);
 		}
	//  return resp ;
		return ss;
	
		
	}


}

