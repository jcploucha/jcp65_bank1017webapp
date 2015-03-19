package edu.pitt.bank;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;

import edu.pitt.utilities.DbUtilities;
import edu.pitt.utilities.MySqlUtilities;

public class Transaction {
	private String transactionID;
	private String accountID;
	private String type;
	private double amount;
	private double balance;
	private Date transactionDate; 
	
	public Transaction(String transactionID){
		String sql = "SELECT * FROM jcp65_bank1017.transaction "; 
		sql += "WHERE transactionID = '" + transactionID + "'";
		DbUtilities db = new MySqlUtilities();
		try {
			ResultSet rs = db.getResultSet(sql);
			while(rs.next()){
				this.transactionID = rs.getString("transactionID");
				this.accountID = rs.getString("accountID");
				this.type = rs.getString("type");
				this.amount = rs.getDouble("amount");
				this.balance = rs.getDouble("balance");
				this.transactionDate = rs.getDate("transactionDate");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Transaction(String accountID, String type, double amount, double balance){
		this.transactionID = UUID.randomUUID().toString();
		this.type = type;
		this.amount = amount;
		this.accountID = accountID;
		this.balance = balance;
		
		String sql = "INSERT INTO jcp65_bank1017.transaction ";
		sql += "(transactionID, accountID, amount, transactionDate, type, balance) ";
		sql += " VALUES ";
		sql += "('" + this.transactionID + "', ";
		sql += "'" + this.accountID + "', ";
		sql += this.amount + ", ";
		sql += "CURDATE(), ";
		sql += "'" + this.type + "', ";
		sql += this.balance + ");";

		System.out.println(sql);
		
		DbUtilities db = new MySqlUtilities();
		db.executeQuery(sql);
	}

	public String getTransactionID() {
		return this.transactionID;
	}

	public String getAccountID() {
		return this.accountID;
	}

	public String getType() {
		return this.type;
	}

	public double getAmount() {
		return this.amount;
	}

	public double getBalance() {
		return this.balance;
	}

	public Date getTransactionDate() {
		return this.transactionDate;
	} 

}
