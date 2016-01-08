package com.avekshaa.cis.quartzjob;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import com.avekshaa.cis.database.CommonDB;
import com.avekshaa.cis.jio.AndroidVersionBufferScheduler;
import com.avekshaa.cis.jio.AppMapScheduler;
import com.avekshaa.cis.jio.ApplicationVersionBufferScheduler;
import com.avekshaa.cis.jio.DashBoardQuartz;
import com.avekshaa.cis.jio.WebDashBoardQuartz;
import com.avekshaa.cis.jio.WebMapScheduler;
import com.avekshaa.cis.quartzjob.oneday.OneDayAggregation;
import com.avekshaa.cis.quartzjob.oneday.OneDayAggregationWeb;
import com.mongodb.DB;

public class TestTrigger {

	// public static void main(String[] args) throws Exception {

	Scheduler scheduler = null;

	DB db = CommonDB.getConnection();

	public TestTrigger() throws Exception {
		System.out.println("Trigger called");

		JobKey WebDashBoardQuartz = new JobKey("jobA", "group1");
		JobDetail jobWebDashBoardQuartz = JobBuilder
				.newJob(WebDashBoardQuartz.class)
				.withIdentity(WebDashBoardQuartz).build();

		JobKey webResponseAvg = new JobKey("jobB", "group2");
		JobDetail jobWebResponseAvg = JobBuilder.newJob(AvgResponsePerMinWeb.class)
				.withIdentity(webResponseAvg).build();

		JobKey avgLive = new JobKey("jobC", "group3");
		JobDetail jobLive = JobBuilder.newJob(AndroidAverageCalculation.class)
				.withIdentity(avgLive).build();

		JobKey DashBoardQuartz = new JobKey("jobD", "group4");
		JobDetail jobDashBoardQuartz = JobBuilder.newJob(DashBoardQuartz.class)
				.withIdentity(DashBoardQuartz).build();

		JobKey AvgResponsePerMin = new JobKey("jobE", "group5");
		JobDetail jobAvgResponsePerMin = JobBuilder
				.newJob(AvgResponsePerMin.class)
				.withIdentity(AvgResponsePerMin).build();

		JobKey OneDayAggregation = new JobKey("jobF", "group6");
		JobDetail jobOneDayAggregation = JobBuilder
				.newJob(OneDayAggregation.class)
				.withIdentity(OneDayAggregation).build();

		JobKey OneDayAggregationWeb = new JobKey("jobG", "group7");
		JobDetail jobOneDayAggregationWeb = JobBuilder
				.newJob(OneDayAggregationWeb.class)
				.withIdentity(OneDayAggregationWeb).build();
		
		JobKey WebMapScheduler = new JobKey("jobH", "group8");
		JobDetail jobWebMapScheduler = JobBuilder
				.newJob(WebMapScheduler.class)
				.withIdentity(WebMapScheduler).build();
		
		JobKey AppMapScheduler = new JobKey("jobI", "group9");
		JobDetail jobAppMapScheduler = JobBuilder
				.newJob(AppMapScheduler.class)
				.withIdentity(AppMapScheduler).build();
		
		JobKey AndroidVersionBufferScheduler = new JobKey("jobJ", "group10");
		JobDetail jobAndroidVersionBufferScheduler = JobBuilder
				.newJob(AndroidVersionBufferScheduler.class)
				.withIdentity(AndroidVersionBufferScheduler).build();
		
		JobKey ApplicationVersionBufferScheduler = new JobKey("jobK", "group11");
		JobDetail jobApplicationVersionBufferScheduler = JobBuilder
				.newJob(ApplicationVersionBufferScheduler.class)
				.withIdentity(ApplicationVersionBufferScheduler).build();

		/*DBCursor alertData = null;

		try {

			DBCollection coll1 = db.getCollection("DurationDB");
			// //System.out.println("collection name:" + coll1.getName());

			BasicDBObject findObj = new BasicDBObject();
			alertData = coll1.find(findObj);
			alertData.sort(new BasicDBObject("_id", -1));
			alertData.limit(1);
			List<DBObject> dbObjs = alertData.toArray();

			for (int i = dbObjs.size() - 1; i >= 0; i--)

			{
				DBObject txnDataObject = dbObjs.get(i);
				int averagealerts = (Integer) txnDataObject
						.get("Average_Alerts");
				// //System.out.println("DURATION OF LIVE:" + averagealerts);

				int inci = (Integer) txnDataObject.get("Incident_Duration");
				// //System.out.println("Duration of INCIDENT" + inci);

				int usagetime = (Integer) txnDataObject.get("Usagetime");
				// //System.out.println("Duration of usage" + usagetime);
*/
				// -------Triggers-----------------------------------------//
				Trigger trigger1 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName1", "group1")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0 0/1 * * ?")).build();

				Trigger trigger2 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName2", "group2")
						.withSchedule(
								CronScheduleBuilder
								.cronSchedule("0 0/1 * * * ?")).build();

				Trigger trigger3 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName3", "group3")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0 0/1 * * ?")).build();

				Trigger trigger4 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName4", "group4")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0 0/1 * * ?")).build();
				Trigger trigger5 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName5", "group5")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0/1 * * * ?")).build();

				Trigger trigger6 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName6", "group6")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 59 23 * * ?")).build();

				Trigger trigger7 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName7", "group7")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 59 23 * * ?")).build();
				
				Trigger trigger8 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName8", "group8")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0 0/1 * * ?")).build();
				
				Trigger trigger9 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName9", "group9")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0 0/1 * * ?")).build();
				
				Trigger trigger10 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName10", "group10")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0/15 * * * ?")).build();
				
				Trigger trigger11 = TriggerBuilder
						.newTrigger()
						.withIdentity("TriggerName11", "group11")
						.withSchedule(
								CronScheduleBuilder
										.cronSchedule("0 0/15 * * * ?")).build();
				
				

				scheduler = new StdSchedulerFactory().getScheduler();
				scheduler.start();

				scheduler.scheduleJob(jobWebDashBoardQuartz, trigger1);
				scheduler.scheduleJob(jobWebResponseAvg, trigger2);
				scheduler.scheduleJob(jobLive, trigger3);
				scheduler.scheduleJob(jobDashBoardQuartz, trigger4);
				scheduler.scheduleJob(jobAvgResponsePerMin, trigger5);
				scheduler.scheduleJob(jobOneDayAggregation, trigger6);
				scheduler.scheduleJob(jobOneDayAggregationWeb, trigger7);
				scheduler.scheduleJob(jobWebMapScheduler, trigger8);
				scheduler.scheduleJob(jobAppMapScheduler, trigger9);
				scheduler.scheduleJob(jobAndroidVersionBufferScheduler, trigger10);
				scheduler.scheduleJob(jobApplicationVersionBufferScheduler, trigger11);
				

				/* scheduler.shutdown(false); */

			}
		/*} catch (Exception e) {
			e.printStackTrace();
			// logger.error("Unexpected error",e);
		} finally {
			alertData.close();
		}

	}*/
	/*
	 * public void stopQuartz() { //System.out.println("Context Destroyed"); try
	 * { scheduler.shutdown(); } catch (SchedulerException e) {
	 * e.printStackTrace(); }
	 */
}