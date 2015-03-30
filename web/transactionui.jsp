<%@page import="edu.pitt.bank.Account"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.pitt.bank.Transaction"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <title>Transactions</title>
    </head>
    <body>
    <% 
    if(session.getAttribute("authenticatedUser") != null){  
        Account selectedAccount = (Account) session.getAttribute("selectedAccount");
      //  ArrayList<Transaction> transactions = selectedAccount.getTransactionList();
    %>
        <div class="container">
            <div class="row">
                <h3>
                <%
                    out.print(selectedAccount.getAccountType() + " account #" + selectedAccount.getAccountID());
                %>
                </h3>
                <table class="table table-hover table-striped" id="transactionsTable">
                    <tr>
                        <th>Transaction Date</th>
                        <th>Transaction ID</th>
                        <th>Amount</th>
                        <th>Type</th>
                        <th>Balance</th>
                    </tr>
                    <% 
                    
                    for (int i = 0; i <= selectedAccount.getTransactionList().size() - 1; i++) {
                        out.print("<tr>");
                        out.print("<td>" + selectedAccount.getTransactionList().get(i).getTransactionDate() + "</td>");
                        out.print("<td>" + selectedAccount.getTransactionList().get(i).getTransactionID() + "</td>");
                        out.print("<td>" + selectedAccount.getTransactionList().get(i).getAmount() + "</td>");
                        out.print("<td>" + selectedAccount.getTransactionList().get(i).getType() + "</td>");
                        out.print("<td>" + selectedAccount.getTransactionList().get(i).getBalance() + "</td>");
                        out.print("<tr>");
                    }
                    
                    %>
                </table>
            </div>
        </div>
    <% 
    }else{
        response.sendRedirect("index.jsp");
    }
    %>
    </body>
</html>
