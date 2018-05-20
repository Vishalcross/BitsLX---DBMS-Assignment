<!DOCTYPE html>
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
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
  <!-- Custom styles for this template -->
  <link href="form-validation.css" rel="stylesheet">
  <style>
    .tableTransaction{
      height: 20em !important;
    }
    .test{
      margin-bottom: -1em;
    }
    .transactions{
      display: block;
    }
    .headertext{
      font-family: "Monotype Corsiva", SansSerif !important;
      font-weight: bolder;
    color: #FFFFFF;
    }
    body{
      background-image: url("ProfileBack.jpg");
      background-position: top;
    }
  </style>
</head>
<body>

  <%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.* , javax.swing.JOptionPane" %>

<% 

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";                  // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/bitslx";                // URL of your Database //
    final String USER = "root";                                          // Database credentials //
    final String PASS = "";
    Connection conn = null;
    Statement stmt = null;
    Statement s1=null,s2=null;
    ResultSet fresultset=null,sresultset=null;
    String fquery=null,squery=null;
    
  try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);
    Cookie cookies[]=request.getCookies();
    
    String temp_uid=cookies[0].getValue();

    stmt=conn.createStatement();
    String query ="SELECT * FROM `user` WHERE uid LIKE "+ temp_uid +"  ";

    ResultSet resultset = stmt.executeQuery(query);
    resultset.next();

    String username=resultset.getString("username");
    String money=resultset.getString("balance");

    query ="SELECT * FROM `transaction`";
    resultset = stmt.executeQuery(query);

  %>  

  <div class="container-fluid">
    <div class="row">

      <div class="col-md-4">
        <br>
        <a href="marketPlace.jsp" ><img src="BitsLX.png" width="40%" height="60%"></a>
      </div>


        <div class="col-md-8">
          <br>
          <h1 class="headertext">Hello <span><%=username%></span> welcome to BitsLX</h1>
        </div>

    </div>
    <br>
    <div class="row">
      <div class="col-2">
        <div class="btn-group btn-group-vertical" role="group" aria-label="Basic example">
          <button type="button" class="btn btn-dark" id="userName" data-toggle="modal" data-target="#general">Change Username</button>
          <button type="button" class="btn btn-dark" id="password" data-toggle="modal" data-target="#general">Change Password</button>
          <button type="button" class="btn btn-dark" id="mail" data-toggle="modal" data-target="#general">Change Email</button>

          <button type="button" class="btn btn-dark " data-toggle="modal" data-target="#exampleModal">Add Money to wallet</button>
          
          <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Enter the amount</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <form class="form-inline" >
                    <label class="sr-only" for="inlineFormInputGroupUsername2">Add Money</label>
                    <div class="input-group mb-2 mr-sm-2">
                      <div class="input-group-prepend">
                        <div class="input-group-text">$</div>
                      </div>
                      <input type="text" pattern="^[0-9]*$" class="form-control" id="amount" placeholder="Add Money">
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-success" data-dismiss="modal" id="add_money_btn">Add Money</button>
                </div>
              </div>
            </div>
          </div>
      <!--General purpose Modal-->
      <div class="modal fade" id="general" tabindex="-1" role="dialog" aria-labelledby="generalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="generalLabel">Modal Title</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <form>
                    <label class="sr-only" for="inlineFormInputGroupUsername">Label Text</label>
          <div class="input-group">
            <input type="text" class="form-control" id="inlineFormInputGroupUsername3" placeholder="Sample Input Placeholder" disabled>
          </div>
                    <div class="input-group">
            
                      <input type="text" class="form-control" id="inlineFormInputGroupUsername" placeholder="Sample Input Placeholder">
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-success" id="confirm" data-dismiss="modal">Confirmation Button</button>
                </div>
              </div>
            </div>
          </div>
          <button type="button" class="btn btn-dark" id="viewPrevious">Show Previous Transactions</button>
          <button type="button" class="btn btn-dark" id="logout" data-target="#general">Log Out</button>
          <button type="button" class="btn btn-dark" disabled><strong>Current Balance</strong><div class="input-group-text" id="btnGroupAddon2">$<%=money%></div></button>
        </div>

      </div>
      <div class="transactions offset-2 col-6">
        <div class="row justify-content-center test">
          <div class="col-12">
            <table class="table table-dark">
              <thead>
              <tr>
                <td scope="col">T_no</td>
                <td scope="col">P_no</td>
                <td scope="col">From</td>
                <td scope="col">To</td>
                <td scope="col">email_from</td>
                <td scope="col">email_to</td>

              </tr>
              </thead>
           <!--  </table>
          </div>
        </div>
        <div class="row justify-content-center test2">
          <div style="overflow-y: auto" class="col-12 tableTransaction">

            <table class="table table-dark"> -->

              <tbody>
                <%
                    while(resultset.next()){

                    String first=resultset.getString("first");
                    String second=resultset.getString("second");
                    String t_no=resultset.getString("t_no");
                    String email_from=resultset.getString("email_from");
                    String email_to=resultset.getString("email_to");
                    String p_no=resultset.getString("p_id");

                    if(first.equals(temp_uid) || second.equals(temp_uid)){

                        s1=conn.createStatement();
                        fquery ="SELECT * FROM `user` WHERE uid LIKE "+ first +"  ";
                        
                        fresultset = s1.executeQuery(fquery);
                        fresultset.next();
                        

                        s2=conn.createStatement();
                        squery ="SELECT * FROM `user` WHERE uid LIKE "+ second +"  ";
                         
                        sresultset = s2.executeQuery(squery);
                        sresultset.next();
                        
                        %>
                            <tr>
                               <td scope="row"><%=t_no%></td>
                                <td><%=p_no%></th>
                                <td><%=fresultset.getString("username")%></td>
                                <td><%=sresultset.getString("username")%></td>
                                <td><%=email_from%></td>
                                <td><%=email_to%></td>
                            </tr>
                        <%
                    }
                  }
                %>
               
              
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>


  </div>

  <script>
    
    var c_user=0;
    var c_pass=0;
    var c_email=0;

  </script>
<script>
  $(document).ready(function(){

      $("#logout").click(function(){
        window.location="logout.jsp";
      });

      $("#userName").click(function(){
        c_user=1;
        $("#generalLabel").text("Enter the new user name");
        $("#inlineFormInputGroupUsername").attr("placeholder","New Username");
        $("#inlineFormInputGroupUsername3").attr("placeholder","Old Username");
        $("#confirm").text("Change User Name");

      }); 
      $("#password").click(function(){
        c_pass=1;
        $("#generalLabel").text("Enter the new user name");
        $("#inlineFormInputGroupUsername").attr("placeholder","New password");
        $("#inlineFormInputGroupUsername3").attr("placeholder","Old Password");
        $("#inlineFormInputGroupUsername").attr("type","password");
        $("#confirm").text("Change Password");
      }); 
      $("#mail").click(function(){
        c_email=1;
        $("#generalLabel").text("Enter the new user name");
        $("#inlineFormInputGroupUsername").attr("placeholder","new mailId");
        $("#inlineFormInputGroupUsername3").attr("placeholder","Old Email");
        $("#inlineFormInputGroupUsername").attr("type","email");
        $("#confirm").text("Change Email");
      });
      $("#viewPrevious").click(function(){
        if($(".transactions").css("display") == "none"){
          $("#viewPrevious").text("Hide Previous Transactions");
          $(".transactions").css("display","block");
        }
        else{
          $("#viewPrevious").text("Show Previous Transactions");
          $(".transactions").css("display","none");
        }

      });

      $("#add_money_btn").click(function(){
        
          var add= $("#amount").val();
          document.cookie="val="+add;
          window.location="addmoney.jsp";
      });

       $("#confirm").click(function(){
            var x= $("#inlineFormInputGroupUsername").val();
            document.cookie="val="+x;
            if(c_user==1){
              document.cookie="tye=username";
              c_user=0;
              window.location="changex.jsp";
            }
            else if(c_pass==1){
              document.cookie="type=password";
              c_pass=0;
              window.location="changex.jsp";
            }
            else{
              document.cookie="type=email";
              c_email=0;
              window.location="changex.jsp";
            }

        });
    });
</script>  
<script>
    var ht = $(window).height();
  var wt = $(window).width();
  $("body").css("background-size",""+wt+"px "+ht+"px");
</script>

 
 <%
        /*String site = new String("LogInPage.html");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);*/
   
    /*String del = "DELETE FROM `question_info`;";
    stmt = conn.createStatement();
    stmt.executeUpdate(del);
    stmt.close();*/


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
</body>
</html>