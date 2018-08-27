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

    Cookie  cookies[]=request.getCookies();
    String u_id=cookies[0].getValue();

    String email=request.getParameter("email");
    String body=request.getParameter("body");
    String status=request.getParameter("paymentMethod");
    String price=request.getParameter("price");


    stmt=conn.createStatement();
    String query = "INSERT INTO `product` VALUES ('','"+u_id+"','-1','"+email+"','','"+body+"','"+price+"','"+status+"');";
    stmt.executeUpdate(query);

    %>
        <script type="text/javascript">
            
            window.location="marketPlace.jsp"
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
