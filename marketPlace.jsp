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
    String uid=cookies[0].getValue();

    stmt=conn.createStatement();
    String query ="SELECT * FROM `product`;";
    ResultSet resultset = stmt.executeQuery(query);
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

    <title>The MarketPlace</title>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
    <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="../../../../assets/js/vendor/popper.min.js"></script>
    <script src="../../../../dist/js/bootstrap.min.js"></script>
    <script src="../../../../assets/js/vendor/holder.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="album.css" rel="stylesheet">
  <style>
    .navOptions{
      font-size: 1.5em !important;
    }
    .x{
      color: white !important;
    }
    .selected{
      background-color: rgb(230,230,230);
    }
  </style>
  </head>

  <body>

    <header>
      <div class="navbar navbar-dark bg-dark box-shadow">
        <div class="container d-flex justify-content-between">
          <a href="#" class="navbar-brand d-flex align-items-center">
      <img class="mb-4 s" src="BitsLX.png" alt="" width="120em" height="50em">
          </a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
      </div>
      <div class="collapse bg-dark" id="navbarHeader">
        <div class="container">
          <div class="row">
           <!--  <div class="col-sm-8 col-md-7 py-4">
              <h4 class="text-white">About</h4>
              <p class="text-muted">Add some information about the album below, the author, or any other background context. Make it a few sentences long so folks can pick up some informative tidbits. Then, link them off to some social networking sites or contact information.</p>
            </div> -->
            <div class="  ">
              <h3 class="text-white ">Navigation</h3>
              <ul class="list-unstyled">
                <li><a href="checkout.jsp" class="text-white navOptions" id="checkout">Proceed to Checkout</a></li>
                <li><a href="profile_page.jsp" class="text-white navOptions" id="profile">Visit Profile Page</a></li>
                <li><a href="#" class="text-white navOptions" id="logout">Logout</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </header>

    <main role="main">

      <section class="jumbotron text-center">
        <div class="container">
          <h1 class="jumbotron-heading">Welcome to the MarketPlace</h1>
          <p class="lead text-muted">
      Browse through the contents to see if you can find an item that meets your needs. If none of the items seem to match create your own advertisement, so that someone can find a way to meet your needs
      </p>
          <p>
            <button href="#" class="btn btn-lg btn-info my-1" data-toggle="modal" data-target="#exampleModal">Post an Advertisement</button>

          </p>
        </div>
      </section>



      <!-- Advertisement Modal -->


      <!-- Button trigger modal -->


      <!-- Modal -->
      <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Create new Advertisement</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            
            <div class="modal-body">
              <form method="post" formaction="addproduct.jsp">
                <div class="form-group">
                  <label for="exampleInputEmail1">Enter Email</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="email" required>
                  <small id="emailHelp" class="form-text text-muted">This email will be shared with the Buyer</small>
                </div>
                <div class="form-group">
                  <label for="exampleInput1">Advertisement Body</label>
                  <textarea class="form-control" name="body" id="exampleInput1" rows="5" placeholder="Enter a concise description of the product you are trying to sell/buy by listing all the features." required></textarea>
                </div>
                <label class="seeme" for="inlineFormInputGroup">Enter the selling price</label>
                <div class="input-group seeme">
                  <div class="input-group-prepend">
                    <div class="input-group-text"><i class="fas fa-dollar-sign"></i></div>
                  </div>
                  <input type="text" name="price" class="form-control" id="price" placeholder="Enter the selling price">
                </div>
                <div class="form-group">
                  <div class="custom-control custom-radio">
                    <input id="selling" name="paymentMethod" type="radio" class="custom-control-input" value="selling" checked required>
                    <label class="custom-control-label" for="selling">Selling</label>
                  </div>
                  <div class="custom-control custom-radio">
                    <input id="buying" name="paymentMethod" type="radio" class="custom-control-input" value="buying" required>
                    <label class="custom-control-label" for="buying">Buying</label>
                  </div>

                </div>
              
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-success" id="postingAd" formaction="addproduct.jsp">Post the Ad</button>
            </div>
            </form>
          </div>
        </div>
      </div>


     <!-- Contact Modal -->

            <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel11" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1">Contact Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <form>
                      <div class="form-group">
                        <label for="exampleInputEmail2">Contact Email</label>
                        <input type="email" class="form-control" id="exampleInputEmail2" aria-describedby="emailHelp" placeholder="Email" disabled>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>


      <!-- Advertisement Modal -->


      <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
            <%
                while(resultset.next()){
                String p_no=resultset.getString("p_id");
                String status=resultset.getString("status");
                String u_id_first=resultset.getString("u_id_first");
                String email=resultset.getString("email");
                
                if(status.equals("selling") && !uid.equals(u_id_first)){
                  
                  %>
                    
                    <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                    <div class="card-header bg-danger x" ><strong>Sell</strong></div>
                            <!-- <img class="card-img-top" src="online-shopping-icons-set-selling-Download-Royalty-free-Vector-File-EPS-293769.jpg" alt="Card image cap"> -->
                            <div class="card-body">
                              <p class="card-text"><%=resultset.getString("body")%></p>
                              <p class="card-text"></p>
                              <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                  <!-- <button type="button" class="btn btn-sm btn-outline-secondary">Add to Cart</button> -->
                                  <button type="button" name="addtocart" id="<%=p_no%>"class="btn btn-sm btn-outline-secondary">Add to Cart</button>
                                  <button type="button" name="contactbuyer" id="<%=email%>"class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModal1">Contact Buyer</button>
                                </div>
                                <small class="text-muted"><i class="fas fa-dollar-sign"></i> <%=resultset.getString("cost")%></small>
                              </div>
                            </div>
                          </div>
                        </div>
                      
                  <%

                }
                else if(status.equals("buying") && !uid.equals(u_id_first)){

                %>
                   
                    <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                    <div class="card-header bg-success x"><strong>Buy</strong></div>
                      <!-- <img class="card-img-top" data-src="holder.js/100px225?theme=thumb&bg=55595c&fg=eceeef&text=Thumbnail" alt="Card image cap"> -->
                      <div class="card-body">
                        <p type="longInput"><%=resultset.getString("body")%></p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div class="btn-group">
                            
                            <button type="button" name="contactbuyer" id="<%=email%>"class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#exampleModal1">Contact Buyer</button>
                          </div>
                          <small class="text-muted"><i class="fas fa-dollar-sign"></i> <%=resultset.getString("cost")%></small>
                        </div>
                      </div>
                    
                  </div>
                </div>
                <%
               }
              }
            %>
            
            
        </div>
      </div>
    </div>
    </main>
    


    <script>

       $(document).ready(function(){
        $(function(){
          $('#buying').click(function(){
            if ($(this).is(':checked'))
            {
              
              $("#postingAd").removeClass("btn-success");
              $("#postingAd").addClass("btn-danger");
            }
          });
          $('#selling').click(function(){
            if ($(this).is(':checked'))
            {
              
              $("#postingAd").removeClass("btn-danger");
              $("#postingAd").addClass("btn-success");
            }
          });
        });
      });

      $(document).ready(function(){

         $("#logout").click(function(){

            window.location="logout.jsp";
      });
         $("[name=contactbuyer").click(function(){
          
          var email=this.id;
          $("#exampleInputEmail2").attr("placeholder",email);

         });

         $("[name=addtocart]").click(function(){

            var p_id=this.id;
            document.cookie=p_id+"="+p_id;

            $(this).parent().parent().parent().addClass("selected");
         });

      });
    </script>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

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



