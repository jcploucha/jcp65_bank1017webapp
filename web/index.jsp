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
            <form class="form-horizontal" action="bankui.jsp" method="POST">
                <div class="form-group">
                    <label for="inputLoginName" class="col-md-2 col-md-offset-2 control-label">Login Name</label>
                    <div class="col-md-4">
                        <input type="email" class="form-control" id="inputLoginName" placeholder="Login Name">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPin" class="col-md-2 col-md-offset-2 control-label">Pin</label>
                    <div class="col-md-4">
                        <input type="password" class="form-control" id="inputPin" placeholder="Pin">
                    </div>
                </div>
                <!-- <button type="submit" class="btn btn-primary col-md-4 col-md-offset-4">Login</button> -->
                <div class="col-md-5 col-md-offset-3">
                    <button type="submit" class="btn btn-primary btn-block">Login</button>
                </div>
            </form>            
        </div>
    
        <% 
            
        %>
    </body>
</html>