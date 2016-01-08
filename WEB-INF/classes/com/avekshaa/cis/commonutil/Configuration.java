package com.avekshaa.cis.commonutil;

import java.io.IOException;
import org.apache.log4j.Logger;

public class Configuration {
	static final Logger logger = Logger.getRootLogger();

	private static ConfigurationVo vo = null;

	public static ConfigurationVo configure() throws IOException {

		try {
			if (vo == null) {
				vo = new ConfigurationVo();
				 vo.setDBIPAddress("52.24.170.28");
//				vo.setDBIPAddress("127.0.0.1");
				vo.setDBName("CIS");
				// vo.setDBName("CISPT");
				vo.setDBPort(27017);
				vo.setEmail("alerts@avekshaa.com");
				vo.setPassword("Aish@kulkarni");
				vo.setAndroidDBName("NewJIOData");
				vo.setJIODBName("NewJIOData");
				vo.setBankDBName("AndroidDataForBank");
				// vo.setAndroidport(27017);
				// vo.setAndroidIP("52.24.170.28");
				// vo.setAndroidIP("127.0.0.1");
			}
		} catch (Exception e) {
			// e.printStackTrace();
			logger.error("Unexpected error", e);
		}
		return vo;
	}

}
