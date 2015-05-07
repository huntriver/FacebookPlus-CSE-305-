<%-- 
    Document   : manager_regiser
    Created on : 2015-5-7, 1:27:21
    Author     : yishuo wang
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            } 
            else{
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE id=?");
                ps.setString(1, userid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();

                if (!rs.getString("type").equals("1")) {
                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                    return ;
                }
            }
        %>
        
    </head>
    <body>
        <form action="register" method="post">
            <table>
                <tr><td>Username: </td> <td><input type="text" name="username"/></td></tr>
                <tr><td>password:</td> <td> <input type="password" name="pwd" /></td></tr>
                <tr><td>confirm password: </td> <td><input type="password" name="pwd1" /></td></tr>
            </table>
            </br>
            <input type="submit" value="Register" />       &nbsp;&nbsp; &nbsp;   
            <input type="reset" value="Reset" /></br>

        </form>
        <button type="button" onclick="window.location.href = 'add_delete.jsp'">back</button>
    </body>
</html>