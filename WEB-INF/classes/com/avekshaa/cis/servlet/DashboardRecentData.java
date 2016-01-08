package com.avekshaa.cis.servlet;

import java.util.List;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;

public class DashboardRecentData {

	static final Logger logger = Logger.getRootLogger();
	public static Mongo m; 
	static {
		m = CommonDB.generalConnection();
	}
	
	String getcomment(double d){
		String Comment=null; 
		if(d>=70){
			Comment="Need Attention";
		} else if ((d>=50)&&(d<70)) {
			Comment="OK";
		} else if (d<50) {
			Comment="GOOD";
		}
		
			return Comment;
		
	}
	String getcolorcode(String s){
		String Color=null; 
		if(s.equals("Need Attention")){
			Color="#FF0000";
		} else if (s.equals("OK")) {
			Color="#F7FE2E";
		} else if (s.equals("GOOD")) {
			Color="#01DF01";
		}
		
			return Color;
	}

	String getTAble(String id) {
		
		DBCursor alertData = null;
		String a = "<table border='1' >";
		try {
			
			//1.connect to mongo// host+port
			
			
			//3.selcet the collection
			DB andro =m.getDB("AndroidData");
			DB cis =m.getDB("CIS");
			DBCollection Network=cis.getCollection("CISResponse");
			DBCollection cpuandmemory=cis.getCollection("CISDetails");
		
		//	//System.out.println("collection name:"+coll.getName());
			int resp= 0;		
			resp=  (int) Network.count();
			
				long	z = Network.count(new BasicDBObject("status_Code",	new BasicDBObject("$gt", 299)));
				a=a+"<tr><th>Network Status</th><th>CPU usage </th><th>Memory Usage</th></tr>";
				a = a + "<tr><td>" +z+ "<b>/</b><sub>"+ resp  +"</sub></td>";	
			
				BasicDBObject findObj = new BasicDBObject();
				alertData = cpuandmemory.find(findObj);
				alertData.sort(new BasicDBObject("_id", -1));
				alertData.limit(1);
				List<DBObject> dbObjs = alertData.toArray();
				//System.out.println("BEFORE LOOP"+dbObjs);
				for (int i = dbObjs.size() - 1; i >= 0; i--) {					
					//System.out.println("INSIDE LOOP");
					DBObject txnDataObject = dbObjs.get(i);
					Integer cpuused = (Integer) txnDataObject.get("Cpu_Used");
					Integer cpuidle = (Integer) txnDataObject.get("Cpu_Idle");
					Integer usedheap = (Integer) txnDataObject.get("Used_Heap");
					Integer unusedheap = (Integer) txnDataObject.get("UnUsed_Heap");
					//System.out.println("hii"+cpuused+cpuidle+usedheap+unusedheap);
					double percpu=(double) ((cpuused/(cpuidle+cpuused))*100);
					double memoryper=(double) ((usedheap/(usedheap+unusedheap))*100);
					String memoryComment=getcomment(percpu);
					String CPUComment =getcomment(memoryper);
					String memorycolor=getcolorcode(memoryComment);
					String CPUcolor=getcolorcode(CPUComment);
					a=a+"<td style='color:"+memorycolor+"';>"+ memoryper+"%<br>"+memoryComment+"</td>";
					a=a+"<td style='color:"+CPUcolor+"';>"+percpu+"%<br>"+CPUComment+"</td></tr>";
				
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				alertData.close();

			}
			
				
			
		
		a = a + "</table>";
//System.out.println(a);
		return a;
	}
}
