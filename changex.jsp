
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
    String temp_uid=cookies[0].getValue();
    String temp_string=cookies[1].getValue();
    String type=cookies[2].getValue();
    cookies[1].setMaxAge(0);
    cookies[2].setMaxAge(0);
    response.addCookie(cookies[1]);
    response.addCookie(cookies[2]);
    
    stmt=conn.createStatement();

    String query;

    if(type.equals("username")){
    
    query ="SELECT * FROM `user`";
    int flag=0;
    ResultSet resultset = stmt.executeQuery(query);
    while(resultset.next()){

        String t=resultset.getString("username");
        if(t.equals(temp_string)){
        flag=1;
        break;
    }
}

    if(flag==1){

    %>
        <script type="text/javascript">
            alert("Username exists");
        </script>
    <%
}

    else{

     query="UPDATE `user` SET `username`='"+temp_string+"' WHERE uid in ("+temp_uid+")";
    stmt.executeUpdate(query);
     %>
        <script type="text/javascript">
            alert("Username changed");
        </script>
    <%
}

   
}
    else if(type.equals("password")){

    query="UPDATE `user` SET `password`='"+temp_string+"' WHERE uid in ("+temp_uid+")";
    stmt.executeUpdate(query);

     %>
        <script type="text/javascript">
            alert("Password changed");
        </script>
    <%
}
    else if(type.equals("email")){

    query="UPDATE `user` SET `email`='"+temp_string+"' WHERE uid in ("+temp_uid+")";
    stmt.executeUpdate(query);

     %>
        <script type="text/javascript">
            alert("Email changed");
        </script>
    <%
}

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
