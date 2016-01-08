package com.avekshaa.cis.engine;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class testgeoJSON {

	
	
	public static DB db;
	static {
		db = CommonDB.AndroidConnection();
	}
	
	public static DB db1;
	static {
		db1 = CommonDB.getConnection();
	}

	/*public static DB db;
    static
    {
        db = CommonDB.getConnection();
    	Mongo mm = new Mongo("127.0.0.1", 27017);

		// 2.connect to your DB
		DB db = mm.getDB("AndroidData");
       
    }*/
public static void main(String[] args) {
	

   // public String  GenerateJSonChartDataYearWisePassPercentage(String jsonp) throws  JSONException
    {
    
 
    
 
    JSONObject  finalGEOJSonObj=new JSONObject();
    JSONObject  THresholdData=new JSONObject();
    JSONArray datarr = new JSONArray();
    JSONArray thresholdfinal = new JSONArray();
    JSONArray finalJSONarray = new JSONArray();
    JSONObject finalJSON = new JSONObject();
    MapData cd;
  //  Integer res=null;
   
 
   
    
    DBCursor alertData =null;
    DBCursor alertData1 =null;
  
   
    try {
      //  DB db = COmmonDB.getConnection();
    	/*Mongo mm = new Mongo("52.24.170.28", 27017);

		// 2.connect to your DB
		DB db = mm.getDB("AndroidData");*/

        DBCollection cisresponse = db.getCollection("usage");
        BasicDBObject findObj = new BasicDBObject();

DBCollection threshold=db1.getCollection("ThresholdDB");
//System.out.println("IN threshold DAO"+coll.getName());



//fetch name
BasicDBObject findObj1 = new BasicDBObject();
alertData1 = threshold.find(findObj1);
alertData1.sort(new BasicDBObject("_id", -1));

alertData1.limit(1);
List<DBObject> thresholddbObjs = alertData1.toArray();
//System.out.println(thresholddbObjs);
/*for (int i = thresholddbObjs.size() - 1; i >= 0; i--)

{*/
    DBObject txnDataObject = thresholddbObjs.get(thresholddbObjs.size() - 1);
    Integer threshold11 = (Integer) txnDataObject.get("Android_thresholds");
     System.out.println("Thresolrtyd "+threshold11);
     Double yellow=0.70*threshold11;
     
     JSONObject thresholdgreen=new JSONObject();
 //	JSONArray thresholdgreenArray =new JSONArray();
 	JSONObject thresholdyellow=new JSONObject();
 	//JSONArray thresholdyellowArray =new JSONArray();
 	JSONObject thresholdred=new JSONObject();
 	//JSONArray thresholdredArray =new JSONArray();
 	
     
     
     thresholdgreen.put("color", "#008000");
     thresholdgreen.put("to", yellow);
     thresholdgreen.put("from", 0);
   //  thresholdgreenArray.put(thresholdgreen);
     thresholdyellow.put("color", "#FFFF00");
     thresholdyellow.put("to", threshold11);   
     thresholdyellow.put("from", yellow);          
    // thresholdyellowArray.put(thresholdyellow);
     thresholdred.put("color", "#FF0000");
     thresholdred.put("from", threshold11);
   // thresholdredArray.put(thresholdred);
     thresholdfinal.put(thresholdgreen);
     thresholdfinal.put(thresholdyellow);
     thresholdfinal.put(thresholdred);
  //   System.out.println(thresholdgreenArray);
  //   System.out.println(thresholdyellowArray);
    // System.out.println(thresholdredArray);
    // System.out.println("FINAL THRESHOLD"+thresholdfinal);
      
//}
//System.out.println("Thresold "+res);
       
    alertData = cisresponse.find(findObj);      
    alertData.sort(new BasicDBObject("_id", -1));	
  
   

        List<DBObject> dbObjs = alertData.toArray();
        String data = null;
        DBObject dbo = dbObjs.get(0);//-----------------
        
        
        ArrayList<String> codelist = new ArrayList<String>();//code
        ArrayList<Object> avglist = new ArrayList<Object>();//avg
        
        for ( String key : dbo.keySet() )
        {
                                 //System.out.println( "key: " + key + " value:" + dbo.get( key ) );
                                
                                 //STORE KEY IN LIST.....
                               
                                 codelist.add(key);
                                avglist.add( dbo.get( key ));
                               
                                //format->'samsung'                           
                               
                                
                                
                             }
        
        //System.out.println("HIII"+codelist+""+avglist);
        
        

        for (int i = 1; i < codelist.size(); i++) {
                   	
        	JSONObject dataspecific =new JSONObject();
        	
        
       
      //   sb.append("{name: '"+codelist.get(i)+"',data: ["+avglist.get(i)+"], stack: '"+codelist.get(i)+"'},");  
      //   //System.out.println("build"+sb);
       
        
        cd=new MapData();
       cd.setCode(codelist.get(i));
       
      /* Double d=Double.parseDouble((String)avglist.get(i));
       cd.setavg(d);*/
          cd.setavg((Double)avglist.get(i));
          dataspecific.put("code",cd.getCode());
          dataspecific.put("value",cd.getavg());
          datarr.put(dataspecific);
          
        }
     
           
        }
     catch (Exception e) {
        e.printStackTrace();
    }
    finally{
    	alertData.close();
    	alertData1.close();
    }
 

        try {
        	THresholdData.put("dataClasses", thresholdfinal);
        	finalGEOJSonObj.put("GeoData", datarr);
        	finalJSONarray.put(THresholdData);
        	finalJSONarray.put(finalGEOJSonObj);
        	finalJSON.put("finalGEO", finalJSONarray);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    //   String  tempStr=jsonp+"("+finalJSonObj.toString()+")";
        //System.out.println(tempStr);
        System.out.println(finalJSON.toString());
    //    return tempStr;
    //    String  tempStr=jsonp+"("+finalJSonObj.toString()+")";
 
        //return tempStr;
}
}
}
