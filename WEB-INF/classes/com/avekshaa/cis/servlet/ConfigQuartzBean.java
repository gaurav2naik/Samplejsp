package com.avekshaa.cis.servlet;

public class ConfigQuartzBean {
	private int incident;
	private int response;
	private int usage ;


	
	//incident threshold
	public int getIncident() {
		return incident;
	}

	public void setIncident(int newIncident) {
		incident = newIncident;
	}

	
	//response threshold
	public int getLiveAlerts() {
		return response;
	}

	public void setLiveAlerts(int res) {
		response =res;
	}
	
	public int getUsgagetime() {
		return usage;
	}

	public void setUsagetime(int res) {
		usage =res;
	}

	
	
	

}
