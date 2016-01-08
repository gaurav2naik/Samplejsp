package com.avekshaa.cis.commonutil;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

public class Convertor {
	static final Logger logger = Logger.getRootLogger();

	public static long timeInMilisecond(String timeinstring) {

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

		Date start = null;
		try {
			start = sdf.parse(timeinstring);
		} catch (ParseException e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}

		long t1 = start.getTime();
		return t1;

	}

	public static String timeInHighChartFormat(Long timeinmilisecond) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy,MM-1,dd,HH,mm,ss,SSS");
		String timeInDateFormat = sdf.format(timeinmilisecond);
		return timeInDateFormat;
	}

	public static String timeInDefaultFormat(Long timeinmilisecond) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		String timeInDateFormat = sdf.format(timeinmilisecond);
		return timeInDateFormat;
	}

	private static void getMilliSecondToSecond(int millis) {
		long timeMillis = System.currentTimeMillis();
		long timeSeconds = TimeUnit.MILLISECONDS.toSeconds(timeMillis);
		System.out.println(timeSeconds);
		// return 0;
	}
	public static String timeInDateFormat(Long timeinmilisecond) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
		String timeInDateFormat = sdf.format(timeinmilisecond);
		return timeInDateFormat;
	}
	public static double converByteToKB(double value) {

		// convert to KB
		value = Double.parseDouble(new DecimalFormat("##.##")
				.format((value * 1000) / (1000 * 1024)));
		// System.out.println(" KB : "+value);
		return value;
	}

	public static double converByteToMB(double value) {

		// convert to KB
		value = Double.parseDouble(new DecimalFormat("##.##")
				.format((value * 1000) / (1000 * 1024 * 1024)));
		// System.out.println("MB :" +value);
		return value;
	}
	public static String converByte(double value) {
		String convertedRate="";
		
		
		if(value>(1024*1024))
		{
			value = Double.parseDouble(new DecimalFormat("##.##")
			.format((value * 1000) / (1000 * 1024 * 1024)));
			convertedRate = value+" MB/s";			
			//System.out.println(mbRate);
		}
		else if(value > 1024)
		{

			value = Double.parseDouble(new DecimalFormat("##.##")
			.format((value * 1000) / (1000 * 1024)));
			convertedRate = value+" KB/s";
		//	System.out.println(kbRate);
		}
		else
			convertedRate = value+" Bytes/s";
		
		
		return convertedRate;
	}
	public static void main(String[] args) {
		getMilliSecondToSecond(1000);
	}
}
