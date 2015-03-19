package edu.pitt.bank;


import java.sql.ResultSet;
import java.sql.SQLException;

import edu.pitt.utilities.MySqlUtilities;
import edu.pitt.utilities.ErrorLogger;
import edu.pitt.utilities.Security;


public class Test {

	public static void main(String[] args) {
		
		Security s = new Security();
		Customer c = s.validateLogin("nmarcus", 8125);
		System.out.println(c.getLastName());
		System.out.println("lol");


	}

}
