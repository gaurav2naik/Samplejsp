package com.avekshaa.cis.engine;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.TreeMap;
import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class LiveResponseCustomized {

	public static DB db;
	static {
		db = CommonDB.getConnection();
	}

	static final Logger logger = Logger.getRootLogger();
	
	public TreeMap<Long, String> getIPandURI(String startTime, String endTime) {
		DBCursor alertData = null;
		long t1 = Convertor.timeInMilisecond(startTime);
		long t2 = Convertor.timeInMilisecond(endTime);
		TreeMap<Long, String> rexecandresp = new TreeMap<Long, String>();
		DBObject exectime = null;
		try {

			DBCollection cisresponse = db.getCollection("CISResponse");
			BasicDBObject gtQuery = new BasicDBObject();
			gtQuery.put("exectime",
					new BasicDBObject("$gt", t1).append("$lt", t2));
			alertData = cisresponse.find(gtQuery).sort(exectime);
			alertData.sort(new BasicDBObject("_id", -1));
			// //System.out.println("alert d daata" + alertData);
			alertData.limit(205);
			List<DBObject> dbObjs = alertData.toArray();
			// //System.out.println("dbo object  " + dbObjs.size() );

			if (dbObjs.size() > 200) {
				// //System.out.println("LOOP 1");
				for (int i = dbObjs.size() - 1; i >= dbObjs.size() - 200; i--) {
					DBObject txnDataObject = dbObjs.get(i);
					String IP = (String) txnDataObject.get("IP_Address");
					String URI = (String) txnDataObject.get("URI");
					Long execTime = (Long) txnDataObject.get("exectime");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					int responseTime = (int) responseTi;
					rexecandresp.put(execTime, IP + "&&" + URI + "&&"
							+ responseTime);
				}
			}

			else {
				for (int i = dbObjs.size() - 1; i >= 0; i--) {
					DBObject txnDataObject = dbObjs.get(i);
					String IP = (String) txnDataObject.get("IP_Address");
					String URI = (String) txnDataObject.get("URI");
					Long execTime = (Long) txnDataObject.get("exectime");
					double responseTi = Double.parseDouble(txnDataObject.get(
							"response_time").toString());
					int responseTime = (int) responseTi;
					rexecandresp.put(execTime, IP + "$$" + URI + "$$"
							+ responseTime);
				}
			}

		} catch (Exception e) {
			//e.printStackTrace();
			logger.error("Unexpected error", e);
		} finally {
			alertData.close();
		}
		return rexecandresp;
	}
}
