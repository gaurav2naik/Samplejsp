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

public class OneHourAndroid {
   
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}
//public static void main(String[] args) {
       
   public double mtd(){
   
        //Integer resp = null;
       
        double x = 0;
    //    DBCursor alertData = null;
         try
          {
             
             long now = System.currentTimeMillis();
           
              //System.out.println("current time"+now);
              long beforetime = System.currentTimeMillis() - 3600000;
              
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
            //1.connect to mongo// host+port
               /* Mongo m=new Mongo("52.24.170.28",27017);
           
                //2.connect to your DB
                DB db=m.getDB("AndroidData");*/
                //System.out.println("DB Name:"+db.getName());
               
               
                //3.selcet the collection
                DBCollection coll=db.getCollection("Regular");
                //System.out.println("collection name:"+coll.getName());
 //-----------------------------------------------------------------------------------------------------------
           
       
               
                //fetch starttime
                /*BasicDBObject findObj = new BasicDBObject();
                alertData = coll.find(findObj);
                alertData.sort(new BasicDBObject("_id", -1));
               
                alertData.limit(40);
                List<DBObject> dbObjs = alertData.toArray();

                for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 40; i--)

                {
                    DBObject txnDataObject = dbObjs.get(i);
                    String sta = (String) txnDataObject.get("StartTime");
                    //System.out.println("---"+sta);
               
                }*/
               
                	//changed start_time to request_time by Aashish
                x = coll.count(new BasicDBObject("request_time",   
                        new BasicDBObject("$gt", beforetime).append("$lt", now)));
               // System.out.println("total responses within 1 hr Android=" + x);
               
               
               
        //-------------------------------------------------
           
          }
                      
         catch (Exception e)
         {
             //System.out.println(e);
         }
   
        return x;
   
       
    }


}