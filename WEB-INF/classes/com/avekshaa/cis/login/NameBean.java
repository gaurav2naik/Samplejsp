package com.avekshaa.cis.login;

public class NameBean {

	static String lastName;

	public void setLastName(String newLastName) // setter
	{
		lastName = newLastName;
		//System.out.println("---" + lastName);
	}

	public String getLastName() // getter
	{
		//System.out.println("get from DAO" + lastName);

		return lastName;
	}

}
