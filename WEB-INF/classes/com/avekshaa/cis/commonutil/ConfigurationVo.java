package com.avekshaa.cis.commonutil;

/**
 * This class is VO object for all CIS configuration parameters.
 * 
 * @author Pushkar kumar
 */



/**
* This class is VO object for all CIS configuration parameters.
*
* @author Pushkar kumar
*/

public class ConfigurationVo {

   private String DBPassword = "";
   private String DBIPAddress = "";
   private String DBUserName = "";
   private int DBPort = 0;
   private String DBName = "";
   private String Email = "";
   private String Password = "";
   private String AndroidIP="";
   public String getJIODBName() {
	return JIODBName;
}

public void setJIODBName(String jIODBName) {
	JIODBName = jIODBName;
}

private String AndroidDBName="";
   private String JIODBName="";
   private String BankDBName="";
   public String getBankDBName() {
	return BankDBName;
}

public void setBankDBName(String bankDBName) {
	BankDBName = bankDBName;
}

private int Androidport=0;

   public String getDBUserName() {
       return DBUserName;
   }

   public void setDBUserName(String dBUserName) {
       DBUserName = dBUserName;
   }

   public String getDBPassword() {
       return DBPassword;
   }

   public void setDBPassword(String dBPassword) {
       DBPassword = dBPassword;
   }

   public String getDBIPAddress() {
       return DBIPAddress;
   }

   public void setDBIPAddress(String dBIPAddress) {
       DBIPAddress = dBIPAddress;
   }

   public int getDBPort() {
       return DBPort;
   }

   public void setDBPort(int dBPort) {
       DBPort = dBPort;
   }

   public String getDBName() {
       return DBName;
   }

   public void setDBName(String dBName) {
       DBName = dBName;
   }

   public String getEmail() {
       return Email;
   }

   public void setEmail(String email) {
       Email = email;
      
   }

   public String getPassword() {
       return Password;
   }

   public void setPassword(String password) {
       Password = password;
      
   }

   public String getAndroidIP() {
       return AndroidIP;
   }

   public void setAndroidIP(String dBIPAddress1) {
	   AndroidIP = dBIPAddress1;
   }

   public int getAndroidDBPort() {
       return Androidport;
   }

   public void setAndroidport(int dBPort) {
	   Androidport = dBPort;
   }

   public String getAndroidDBName() {
       return AndroidDBName;
   }

   public void setAndroidDBName(String dBName) {
	   AndroidDBName = dBName;
   }


}