package edu.pitt.bank;

import edu.pitt.utilities.Security;

public class Tester {
	
	public static void main(String[] args) {
		Security s = new Security();
		Customer c = s.validateLogin("nmarcus", 8125);
		System.out.println(c.getLastName());
		System.out.println("lol");
	}

}
