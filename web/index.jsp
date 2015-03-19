<%@page import="edu.pitt.utilities.Security"%>
<%@page import="edu.pitt.utilities.DbUtilities"%>
<%@page import="edu.pitt.utilities.MySqlUtilities"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="edu.pitt.bank.Customer"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <title>Bank 1017 Login</title>
    </head>
    <body>
        <div class="container">
            <div class="jumbotron">
                <h1 class="text-center">Welcome to Bank1017</h1>
                <p class="text-center">Please sign in with your login name and pin below.</p>
            </div>
            <form class="form-horizontal" action="index.jsp" method="POST" id="frmLogin" name="frmLogin">
                <div class="form-group">
                    <label for="txtLogin" class="col-md-2 col-md-offset-2 control-label">Login Name</label>
                    <div class="col-md-4">
                        <input type="text" class="form-control" id="txtLogin" name="txtLogin" placeholder="Login Name">
                    </div>
                </div>
                <div class="form-group">
                    <label for="txtPin" class="col-md-2 col-md-offset-2 control-label">Pin</label>
                    <div class="col-md-4">
                        <input type="password" class="form-control" id="txtPin" name="txtPin" placeholder="Pin">
                    </div>
                </div>
                <div class="col-md-5 col-md-offset-3">
                    <button type="submit" class="btn btn-primary btn-block" id="btnSubmit" namd="btnSubmit">Login</button>
                </div>
            </form>            
        </div>
    
        <% 
            String txtLogin, txtPin;
            txtLogin = request.getParameter("txtLogin");
            txtPin = request.getParameter("txtPin");

            if(txtLogin != null && txtPin != null){
                if(!txtLogin.equals("") && !txtPin.equals("")){
                    Security security = new Security();
                    Customer cust = security.validateLogin(txtLogin, Integer.parseInt(txtPin));
                    session.setAttribute("authenticatedUser", cust);
                    out.print(cust.getFirstName() + " " + cust.getLastName());
                    response.sendRedirect("bankui.jsp");
                }else{
                    out.print("You must provide credentials to login");
                }
            }else{
                out.print("You must provide credentials to login");
            }
        %>

    </body>
</html>