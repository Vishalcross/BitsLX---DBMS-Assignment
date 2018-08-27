<!DOCTYPE html>
<html>
<head>
</head>
<style type="text/css">
 body{
      background-image: url("ProfileBack.jpg");
      background-position: top;
    }
</style>
<body>

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

    String email_r=request.getParameter("email_r");
    String payment=request.getParameter("paymentMethod");
    String cost=request.getParameter("cost");
    String balance=request.getParameter("balance");
    String query="";


    if(payment.equals("wallet") && Integer.parseInt(cost)>Integer.parseInt(balance)){

    %>
        <script type="text/javascript">
            alert("Insufficient balance");
            window.location="profile_page.jsp";
        </script>

    <%
}
    else{

    Cookie cookies[]=request.getCookies();
    int len=cookies.length-2;

    for(int i=1;i<=len;i++){

    String p_id=cookies[i].getValue();
    cookies[i].setMaxAge(0);
    response.addCookie(cookies[i]);

    stmt=conn.createStatement();
    query="UPDATE `product` SET `u_id_second`='"+cookies[0].getValue()+"',`email_r`='"+email_r+"' WHERE p_id in ("+p_id+");";
    
    stmt.executeUpdate(query);
    
    
    stmt=conn.createStatement();
    query ="SELECT * FROM `product` WHERE p_id LIKE "+ p_id +"  ;";
    ResultSet resultset = stmt.executeQuery(query);
    resultset.next();
    

    stmt=conn.createStatement();
    query = "INSERT INTO `transaction` VALUES ('','"+resultset.getString("u_id_first")+"','"+resultset.getString("u_id_second")+"','"+resultset.getString("email")+"','"+resultset.getString("email_r")+"','"+resultset.getString("p_id")+"');";
    stmt.executeUpdate(query);
    

    stmt = conn.createStatement();
    query = "DELETE FROM `product`WHERE p_id LIKE "+ p_id +";";
   
    stmt.executeUpdate(query);
    
   
}

    int bal=Integer.parseInt(balance)-Integer.parseInt(cost);
    balance=Integer.toString(bal);

    stmt=conn.createStatement();
    query="UPDATE `user` SET `balance`='"+balance+"'  WHERE uid in ("+cookies[0].getValue()+")";
    stmt.executeUpdate(query);
     conn.close();

  
   %>
    <script type="text/javascript">
        
        alert("Items purchased");
        window.location="profile_page.jsp";
    </script>
   <%
} 

    
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