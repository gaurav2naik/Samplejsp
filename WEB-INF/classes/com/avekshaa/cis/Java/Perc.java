package com.avekshaa.cis.Java;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;

public class Perc {
	public static MongoClient m;
	static {
		m = CommonDB.generalConnection();
	}
//    public static void main(String[] args)
   
    public int mtd()
    {
       
       
    //------------------------------------------Error--------------------------------------------   
        long z=0;
        int ans=0;
                int resp= 0;
                try {
                   
                    //1.connect to mongo// host+port
                  
               
                    //2.connect to your DB
                    DB db=m.getDB("CIS");
                    //System.out.println("DB Name:"+db.getName());
                   
                    //3.selcet the collection
                    DBCollection coll=db.getCollection("CISResponse");
                    //System.out.println("collection name:"+coll.getName());
                   
                    //3.selcet the collection
                   
                   
               
                //    //System.out.println("collection name:"+coll.getName());
                           
                    resp=  (int) coll.count();
                   
                            z = coll.count(new BasicDBObject("status_Code",    new BasicDBObject("$gt", 299)));
                           
                           
                            int val = (int) z;
                            //System.out.println("error:"+val);
                           
                           
                           
//-------------------------------------------------------------------------------------------------------
                           
                           
                           
    //----------------------success-----------------------------------------------------
                           
                           

                            //3.selcet the collection
                            DB andro =m.getDB("AndroidData");
                            DB cis =m.getDB("CIS");
                            DBCollection Network=cis.getCollection("CISResponse");
                            DBCollection cpuandmemory=andro.getCollection("Regular");
                       
                        //    //System.out.println("collection name:"+coll.getName());
                                   
                            int androcount=  (int) Network.count();
                            int webcount =(int) cpuandmemory.count();           
                            int count=androcount+webcount;
                           
                       
                            //System.out.println("succ:"+count);
                           
                           
                           
                           
                    ans= (int)((val*100)/count);   
                    //System.out.println("per:"+ans);
                   
                       
                       
            } catch (Exception e) {
                e.printStackTrace();
            }
                return ans;
           
       
       
       
       
       
       
       
       
    }
   
   
   
   
   
   

}