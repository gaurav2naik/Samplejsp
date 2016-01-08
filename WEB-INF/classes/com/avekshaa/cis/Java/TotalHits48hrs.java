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

public class TotalHits48hrs {
  
	public static MongoClient m;
	static {
		m = CommonDB.generalConnection();
	}
//public static void main(String[] args) {
      
    public double mtd(){
  
        //Integer resp = null;
      
        double x1 = 0;
        double y1 = 0;
        double addition=0;
       
        DBCursor alertData = null;
         try
          {
            
             long now = System.currentTimeMillis();
          
              //System.out.println("current time"+now);
              long beforetime = System.currentTimeMillis() - 172800000;
             
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
            //1.connect to mongo// host+port
             
          
                //2.connect to your DB
                DB db=m.getDB("CIS");
                //System.out.println("DB Name:"+db.getName());
              
              
                //3.selcet the collection
                DBCollection coll2=db.getCollection("CISResponse");
                //System.out.println("collection name:"+coll2.getName());
               
               
                //2.connect to your DB
                DB db1=m.getDB("AndroidData");
                //System.out.println("DB Name:"+db.getName());
              
              
                //3.selcet the collection
                DBCollection coll3=db1.getCollection("Regular");
                //System.out.println("collection name:"+coll3.getName());
               
               
               
               
 //-----------------------------------------------------------------------------------------------------------
          
           //web
                x1 = coll2.count(new BasicDBObject("exectime",
                        new BasicDBObject("$gt", beforetime).append("$lt", now)));
                //System.out.println("WEB Total hits in 48 Hours:" + x1);
              
               
                //android
                y1 = coll3.count(new BasicDBObject("response_time",
                        new BasicDBObject("$gt", beforetime).append("$lt", now)));
                //System.out.println("ANDROID Total hits in 48 Hours:" + y1);
               
               
                addition=x1+y1;
                //System.out.println("TOTAL:"+addition);
               
               
             
              
        //-------------------------------------------------------------------------------------------
          
          }
                     
         catch (Exception e)
         {
             //System.out.println(e);
         }
        return addition;
  
    ////System.out.println("TOTAL"+addition);
      
    }


}

