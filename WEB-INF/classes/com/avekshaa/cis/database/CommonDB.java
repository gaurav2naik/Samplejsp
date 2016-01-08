package com.avekshaa.cis.database;

import java.io.IOException;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;

import com.avekshaa.cis.commonutil.Configuration;
import com.avekshaa.cis.commonutil.ConfigurationVo;
import com.mongodb.DB;
import com.mongodb.MongoClient;

public class CommonDB {
	static final Logger logger = Logger.getRootLogger();
	/*
	 * 
	 * static ConfigurationVo vo = null;
	 * 
	 * static { try { vo = Configuration.configure();
	 * 
	 * } catch (IOException e) { //e.printStackTrace();
	 * logger.error("Unexpected error",e);
	 * 
	 * } }
	 */
	static ConfigurationVo vo = null;
	static public MongoClient m = null;
	static {
		try {
			vo = Configuration.configure();
			if (m == null) {
				m = new MongoClient(vo.getDBIPAddress(), vo.getDBPort());
			}
		} catch (UnknownHostException ex) {
			ex.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	

	public static synchronized DB getConnection() {
		DB db = null;

		try {
			//MongoClient m = new MongoClient(vo.getDBIPAddress(), vo.getDBPort());
			db = m.getDB(vo.getDBName());
		} catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}
		// //System.out.println("DDDDBBBB"+db);
		return db;
	}

	public static synchronized  DB AndroidConnection() {
		DB db = null;

		try {
			db = m.getDB(vo.getAndroidDBName());
		} catch (Exception e) {
			 e.printStackTrace();
		//	logger.error("Unexpected error", e);
		}
		// //System.out.println("DDDDBBBB"+db);
		return db;
	}
	
	public static synchronized  DB JIOConnection() {
		DB db = null;

		try {
			db = m.getDB(vo.getJIODBName());
		} catch (Exception e) {
			 e.printStackTrace();
		//	logger.error("Unexpected error", e);
		}
		// //System.out.println("DDDDBBBB"+db);
		return db;
	}
	public static synchronized  DB getBankConnection() {
		DB db = null;

		try {
			db = m.getDB(vo.getBankDBName());
		} catch (Exception e) {
			 e.printStackTrace();
		//	logger.error("Unexpected error", e);
		}
		// //System.out.println("DDDDBBBB"+db);
		return db;
	}
	public static synchronized MongoClient generalConnection() {
		MongoClient n = null;

		try {
			n = m;

		} catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}
		// //System.out.println("DDDDBBBB"+db);
		return n;
	}
}
