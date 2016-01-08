package com.avekshaa.cis.servlet;

import org.apache.log4j.Logger;

import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

public class IPDAO {
	static final Logger logger = Logger.getRootLogger();

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	String getURL(String IP) {
		String a = "<font color='blue'><b>URL :&nbsp;&nbsp;&nbsp;&nbsp;</b> </font><select name='URL' id ='URL2'> <option value='-1'>Select URL</option>";
		try {
			DBCollection cisresponse = db.getCollection("CISResponse");
			DBObject o1 = new BasicDBObject("IP_Address", IP);
			// call distinct method by passing the field name and object o1
			java.util.List<DBObject> l1 = cisresponse.distinct("URI", o1);
			for (int i = 0; i < l1.size(); i++) {
				a = a + "<option value=" + l1.get(i) + ">" + l1.get(i)
						+ "</option>";
			}
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("Unexpected error",e);
		}

		return a;
	}
}
