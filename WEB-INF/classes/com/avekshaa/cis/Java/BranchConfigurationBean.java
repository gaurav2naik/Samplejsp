package com.avekshaa.cis.Java;

public class BranchConfigurationBean {
	String Identification_code;
	String Branch_Name;
	String IP_address;

	public String getIdentification_code() {
		return Identification_code;
	}

	public void setIdentification_code(String identification_code) {
		Identification_code = identification_code;
	}

	public String getBranch_Name() {
		return Branch_Name;
	}

	public void setBranch_Name(String branch_Name) {
		Branch_Name = branch_Name;
	}

	public String getIP_address() {
		return IP_address;
	}

	public void setIP_address(String iP_address) {
		IP_address = iP_address;
	}

	@Override
	public String toString() {
		return "Abc [Identification_code=" + Identification_code
				+ ", Branch_Name=" + Branch_Name + ", IP_address=" + IP_address
				+ "]";
	}

}
