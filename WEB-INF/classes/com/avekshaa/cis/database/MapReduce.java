package com.avekshaa.cis.database;

import java.net.UnknownHostException;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MapReduceCommand;
import com.mongodb.MapReduceOutput;
import com.mongodb.MongoClient;

public class MapReduce {

	public static void main(String[] args) {
		MongoClient mc = null;
		try {
			mc = new MongoClient("127.0.0.1");
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DB db = mc.getDB("testdb");
		System.out.println("DB:" + db.toString());
		DBCollection coll = db.getCollection("mycol1");
		System.out.println("Collection:" + coll.toString());

		String mapFunction = "function(){var key=this.Country;var value={Country:this.Country,total_response_time:this.response_time,count:1,avg_response_time:0};emit(key,value);}";

		String reduceFunction = "function(key,values){var reducedobject={Country:key,total_response_time:0,count:0,avg_response_time:0};values.forEach(function(value){reducedobject.total_response_time+=value.total_response_time;reducedobject.count+=value.count;});return reducedobject;}";

		String finalizeFunction = "function(key,reducedValue){if(reducedValue.count>0)reducedValue.avg_response_time=reducedValue.total_response_time/reducedValue.count;return reducedValue;}";
		double a=23;
		MapReduceCommand cmd=new MapReduceCommand(coll, mapFunction, reduceFunction, "mycol2_mapr", MapReduceCommand.OutputType.REDUCE, new BasicDBObject("exectime",new BasicDBObject("$gt",a)).append("Country", "India"));
		cmd.setFinalize(finalizeFunction);
		MapReduceOutput out = coll.mapReduce(cmd);
		System.out.println("mapr:" + out.getRaw());

		for (DBObject obj1 : out.results()) {
			System.out.println(obj1);
		}

	}

}
