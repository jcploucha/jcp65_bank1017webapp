<%@page import="edu.pitt.bank.Account"%>
<%@page import="edu.pitt.bank.Bank"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="edu.pitt.utilities.MySqlUtilities"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.pitt.utilities.DbUtilities"%>
<%@page import="edu.pitt.bank.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <script>
            function submitOnSelect(){
                // alert("I was called");
                var cboAccountList = document.getElementById("cboAccountList");
                var frmAccountDetails = document.getElementById("frmAccountDetails");
                
                if(cboAccountList.value != ""){
                    // cboAccountList.value.submit();
                    frmAccountDetails.submit();
                    console.log(cboAccountList.value);
                }                
            }
        </script>
        <title>Account Details</title>
    </head>
    <body>
    <% 
    if(session.getAttribute("authenticatedUser") != null){
        Bank bank = new Bank();
        Customer authUser = (Customer) session.getAttribute("authenticatedUser");
        ArrayList<Account> accts = bank.findAccountsByCustomer(authUser.getCustomerID());        

//        Account acct = bank.findAccountsByCustomer(authUser.getCustomerID());
        String permissions = "";
        for(int i = 0; i <= authUser.getGroups().size() - 1; i ++) {
            permissions += authUser.getGroups().get(i) + ", ";
        }
        permissions = permissions.substring(0, permissions.length()-2);
    %>

    <div class="container">
        <div class="row">
            <div class="jumbotron">

                <%
                    out.print("<h1 class='text-center'>Welcome to Bank1017, "
                    + authUser.getFirstName() + " " + authUser.getLastName() + "!</h1>"
                    + "<p class='text-center'> You have the following permissions in the system: <br>"
                    + permissions + "</p>");
                %>

            </div>
        </div>
        <!-- <form id="frmAccoutnDetails" name="frmAccountDetails" action="bankui.jsp" method="Post"> -->
            <div class="row">
                <div class="col-md-12">
                    <p>
                    <form action="bankui.jsp" method="POST" id="frmAccountDetails" name="frmAccountDetails">
                        <select name="cboAccountList" id="cboAccountList" class="form-control" onchange="submitOnSelect();">
                        <option value="">Select Account:</option>

                        <% 
                        for (int i = 0; i <= accts.size() - 1; i++){
                            out.print("<option value='" + accts.get(i).getAccountID() + "'>" + accts.get(i).getAccountID() + "</option>");
                        }
                        %>

                        </select>
                    </form>    
                    </p>
                </div>

            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Account Details</h3>
                        </div>                    
                        <ul class="list-group" id="acctDetails" name="acctDetails">

                            <%
                            Account acct = new Account(request.getParameter("cboAccountList"));
                            out.print("<li class='list-group-item'>Account Type: " + acct.getAccountType() + "</li>");
                            out.print("<li class='list-group-item'>Balance: " + acct.getBalance() + "</li>");
                            out.print("<li class='list-group-item'>Interest Rate: " + acct.getInterestRate() + "</li>");
                            out.print("<li class='list-group-item'>Penalty: " + acct.getPenalty() + "</li>");
                            %> 

                        </ul>            
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Account Actions</h3>
                        </div>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <a href="transactionui.jsp" target="_blank">View Transactions</a>
                            </li>
                            <li class="list-group-item">
                                <select name="cboTransactionType" id="cboTransactionType" class="form-control">
                                    <option value="1">Transaction Type:</option>
                                    <option value="2">Deposit</option>
                                    <option value="3">Withraw</option>
                                </select>
                            </li>
                            <li class="list-group-item">
                                <form class="form-inline">
                                  <div class="form-group">
                                    <label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
                                    <div class="input-group">
                                      <div class="input-group-addon">$</div>
                                      <input type="text" class="form-control" id="exampleInputAmount" placeholder="Amount">
                                      <div class="input-group-addon">.00</div>
                                    </div>
                                  </div>
                                  <button type="submit" class="btn btn-primary">Transfer cash</button>
                                </form>
                            </li>
                        </ul>            
                    </div>
                </div>                
            </div>
        <!-- </form> -->
    </div>
    <% 
    }else{
        response.sendRedirect("index.jsp");
    }
    %>
    </body>
</html>
