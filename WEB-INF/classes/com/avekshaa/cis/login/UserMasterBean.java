package com.avekshaa.cis.login;

public class UserMasterBean {

	private String username;
	private String password;
	private String userid;
	private String Premiumuser;
	private String mobile;
	private String email;
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public boolean valid;

	public String getUserId() {
		return userid;
	}

	public void setUserId(String newUserId) {
		userid = newUserId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String newPassword) {
		password = newPassword;
	}

	public String getUsername() {
		return username;
	}

	public void setUserName(String newUsername) {
		username = newUsername;
	}
	

	public String getPremiumuser() {
		return Premiumuser;
	}

	public void setPremiumuser(String premiumuser) {
		Premiumuser = premiumuser;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean newValid) {
		valid = newValid;
	}

	public void setMobile(String mobileno) {
		// TODO Auto-generated method stub
		mobile=mobileno;
		
	}
}
