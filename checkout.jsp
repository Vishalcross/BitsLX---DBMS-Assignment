<%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.* , javax.swing.JOptionPane" %>

<% 

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";                  // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/bitslx";                // URL of your Database //
    final String USER = "root";                                          // Database credentials //
    final String PASS = "";
    Connection conn = null;
    Statement stmt = null;
    
  try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    Cookie cookies[]=request.getCookies();
    int len=cookies.length -2;

        /*String site = new String("LogInPage.html");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);*/
   
    /*String del = "DELETE FROM `question_info`;";
    stmt = conn.createStatement();
    stmt.executeUpdate(del);
    stmt.close();*/

    %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>BitsLX</title>

    <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="../../../../assets/js/vendor/popper.min.js"></script>
    <script src="../../../../dist/js/bootstrap.min.js"></script>
    <script src="../../../../assets/js/vendor/holder.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="form-validation.css" rel="stylesheet">

    <style>
      .crossButton{
          transition-delay: 0s;
          color: darkgrey;
        }
      .crossButton:hover{
        transition-delay: 0.2s;
        color: black;
      }
      .itemGroup{
        display: block;
      }
      .selected{
        display: none !important;
      }

      .disappear{
        display: none !important;
      }
    </style>
  </head>

  <body class="bg-light">
<br><br>
    <div class="container">
      <%


      %>

      <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Your cart</span>
            <span class="badge badge-secondary badge-pill"><%=len%></span>
          </h4>
          <ul class="list-group mb-3 itemGroup">
           
                <%
                    int sum=0;
                    for(int i=1;i<=len;i++){

                        
                    %>
                      
                      <li name="product" id="<%=cookies[i].getValue()%>" class=" list-group-item d-flex justify-content-between lh-condensed tatti">
                      <div class="row">
                        <%
                          stmt=conn.createStatement();
                          String query ="SELECT * FROM `product` WHERE p_id LIKE "+ cookies[i].getValue() +";  ";

                          ResultSet resultset = stmt.executeQuery(query);
                          resultset.next();
                      %>
                      <a href="#" name="cross" id="<%=cookies[i].getValue()%>" class="col-md-2 crossButton"><i class="fas fa-times"></i></a>
                      <div class="col-md-10" name="product">
                        <h6 class="my-0">Product ID: <%=resultset.getString("p_id")%> </h6>
                        <small class="text-muted"><%=resultset.getString("body")%></small>
                      </div>
                      
                      </div>
                      <span class="text-muted">$<%=resultset.getString("cost")%></span>
                      </li>
                     
                      <%
                          sum=sum+Integer.parseInt(resultset.getString("cost"));
                      %>

                    <%

                  }
                %>
               
            <li class="list-group-item d-flex justify-content-between bg-warning">
              <span>Total (USD)</span>
              <strong><%=sum%></strong>
            </li>
          </ul>


        </div>
        <div class="col-md-8 order-md-1">
           
          <%
            String balance="";
            for(int i=1;i<=len;i++){

            stmt=conn.createStatement();
            String query ="SELECT * FROM `product` WHERE p_id LIKE "+ cookies[i].getValue() +"  ";

            ResultSet resultset = stmt.executeQuery(query);
            resultset.next();

            stmt=conn.createStatement();
            query ="SELECT * FROM `user` WHERE uid LIKE "+ resultset.getString("u_id_first") +"  ";
            ResultSet uresultset = stmt.executeQuery(query);
            uresultset.next();

            String user=uresultset.getString("username");
            String mail=resultset.getString("email");

            stmt=conn.createStatement();
            query ="SELECT * FROM `user` WHERE uid LIKE "+ cookies[0].getValue() +"  ";
            ResultSet bresultset = stmt.executeQuery(query);
            bresultset.next();

            balance=bresultset.getString("balance");
            


            %>
            <div class="col-md-8 order-md-1">
              <h4 class="mb-3">Product  ID:<%=cookies[i].getValue()%></h4>
             


                <div class="mb-3">
                  <label for="username">Meeting with</label>
                  <div class="input-group">

                    <input type="text" class="form-control" id="username" placeholder="<%=user%>" disabled>

                  </div>
                </div>

                <div class="mb-3">
                  <label for="email">Their Email</label>
                  <input type="email" class="form-control" id="email" placeholder="<%=mail%>" disabled>
                </div>
            </div>

              <%
            }
            %>


               
        </div>

      
    </div>
          
          
        <form method="post" formaction="buyproduct.jsp">
        <div class="mb-3">
                <label for="email">Your Email</label>
                <input type="email" class="form-control" name="email_r" id="email" placeholder="you@example.com" required>
                <div class="invalid-feedback">
                  Your contact details will be shared, please enter valid details
                </div>
          </div>
          <hr class="mb-4">

          <h4 class="mb-3">Payment</h4>

          <div class="d-block my-3">
            <div class="custom-control custom-radio">
              <input id="credit" value="wallet" name="paymentMethod" type="radio" class="custom-control-input" checked required>
              <input type="hidden" name="cost" value="<%=sum%>"></input>
              <input type="hidden" name="balance" value="<%=balance%>"></input>
              <label class="custom-control-label" for="credit">Wallet Balance <span class="input-group-text"><%=balance%></span></label>
            </div>
            <div class="custom-control custom-radio">
              <input id="debit" value="mess" name="paymentMethod" type="radio" class="custom-control-input" required>
              <label class="custom-control-label" for="debit">Mess Balance</label>
            </div>
            <div class="custom-control custom-radio">
              <input id="paypal" value="cod" name="paymentMethod" type="radio" class="custom-control-input" required>
              <label class="custom-control-label" for="paypal">Cash on Delivery</label>
            </div>
          </div>


          <hr class="mb-4">
          <button class="btn btn-primary btn-lg btn-block" type="submit" formaction="buyproduct.jsp">Continue to checkout</button>
        </form>
        <%

        %>
        

              <!-- Bootstrap core JavaScript
              ================================================== -->
              <!-- Placed at the end of the document so the pages load faster -->

              <script>
                // Example starter JavaScript for disabling form submissions if there are invalid fields
                (function() {
                  'use strict';
                  window.addEventListener('load', function() {
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    var forms = document.getElementsByClassName('needs-validation');
                    // Loop over them and prevent submission
                    var validation = Array.prototype.filter.call(forms, function(form) {
                      form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                          event.preventDefault();
                          event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                      }, false);
                    });
                  }, false);
                })();
                $(document).ready(function(){
                  $(".crossButton").click(function(){
                  var id=this.id;
                  document.cookie="remove="+id;
                  window.location="removefromcart.jsp"
                  });

                
                });
              </script>
  </body>
</html>

<%


    conn.close();

    
    }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //Handle errors for Class.forName
    e.printStackTrace();
    }finally{
    //finally block used to close resources
    try{
    if(stmt!=null)
    stmt.close();
    }catch(SQLException se2){
    }// nothing we can do
    try{
    if(conn!=null)
    conn.close();
    }catch(SQLException se){
    se.printStackTrace();
    }//end finally try
    }//end try
      
%>