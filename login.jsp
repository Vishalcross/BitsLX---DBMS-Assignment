<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>BitsLX</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>

    <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">
    <style>
      body{
        background-image: url("nightmarket.jpg");
        
      }
      .test{
        height: 100%;
        width: 100%;
        position: absolute;
        background: black;
        filter: opacity(70%);
        z-index: 0;
      }
      .fr{
        position: relative;
        z-index: 2;
      }
      .s{
        color:white;
      }
    </style>
  </head>
<body class="text-center">
<div class="test">

</div>
<br><br><br>
<div class="container">
    <div class="row">

        <div class="col-md-4 offset-4 justify-content-center">

            <form class="form-signin justify-content-center">

              <div class="fr">
                <img class="mb-4 s" src="BitsLX.png" alt="" width="220" height="90">
                <h2 class="s">Sign into The Local Market</h2>
                <label for="inputEmail" class="sr-only">Email address</label>
                <input type="text" id="inputEmail" class="form-control" placeholder="Username" name="username" required autofocus>
                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" required>
                <button class="btn btn-lg  btn-success btn-block" type="submit" formaction="login.jsp">Log in</button>
                <button class="btn btn-danger btn-block" type="submit" formaction="signup.jsp">Sign Up!</button>
              </div>

            </form>
        </div>
    </div>

  </div>


<script>
    var ht = $(window).height();
    var wt = $(window).width();
    $("body").css("background-size",""+wt+"px "+ht+"px");
    //$(window).width()
</script>

</body>

</html>




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

    String username=request.getParameter("username");
    String password=request.getParameter("password");
    String uid="dar";

	  stmt=conn.createStatement();
    String query ="SELECT * FROM `user`;";
    ResultSet resultset = stmt.executeQuery(query);

    boolean flag=false;


    while(resultset.next()){
     
    String temp_username=resultset.getString("username");
    String temp_password=resultset.getString("password");
    uid=resultset.getString("uid");

    if(username.equals(temp_username) && password.equals(temp_password)){

        flag=true;
        break;
    }
}

   if(!flag){
    %><script type="text/javascript">
    alert("Credentials incorrect");
    window.location="LogInPage.html";
    </script><%

}
   else
   {

       Cookie cookie= new Cookie("uid",uid);

        cookie.setMaxAge(60*60*48);
        response.addCookie(cookie);
        String site = new String("profile_page.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        /*String del = "DELETE FROM `question_info`;";
        stmt = conn.createStatement();
        stmt.executeUpdate(del);
        stmt.close();*/

   }

    
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