package com.avekshaa.cis.Java;
import java.util.List;

import org.bson.BSONObject;
import org.bson.BasicBSONObject;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class Incident48hrs {
   

//public static void main(String[] args) {
	
	public static MongoClient m;
	static {
		m = CommonDB.generalConnection();
	}
       
    public double mtd(){
   
        //Integer resp = null;
       
       
        double x=0;
        
        DBCursor alertData = null;
         try
          {
             
             long now = System.currentTimeMillis();
           
              //System.out.println("current time"+now);
              long beforetime = System.currentTimeMillis() - 72800000;         //48 hrs  
              
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
            //1.connect to mongo// host+port
           //     Mongo m=new Mongo("52.24.170.28",27017);
           
                //2.connect to your DB
                DB db=m.getDB("CIS");
                //System.out.println("DB Name:"+db.getName());
               
               
                //3.selcet the collection
                DBCollection coll1=db.getCollection("CISResponse");
                //System.out.println("collection name:"+coll1.getName());
                
                

                // Mongo m1=new Mongo("52.24.170.28",27017);
                
                
                //2.connect to your DB
                DB db1=m.getDB("CIS"); 
             
                //System.out.println("DB Name:"+db.getName());
              
                //3.select the collection
                DBCollection coll2=db1.getCollection("ThresholdDB");
                //System.out.println("IN threshold DAO"+coll2.getName());
              
              
              
        //fetch name
                BasicDBObject findObj = new BasicDBObject();
                alertData = coll2.find(findObj);
                alertData.sort(new BasicDBObject("_id", -1));
              
                alertData.limit(1);
                List<DBObject> dbObjs = alertData.toArray();

                for (int i = dbObjs.size() - 1; i >= 0; i--)

                {
                    DBObject txnDataObject = dbObjs.get(i);
                    Integer res = (Integer) txnDataObject.get("Web_threshold");
                    //System.out.println("monishab"+res);
                }
                
                
                
                
                
                
                
 //-----------------------------------------------------------------------------------------------------------
           
           //incidents
                x = coll1.count(new BasicDBObject("exectime",
                        new BasicDBObject("$gt", beforetime).append("$lt", now)).append("status_Code",	new BasicDBObject("$gt", 299)));
                //System.out.println("INCIDENTS in 48 Hours:" + x);
               
                
        //-------------------------------------------------------------------------------------------
           
          }
                      
         catch (Exception e)
         {
             //System.out.println(e);
         }
         finally{
        	 alertData.close(); 
         }
   
        return x;
   
       
    }


}