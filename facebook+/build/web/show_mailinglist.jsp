<%-- 
    Document   : manager_profile
    Created on : 2015-4-26, 14:40:47
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
            if (!type.equals("2")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                //     PreparedStatement ps = conn.prepareStatement("SELECT Id,Last_Name,First_Name FROM person");
                PreparedStatement ps = conn.prepareStatement("SELECT user.username,person.email_address FROM user,person WHERE user.id=person.id and user.type='3'");
                ps.execute();
                ResultSet rs = ps.getResultSet();
        %>


    </head>
    <body>
        <h1>Customer Mailing Lists</h1>
        <table border="1">
            <tr> <td>Username</a></td> <td>Email Address</td></tr>

            <% while (rs.next()) {
            %>

            <tr> <td> <%=rs.getString(1)%></td><td><%if (rs.getString(2) == null)%><%=""%><%if (rs.getString(2) != null)%><%=rs.getString(2)%></td></tr> 
            <%}%>       
        </table>
        <%
            ps.close();
                conn.close();
            }%>
    </body>
    <button type="button" onclick="window.location.href = 'employee_page.jsp'">back</button>
</html>
