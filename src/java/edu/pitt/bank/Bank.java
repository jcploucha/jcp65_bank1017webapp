package edu.pitt.bank;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import edu.pitt.utilities.DbUtilities;
import edu.pitt.utilities.MySqlUtilities;


public class Bank {

	private ArrayList<Account> accountList = new ArrayList<Account>();
	private ArrayList<Customer> customerList = new ArrayList<Customer>();

	public Bank() {
		loadAccounts();
		// findAccount("2c508880-5d42-11e3-94ef-97beef767f1d");
		setAccountOwners();
	}

	private void loadAccounts() {
		String sql = "SELECT * FROM jcp65_bank1017.account;";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			while(rs.next()){
				Account a = new Account(rs.getString("accountID"));
				accountList.add(a);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	//don't like this -> should be in a try catch? graceful handling if acct isn't in list.
	public Account findAccount(String accountID){
		for (int i = 0; i <= accountList.size() - 1; i++) {
			if (accountList.get(i).getAccountID().equals(accountID)) {
				return accountList.get(i);
			}
		}
		return null;

	}

	public Customer findCustomer(String customerID){
		for (int i = 0; i <= customerList.size() - 1; i++) {
			if (customerList.get(i).getCustomerID().equals(customerID)) {
				return customerList.get(i);
			}
		}
		return null;
	}

	//double check on this method. not sure on the addAccountOwner part.
	private void setAccountOwners(){
		String sql = "SELECT * FROM jcp65_bank1017.account ";
		sql += "JOIN jcp65_bank1017.customer_account ON jcp65_bank1017.account.accountID = jcp65_bank1017.customer_account.fk_accountID ";
		sql += "JOIN jcp65_bank1017.customer on jcp65_bank1017.customer_account.fk_customerID = jcp65_bank1017.customer.customerID;";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			while(rs.next()){
				Customer c = new Customer(rs.getString("customerID"));
				customerList.add(c);
				findAccount(rs.getString("accountID")).addAccountOwner(c);				
			}
		} catch (SQLException e) {
				e.printStackTrace();
		}		
	}

}