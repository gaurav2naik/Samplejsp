package com.avekshaa.cis.servlet;

import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;

import org.apache.log4j.Logger;
import org.omg.CORBA.CTX_RESTRICT_SCOPE;

import com.avekshaa.cis.commonutil.*;
import com.avekshaa.cis.database.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;

public class ConfigQuartzDAO 
{
	//static final Logger logger = Logger.getRootLogger();
	public static DB m;
	static {
		m = CommonDB.getConnection();
	}

	public static ConfigQuartzBean configMtd(ConfigQuartzBean bean) {

		int incident = bean.getIncident();
	int averagealerts = bean.getLiveAlerts();
	int usage =bean.getUsgagetime();
	
	
	
	////System.out.println(alert+usage+incident+name);
		try {
			
			
			
			//1.connect to mongo// host+port
			/*Mongo m=new Mongo("127.0.0.1",27017);
		
			
			//2.connect to your DB
			DB db=m.getDB("CIS");
			//System.out.println("DB Name:"+db.getName());*/
			
			//3.select the collection
			DBCollection coll=m.getCollection("DurationDB");
			//System.out.println("MMM:"+coll.getName());
			
			
			//Insert Document into collection
			BasicDBObject document = new BasicDBObject();
			document.put("Average_Alerts",averagealerts);
			document.put("Incident_Duration", incident); 
			document.put("Usagetime", usage); 
			
	
			
			coll.insert(document);
		//CronTriggerExample cat = new  CronTriggerExample(incident , alert , usage);
		}

		catch (Exception ex) {
		/*	//System.out.println("Log In failed: An Exception has occurred! "
					+ ex);*/
			ex.printStackTrace();
			//logger.error("Unexpected error",ex);
		}

		return bean;

	}

}