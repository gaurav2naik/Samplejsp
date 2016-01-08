package com.avekshaa.cis.Java;


import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;

public class OneHourWeb {
   
	public static DB db;
	static {
		db = CommonDB.getConnection();
	}
//public static void main(String[] args) {
       
    public double mtd(){
   
        double x = 0;
         try
          {
             
             long now = System.currentTimeMillis();
             //System.out.println("current time"+now);
             long beforetime = System.currentTimeMillis() - 3600000;
             
             
   //----------------------------------DB CONNCETION---------------------------------------------------------------------
            //1.connect to mongo// host+port
               /* Mongo m=new Mongo("52.24.170.28",27017);
           
                //2.connect to your DB
                DB db=m.getDB("CIS");*/
                //System.out.println("DB Name:"+db.getName());
               
               
                //3.selcet the collection
                DBCollection coll=db.getCollection("CISResponse");
                //System.out.println("collection name:"+coll.getName());
 //-----------------------------------------------------------------------------------------------------------

                // total count in 1hr
                x = coll.count(new BasicDBObject("exectime",
                        new BasicDBObject("$gt", beforetime).append("$lt", now)));
                //System.out.println("total responses within 1 hr WEB=" + x);
               
               
               
               
           
          }
                      
         catch (Exception e)
         {
             //System.out.println(e);
         }
        return x;
   
       
    }


}