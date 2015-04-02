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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <script>
            function submitOnSelect(){
                var cboAccountList = document.getElementById("cboAccountList");
                var frmAccountDetails = document.getElementById("frmAccountDetails");
                
                if(cboAccountList.value != ""){
                    frmAccountDetails.submit();
                } 
                
            }
        </script>
        <title>Account Details</title>
    </head>
    <body>
    <% 

    Bank bank;
    if(session.getAttribute("authenticatedUser") != null && session.getAttribute("bank") != null){

    System.out.println();

    System.out.println(session.getId());
        
        Customer authUser = (Customer) session.getAttribute("authenticatedUser");      
        bank = (Bank) session.getAttribute("bank");
        ArrayList<Account> accts = bank.findAccountsByCustomer(authUser.getCustomerID());     
        
        //get permissions
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
                        
                        String selectedAccount;

                        if (session.getAttribute("selectedAccount") != null) {
                            Account a = (Account) session.getAttribute("selectedAccount");
                            selectedAccount = a.getAccountID();
                        } else {
                            selectedAccount = request.getParameter("cboAccountList");
                        }
 
                        for (int i = 0; i <= accts.size() - 1; i++){ 
                            //String selectedAccount = request.getParameter("cboAccountList");
                            if (selectedAccount == null) {
                                selectedAccount = "";
                            }  
                            if (selectedAccount.equalsIgnoreCase(accts.get(i).getAccountID())) {
                                out.print("<option selected='true' value='" + accts.get(i).getAccountID() + "'>" + accts.get(i).getAccountID() + "</option>");
                            } else {                            
                            out.print("<option value='" + accts.get(i).getAccountID() + "'>" + accts.get(i).getAccountID() + "</option>");
                            }

                            if(!selectedAccount.equals("")) {
                                session.setAttribute("selectedAccount", bank.findAccount(selectedAccount));
                            }
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
                                                                  
                            if (session.getAttribute("selectedAccount") != null ){
                                Account acct = (Account) session.getAttribute("selectedAccount");
                                System.out.println(acct.getBalance());

                                out.print("<b><li class='list-group-item'>Account Type: </b>" + acct.getAccountType() + "</li>");
                                out.print("<b><li class='list-group-item'>Balance: </b>" + acct.getBalance() + "</li>");
                                out.print("<b><li class='list-group-item'>Interest Rate: </b>" + acct.getInterestRate() + "</li>");
                                out.print("<b><li class='list-group-item'>Penalty: </b>" + acct.getPenalty() + "</li>");
                            } else {                                
                                out.print("<b><li class='list-group-item'>Account Type: </b></li>");
                                out.print("<b><li class='list-group-item'>Balance: </b></li>");
                                out.print("<b><li class='list-group-item'>Interest Rate: </b></li>");
                                out.print("<b><li class='list-group-item'>Penalty: </b></li>");
                            }

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

                            <% 
                                if(session.getAttribute("selectedAccount") == null) {
                                    out.print("<a href='#'>View Transactions</a>");
                                } else {
                                    out.print("<a href='transactionui.jsp' target='_blank'>View Transactions</a>");
                                }
                            %>

                            </li>
                            
                            <form method="POST" id="frmAccountAction" name="frmAccountAction" action="bankui.jsp">
                            
                                <li class="list-group-item">
                                    <select name="cboTransactionType" id="cboTransactionType" class="form-control">
                                        <option value="trns">Transaction Type:</option>
                                        <option value="Deposit">Deposit</option>
                                        <option value="Withdraw">Withdraw</option>
                                    </select>
                                </li>
                                <li class="list-group-item">
                                    
                                      <div class="form-group">
                                        <label class="sr-only" for="txtTransactionAmount">Amount (in dollars)</label>
                                        <div class="input-group">
                                          <div class="input-group-addon">$</div>
                                          <input type="text" class="form-control" id="txtTransactionAmount" name="txtTransactionAmount" placeholder="Amount">
                                          <div class="input-group-addon">.00</div>
                                        </div>
                                      </div>
                                    <button type="submit" class="btn btn-primary" id="btnTransfer" name="btnTransfer" >Transfer cash</button>
                                      
                                      
                                    
                                </li>

                            
                            </form>
                            <%

                            String transType = request.getParameter("cboTransactionType");
                            String amtStr = request.getParameter("txtTransactionAmount");
                            Account acct = (Account) session.getAttribute("selectedAccount");  
                            //bank.findAccount(selectedAccount)                                                                                    
                            if (transType != null && amtStr != null && acct != null) {                             
                                if (!transType.equals("trns") && !amtStr.equals("")) {             
                                    double amt = Double.parseDouble(amtStr);

                                    if (transType.equals("Deposit")) {
                                        acct.deposit(amt);
                                    
                                    } else if (transType.equals("Withdraw")) {
                                        if (amt > acct.getBalance()) {

                                            out.print("<p>test<p>");
                                        } else {
                                            acct.withdraw(amt);
                                        }
                                        
                                    }
                                    session.setAttribute("selectedAccount", acct); 
                                    response.sendRedirect("bankui.jsp");
                                 }

                                                                                                                    
                            }

                            %>

                        </ul>            
                    </div>
                </div>                
            </div>            
        <!-- </form> -->
        <p class="text-right"><a href="#">Log out</a></p>

    </div>
    <% 
    }else{
        response.sendRedirect("index.jsp");
    }
    %>

    </body>
</html>
