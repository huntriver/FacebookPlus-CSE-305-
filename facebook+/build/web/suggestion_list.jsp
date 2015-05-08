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
        <style>
        body {
	background-image: url(img/grace.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}            
        </style> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            String uname = request.getParameter("uname");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
            else
            if (!type.equals("2")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else if (uname.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"username must not be empty！\");self.location='employee_pagex.jsp';</script>");
            } else {

                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user where username=?");
                ps.setString(1, uname);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                if (!rs.next()) {
                    ps.close();
                    conn.close();
                    out.println("<script language=\"JavaScript\">alert(\"username not exist！\");self.location='employee_pagex.jsp';</script>");
                } else {
                    String uuid = rs.getString("id");

        %>


    </head>
    <body>
        <h1>Suggestion List For <%=uname%></h1>
        <table border="1">

            <tr> <td style="width:100px">item_id</td><td style="width:200px">item_name</td> </tr>
            <%
                ps = conn.prepareStatement("SELECT advertisement.id,advertisement.item_name FROM advertisement where advertisement.employee_id=? and advertisement.available_units>0 and advertisement.type IN "
                        + "(Select DISTINCT(advertisement.type) FROM advertisement,sale,user where advertisement.id=sale.advertisement and user.id=sale.user and user.id=? )");
                ps.setString(1, userid);
                ps.setString(2, uuid);
                ps.execute();
                rs = ps.getResultSet();
                while (rs.next()) {
            %>
            <tr> <td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td></tr>
            <%}%>

        </table>
        <button type="button" onclick="window.location.href = 'employee_page.jsp'">back</button>
        <%

                }
                ps.close();
                conn.close();
            }

        %>

    </body>
</html>
