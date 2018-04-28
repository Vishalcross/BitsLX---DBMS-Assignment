



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
    String money=cookies[1].getValue();
    String temp_uid=cookies[0].getValue();
    cookies[1].setMaxAge(0);
    response.addCookie(cookies[1]);

    
    stmt=conn.createStatement();
     String query ="SELECT * FROM `user` WHERE uid LIKE "+ temp_uid +"  ";
    ResultSet resultset = stmt.executeQuery(query);
    resultset.next();

    String balance=resultset.getString("balance");
    int bal=Integer.parseInt(balance);
    int add=Integer.parseInt(money);

    bal+=add;
    balance=Integer.toString(bal);
    
    query="UPDATE `user` SET `balance`='"+balance+"' WHERE uid in ("+temp_uid+")";
    stmt.executeUpdate(query);

    %>
        <script type="text/javascript">
            window.location="profile_page.jsp";
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
