package com.avekshaa.cis.quartzjob;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import org.json.JSONArray;
import org.json.JSONObject;

import com.avekshaa.cis.commonutil.Convertor;
import com.avekshaa.cis.database.CommonDB;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
//import com.sun.org.apache.bcel.internal.generic.NEW;

public class Test {

	public static DB db1;
	static {
		db1 = CommonDB.AndroidConnection();
	}

	// DB db2 = CommonDB.getConnection();
	// CIS

	public static DB db2;
	static {
		db2 = CommonDB.getConnection();
	}

	public static void main(String[] args) {

		/*
		 * try { String perc = null;
		 * 
		 * //----------------------------------DB
		 * CONNCETION----------------------
		 * ----------------------------------------------- // 1.connect to
		 * mongo// host+port
		 * 
		 * 
		 * 
		 * DB db = CommonDB.AndroidConnection(); DBCollection regular=
		 * db.getCollection("Regular"); DBCollection AndoidAvg
		 * =db.getCollection("Android_Avg"); BasicDBObject doc = new
		 * BasicDBObject();
		 * 
		 * DBObject groupFields = new BasicDBObject( "_id", "$Mobilename");
		 * groupFields.put("averageresponse", new BasicDBObject( "$avg",
		 * "$duration")); DBObject group = new BasicDBObject("$group",
		 * groupFields); // group.put("$sort", new
		 * BasicDBObject("totalhit",-1)); DBObject sort = new
		 * BasicDBObject("$sort", new BasicDBObject("averageresponse",-1)); //
		 * DBObject limit = new BasicDBObject("$limit",5); AggregationOutput
		 * output = regular.aggregate( group ,sort );
		 * 
		 * for (DBObject result : output.results()) {
		 * 
		 * 
		 * if (!(result.get("_id").toString().startsWith("generic"))){
		 * 
		 * 
		 * double avg1 = (Double)(result.get("averageresponse"));
		 * 
		 * 
		 * double avg2 = (double) Math.round(avg1);
		 * 
		 * 
		 * doc.put(result.get("_id").toString(), avg2);
		 * //finalMap.put(Device_name, avg2);
		 * 
		 * } ////System.out.println("FINAL MAPl:" + finalMap); }
		 * System.out.println(doc); //AndoidAvg.insert(doc);
		 * 
		 * }
		 * 
		 * catch (Exception e)
		 * 
		 * { e.printStackTrace(); }
		 */

		long now = System.currentTimeMillis();
		// System.out.println("current time 11" + now);
		System.out.println("GEO CALCULATION"
				+ Convertor.timeInDefaultFormat(now));

		Collection<String> hs1 = new HashSet<String>();
		Collection<String> hs2 = new HashSet<String>();

	//	BasicDBObject document = new BasicDBObject();
		TreeMap<String, Double> Document = new TreeMap<String , Double>();

		try {

			DBCollection collAnd = db1.getCollection("Regular");
			hs1 = collAnd.distinct("country");

			DBCollection collWeb = db2.getCollection("CISResponse");
			hs2 = collWeb.distinct("Country");

			Collection set3 = new HashSet<String>();
			set3.addAll(hs1);
			set3.addAll(hs2);
			String Code = null;

			Iterator iterator1 = set3.iterator();
			System.out.println(set3);
			// check values
			while (iterator1.hasNext()) {
				String Country = iterator1.next().toString();
				if (!(Country.length() == 0)) {
					if (!(Country.startsWith("GPS"))) {
						if (!(Country.startsWith("Unkn"))) {
							Code = MapCode.Code(Country);
							if (!Code.startsWith("INVA")) {
								List<Double> response = new ArrayList<Double>();
								{
									String c = Country;
									System.out.println(c);
									DBCollection Androidweb = db1 .getCollection("Regular");
									DBObject findcountry = new BasicDBObject("$match", new BasicDBObject("country", Country));

									DBObject groupFields = new BasicDBObject(
											"_id", new BasicDBObject( "$literal", null));

									groupFields.put("averageresponse",
											new BasicDBObject("$avg","$duration"));

									DBObject group = new BasicDBObject(
											"$group", groupFields);

									AggregationOutput output = Androidweb
											.aggregate( findcountry , group);

									// System.out.println(output);

									for (DBObject result : output.results()) {
									//	System.out.println(result);
										double avg1 = (Double) (result
												.get("averageresponse"));
									//	System.out.println(Country + "  1  "									+ avg1);
										response.add(avg1);
										// System.out.println("respp:"+resp);.

									}
								}
								 BasicDBObject webavg = new BasicDBObject();
							{
									DBCollection WebAvg = db2
											.getCollection("CISResponse");
									DBObject findcountry = new BasicDBObject("$match", new BasicDBObject("Country", Country));

									DBObject groupFields1 = new BasicDBObject(
											"_id", new BasicDBObject( "$literal", null));
									groupFields1.put("averageresponse",
											new BasicDBObject("$avg",
													"$response_time"));
									DBObject group1 = new BasicDBObject(
											"$group", groupFields1);
									AggregationOutput output1 = WebAvg
											.aggregate(findcountry , group1);

									for (DBObject result : output1.results()) {
//System.out.println(result);
										double avg2 = (Double) (result
												.get("averageresponse"));

									//	System.out.println(Country + " 2  "	+ avg2);

										response.add(avg2);
									}
								}
								double sum = 0;

								for (Double i2 : response) {
									sum += i2;

								}
								// System.out.println("sum:" + sum);
								// System.out.println(myList);
								double avg1 = (sum / 2);
								// System.out.println("avgg:" + avg1);
								// System.out.println("-----------------");

							double avg2 = (double) Math.round(avg1);

							//	finalMap.put(Country, avg2);
								// System.out.println("Country:"+Country +" avg:" + avg2 +" Code "+Code);
							Document.put(Code, avg2);

							}

						}
					}
				}

			
			
			
			}
			System.out.println(Document);
			System.out.println("DONE");
			// insertUsage.insert(document);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
