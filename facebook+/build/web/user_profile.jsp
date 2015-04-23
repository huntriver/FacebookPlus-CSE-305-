<%-- 
    Document   : user_profile
    Created on : Apr 23, 2015, 4:18:08 PM
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%
            String userid = (String) session.getAttribute("userid");
            String lname=null;
            String fname=null;
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM person Where id=?");
                ps.setString(1, userid);

                ps.execute();
                ResultSet rs = ps.getResultSet();

                rs.next();

                lname = rs.getString("Last_Name");
                fname = rs.getString("First_Name");
                
                if (lname==null)
                    lname="";
                if (fname==null)
                    fname="";
                //    String date = rs.getString("date");
                //    String authorid = rs.getString("author");
                ps.close();
            }
        %>

    </head>
    <body>
        <h1>Profile Information</h1>
        <form action="profile" method="post">
            <table border="0">
                <tr><td>Last Name: </td> <td><input type="text" name="lname" value=<%=lname%>></td></tr>
                <tr><td>First Name:</td> <td> <input type="text" name="fname" value=<%=fname%>></td></tr>

            </table>
            </br>
            <input type="submit" value="Submit" />  &nbsp;&nbsp; &nbsp;
        </form>
    </body>
</html>

