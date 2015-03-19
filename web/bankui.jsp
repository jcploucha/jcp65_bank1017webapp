<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <title>Account Details</title>
    </head>
    <body>
    <div class="container">
        <div class="row">
            <div class="jumbotron">
                <h1 class="text-center">Welcome to Bank1017, DumDum!</h1>
                <p class="text-center">You have the following permissions in the system: Poop, Poopbutt, Poopybutt</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p>
                    <select name="slctAccount" id="slctAccount" class="form-control">
                        <option value="1">Select Account:</option>
                        <option value="2">Trololololol</option>
                        <option value="3">Jajajajajaja</option>
                        <option value="4">Teeheeteehee</option>
                        <option value="5">Huehuehuehue</option>
                    </select>
                </p>
            </div>

        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Account Details</h3>
                    </div>
                    <ul class="list-group">
                        <li class="list-group-item">Account Type:</li>
                        <li class="list-group-item">Balance:</li>
                        <li class="list-group-item">Interest Rate:</li>
                        <li class="list-group-item">Penalty:</li>
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
                            <select name="slctAccount" id="slctAccount" class="form-control">
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
    </div>
    </body>
</html>
