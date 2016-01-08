package com.avekshaa.cis.servlet;

public class ConfigBean {
	private int incident;
	private int response;
    private int alerts;
    public boolean valid;

	
	//incident threshold
	public int getIncident() {
		return incident;
	}

	public void setIncident(int newIncident) {
		incident = newIncident;
	}

	
	//response threshold
	public int getResponse() {
		return response;
	}

	public void setResponse(int res) {
		response =res;
	}
	public int getAlerts() {
		return alerts;
	}

	public void setAlerts(int alert) {
		alerts =alert;
	}
	
	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean newValid) {
		valid = newValid;
	}
	
	
	

}
