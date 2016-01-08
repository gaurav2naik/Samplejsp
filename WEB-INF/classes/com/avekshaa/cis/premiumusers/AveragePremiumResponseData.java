package com.avekshaa.cis.premiumusers;

import java.util.List;

public class AveragePremiumResponseData 
{
	static public String a,b,c,d,e,f;
	public AveragePremiumResponseData(List<String> arr)
	{
		System.out.println("CALLING INSIDE pREMIUM DATA CALCULATION");
		int i = arr.size();
		System.out.println(" ===================================="+i);
		String s = String.valueOf(i);
		switch(s)
		{
				case "2": 
					new AveragePremiumResponseData(arr.get(0),arr.get(1));
					break;
				case "3": System.out.println("calling constructor"+arr.get(0)+" " +arr.get(1)+"  "+arr.get(2));
					new AveragePremiumResponseData(arr.get(0),arr.get(1),arr.get(2));
					break;
				case "4"://System.out.println("calling constructor"+arr.get(0)+" " +arr.get(1)+"  "+arr.get(2)); 
					new AveragePremiumResponseData(arr.get(0), arr.get(1), arr.get(2),arr.get(3));
					break;
				case "5": new AveragePremiumResponseData(arr.get(0), arr.get(1), arr.get(2),arr.get(3),arr.get(4));
					break;
				case "6":new AveragePremiumResponseData(arr.get(0), arr.get(1), arr.get(2),arr.get(3),arr.get(4),arr.get(5));
					break;
					default: break;
		}
	}
	
	public AveragePremiumResponseData(String a,String b,String c,String d,String e,String f)
	{
		this.a=a;
		this.b=b;
		this.c=c;
		this.d=d;
		this.e=e;
		this.f=f;
	
	}
	public AveragePremiumResponseData(String a,String b,String c,String d,String f)
	{
		this.a=a;
		this.b=b;
		this.c=c;
		this.d=d;
		this.f=f;
	
	}
	public AveragePremiumResponseData(String a,String b,String c,String f)
	{
		//System.out.println("3rd block of constructor");
		this.a=a;
		this.b=b;
		this.c=c;
		this.f=f;
	}
	public AveragePremiumResponseData(String a,String b, String f)
	{
		System.out.println("3rd block of constructor");
		this.a=a;
		this.b=b;
		this.f=f;
	}
	public AveragePremiumResponseData(String a,String f)
	{
		this.a=a;
		this.f= f; 
	}

}
