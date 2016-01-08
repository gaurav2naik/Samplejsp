package com.avekshaa.cis.database;

/**
 * Copyright (C) 2013 Charles Andrews
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
 * associated documentation files (the "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
 * copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the 
 * following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial 
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.bson.types.ObjectId;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MapReduceCommand;
import com.mongodb.MapReduceOutput;



/**
 * Wraps the MongoDB Java Driver Map/Reduce functionality to provide an "incremental" Map/Reduce
 * which only performs the given Map/Reduce functions on documents inserted since the last time
 * this was run. 
 * <p>
 * This uses the concepts of "savepoints" to keep a record of the latest record which was included
 * in a run of the Map/Reduce functions. The data which is being Map/Reduced <b>must</b> use BSON
 * {@link ObjectId}s in order for this to be possible. There is no locking provided to prevent
 * concurrent execution of multiple instances of this class which operate on the same data. The
 * mapReduce() function is blocking, but multiple instances could provide unwanted results. 
 *  
 * @author Charles Andrews
 */

public class IncrementalMapReduce {
    
	private final String map;
	private final String reduce;
	private final String key;
	private DBCollection coll;
	private DBCollection savePointCollection;
	private Map<String, Object> externalQuery;
	
	
	
	/**
	 * Create an instance of incremental Map/Reduce. {@link BasicDBObject} extends {@link Map<String, Object}
	 * so the external query argument can be passed as a {@link BasicDBObject} or any instance of
	 * {@link Map<String, Object>}
	 * 
	 * @param collection			The collection which the Map/Reduce should be performed on.
	 * @param savePointCollection		The collection which the savepoints should be saved to. This can
	 * 						be the same collection as the Map/Reduced data will be sourced
	 * 						from or written to, but it is recommended to keep these in a
	 * 						separate collection.
	 * @param mapFuction			The Map function.
	 * @param reduceFuction			The Reduce function.
	 * @param key				The collection which the Map/Reduce results will be saved to
	 * 						and the key of the savepoint. 
	 * @param externalQuery			Any additional query arguments to be applied.
	 */
	public IncrementalMapReduce(DBCollection collection, DBCollection savePointCollection,
			String mapFuction, String reduceFuction, String key, Map<String, Object> externalQuery) {
		this.map = mapFuction;
		this.reduce = reduceFuction;
		this.key = key;
		this.coll = collection;
		this.savePointCollection = savePointCollection;
		this.externalQuery = externalQuery;
	}
	
	/**
	 * Run the created Map/Reduce function against any new records inserted in <code>collection</code>
	 */
	public void mapReduce()
	{
		ObjectId savepoint = this.getSavepoint();
		ObjectId lastInserted = this.getLastInserted();
		
		Map<String, Object> rangeQuery = new HashMap<String, Object>();
		rangeQuery.put("$lte", lastInserted);
		rangeQuery.put("$gt", savepoint);
		Map<String, Object> query = new HashMap<String, Object>();
		query.put("_id", rangeQuery);
		query.putAll(this.externalQuery);
		BasicDBObject builtQuery = new BasicDBObject(query);

		MapReduceOutput results = coll.mapReduce(map, reduce, key, MapReduceCommand.OutputType.REDUCE, builtQuery);	
		
		if (results.getCommandResult().ok()){
			BasicDBObject reachedSavePoint = new BasicDBObject("key", this.key).append("savepoint", lastInserted); 
			savePointCollection.update(new BasicDBObject("key", this.key), reachedSavePoint, true, false);
		}
	}
	
	private ObjectId getSavepoint()
	{
		BasicDBObject query = new BasicDBObject("key", this.key); 
		DBObject savepoint = savePointCollection.findOne(query);
		if (savepoint != null)
		{
			return (ObjectId) savepoint.get("savepoint");
		}else{
			return new ObjectId(new Date(0));
		}
	}
	
	private ObjectId getLastInserted()
	{
		BasicDBObject sort = new BasicDBObject("_id", -1);
		DBObject latest = coll.findOne(null, null, sort);
		if (latest != null)
		{
			return (ObjectId)latest.get("_id");
		}else{
			return new ObjectId(new Date(0));
		}
	}
	
}