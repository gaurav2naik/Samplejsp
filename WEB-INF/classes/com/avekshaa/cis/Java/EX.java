package com.avekshaa.cis.Java;

import java.util.*;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class EX
{
   
    
    public static MongoClient mongo;
	static {
		mongo = CommonDB.generalConnection();
	}
    //public static void main(String[] args) {
   
      public double mtd(){
   
       
        double x=0;
        double y=0;
        double addn=0;
       
       
        double x1=0;
        double y1=0;
        double addition=0;
       
       
        double per=0;
       
  
       
        long now = System.currentTimeMillis();
       
        //System.out.println("current time"+now);
        long beforetime = System.currentTimeMillis() - 172800000;         //48 hrs
       
    //-----------------------------1111111----------------------   
        /* Mongo m=new Mongo("52.24.170.28",27017);
       */
         DBCursor alertData = null;
        //2.connect to your DB
      try{
         DB db=mongo.getDB("CIS");
     
        //System.out.println("DB Name:"+db.getName());
     
        //3.select the collection
        DBCollection coll=db.getCollection("ThresholdDB");
        //System.out.println("IN threshold DAO"+coll.getName());
  
      
        //3.selcet the collection
        DBCollection coll2=db.getCollection("CISResponse");
        //System.out.println("collection name:"+coll2.getName());
       
        //--------333333333--------------------
        DB db3=mongo.getDB("AndroidData");
        //System.out.println("DB Name:"+db3.getName());
      
      
        //3.selcet the collection
        DBCollection coll3=db3.getCollection("Regular");
        //System.out.println("collection name:"+coll3.getName());
       
        //--------------------------------------------------
       
   
//fetch name
        BasicDBObject findObj = new BasicDBObject();
        alertData = coll.find(findObj);
        alertData.sort(new BasicDBObject("_id", -1));
     
        alertData.limit(1);
        List<DBObject> dbObjs = alertData.toArray();

        for (int i = dbObjs.size() - 1; i >= 0; i--)

        {
            DBObject txnDataObject = dbObjs.get(i);
            Integer thres = (Integer) txnDataObject.get("Web_threshold");
           
            //System.out.println("monishab"+thres);
           
 
           
           
           
         //ABOVE THRESHOLD
            x = coll2.count(new BasicDBObject("response_time",    new BasicDBObject("$gt", thres)).append("exectime",
                    new BasicDBObject("$gt", beforetime).append("$lt", now)));
            //System.out.println("ABOVE THRESHOLD:" + x);
           
            //error pages
            y = coll2.count(new BasicDBObject("exectime",
                    new BasicDBObject("$gt", beforetime).append("$lt", now)).append("status_Code",    new BasicDBObject("$gt", 299)));
            //System.out.println("error pages:" + y);
           
           
            //addn
            addn=x+y;
            //System.out.println("addn:"+addn);
         
           
           
          
           
           
           
        }
       
       
       
       
      //web
        x1 = coll2.count(new BasicDBObject("exectime",
                new BasicDBObject("$gt", beforetime).append("$lt", now)));
        //System.out.println("WEB Total hits in 48 Hours:" + x);
      
       
        //android
        y1 = coll3.count(new BasicDBObject("StartTime",
                new BasicDBObject("$gt", beforetime).append("$lt", now)));
        //System.out.println("ANDROID Total hits in 48 Hours:" + y);
       
       
        addition=x1+y1;
        //System.out.println("TOTAL:"+addition);
       
       
       
       
        //return addn;

    //System.out.println("INCIDENTS"+addn);//incidents
   
    //per= ((addn)/(addition))*100;
    per= Math.round(((addn)/(addition))*100);
    //System.out.println("percentage:"+per);
      }
      catch (Exception e)

		{
			e.printStackTrace();
		}
		finally{
			 alertData.close();
		}
    return per;
   
       
    }

}