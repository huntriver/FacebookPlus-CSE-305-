<%-- 
    Document   : account
    Created on : 2015-4-30, 22:58:44
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Page</title>
        <h1>Your Account</h1>
        Create a new account <a href="newAccount.jsp">Create New</a>
        
        <form action="delete_account" method="post">
        <table border="1">
        <%
            String userid = (String) session.getAttribute("userid");
            String Account_Num = null;
            String Credit_Num = null;
            String Date = null;
            String AN[] = new String[1000];
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user_has_account Where User_Id=?");
                PreparedStatement ps_= conn.prepareStatement("SELECT * FROM account Where Account_Number=?");
                ps.setString(1, userid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                %>
                <tr><td></td><td>Account Number</td><td>Creation Date</td><td>Credit Card Number</td></tr>
                <%
                while(rs.next()){
                    
                    ps_.setString(1, rs.getString("Account_Number"));
                    ps_.execute();
                    ResultSet rs_ = ps_.getResultSet();
                    rs_.next();
                    Account_Num = rs.getString("Account_Number");
                    Credit_Num = rs_.getString("Credit_Card_Number");
                    Date = rs_.getString("Account_Creation_Date");
                    if (Account_Num == null) {
                        Account_Num = "";
                    }
                    if (Credit_Num == null) {
                        Credit_Num = "";
                    }
                    %>
                    
                    <tr><td><input type="checkbox" name="daccount" value=<%=Account_Num%>></td>
                        <td><%=Account_Num%></td><td><%=Date%></td><td><%=Credit_Num%></td>
                        <td>
                               <button type="button" onclick="window.location.href = 'view_history?acnum=<%=Account_Num%>'">view history</button>
                           
                        </td>
                    </tr>
                    <%        
                }

                ps.close();
                ps_.close();
                conn.close();
            }
        %>
        
        
        </table>
        <input type="submit" value="Delete Selected Accounts">
        </form>
        <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
    </head>
    <body>
        
            
        
        
    </body>
</html>
