package edu.pitt.utilities;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import edu.pitt.bank.Customer;

public class Security {

	private String userID;

	public Customer validateLogin(String loginName, int pin){
		String sql = "SELECT * FROM jcp65_bank1017.customer WHERE ";
		sql += "loginName = '" + loginName + "'"; 
		sql += "AND pin = '" + pin + "';";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			if (rs.next()) {
				Customer c = new Customer(rs.getString("customerID"));
				return c;
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<String> listUserGroups(String userID) {
		ArrayList<String> listOfUsers = new ArrayList<String>();
		String sql = "SELECT groupName FROM jcp65_bank1017.groups ";
		sql += "JOIN jcp65_bank1017.user_permissions ";
		sql += "ON jcp65_bank1017.groups.groupID = jcp65_bank1017.user_permissions.groupID ";
		sql += "WHERE jcp65_bank1017.user_permissions.groupOrUserID = '" + userID + "';";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			while (rs.next()) {
				listOfUsers.add(rs.getString("groupName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfUsers;
	}
	
}