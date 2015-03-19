package edu.pitt.bank;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

import edu.pitt.utilities.DbUtilities;
import edu.pitt.utilities.MySqlUtilities;



public class Customer {
	private String customerID;
	private String firstName;
	private String lastName;
	private String ssn;
	private String streetAddress;
	private String city;
	private String state;
	private int zip;
	private String loginName;
	private int pin;
	private ArrayList<String> permissions = new ArrayList<String>();
	
	public Customer(String customerID){
		String sql = "SELECT * FROM jcp65_bank1017.customer JOIN ";
		sql += "jcp65_bank1017.user_permissions ON  jcp65_bank1017.customer.customerID = ";
		sql += "jcp65_bank1017.user_permissions.groupOrUserID JOIN ";
		sql += "jcp65_bank1017.groups ON ";
		sql += "jcp65_bank1017.user_permissions.groupID = ";
		sql += "jcp65_bank1017.groups.groupID WHERE ";
		sql += "customerID = '" + customerID + "';";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			while(rs.next()) {
				this.customerID = rs.getString("customerID");
				this.firstName = rs.getString("firstName");
				this.lastName = rs.getString("lastName");
				this.ssn = rs.getString("ssn");
				this.streetAddress = rs.getString("streetAddress");
				this.city = rs.getString("city");
				this.state = rs.getString("state");
				this.zip = rs.getInt("zip");
				this.loginName = rs.getString("loginName");
				this.pin = rs.getInt("pin");
				permissions.add(rs.getString("groupName"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public Customer(String lastName, String firstName, String ssn, String loginName, int pin, String streetAddress, String city, String state, int zip){
		this.customerID = UUID.randomUUID().toString();
		this.lastName = lastName;
		this.firstName = firstName;
		this.ssn = ssn;
		this.loginName = loginName;
		this.pin = pin;
		this.streetAddress = streetAddress;
		this.city = city;
		this.state = state;
		this.zip = zip;

		String sql = "INSERT INTO jcp65_bank1017.customer ";
		sql += "VALUES (";
		sql += "'" + this.customerID + "', ";
		sql += "'" + this.lastName + "', ";
		sql += "'" + this.ssn + "', ";
		sql += "'" + this.firstName + "', ";
		sql += "'" + this.streetAddress + "', ";
		sql += "'" + this.city + "', ";
		sql += "'" + this.state + "', ";
		sql += "'" + this.zip + "', ";
		sql += "'" + this.loginName + "', ";
		sql += this.pin + "); ";

		DbUtilities db = new MySqlUtilities();
		db.executeQuery(sql);
		
	}
	
	public String getCustomerID(){
		return this.customerID;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public String getLastName(){
		return this.lastName;
	}

	public ArrayList<String> getGroups(){
		return this.permissions;
	}

}
