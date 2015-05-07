<%-- 
    Document   : normal_user_list
    Created on : 2015-5-5, 5:12:14
    Author     : yishuo wang
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Users</title>
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);

                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE id=?");
                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM person WHERE id=?");
                PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM user_preferences WHERE id=?");
                ps.setString(1, userid);

                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();

                if (!rs.getString("type").equals("2")) {
                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                    return;
                }

                ps = conn.prepareStatement("SELECT * FROM user WHERE type=2");
                ps.execute();
                rs = ps.getResultSet();
        %>
    </head>
    <body>
        <h1>All Employees</h1>
        <table border="1">
            <tr><td>id</td><td>username</td><td>Rating</td><td>Last Name</td><td>First Name</td><td>Birth</td><td>Gender</td><td>Address</td><td>City</td><td>State</td><td>Zip Code</td><td>Telephone</td><td>Email Address</td><td>Preferences</td></tr>
            <%
                for (int i = 0; rs.next(); i++) {
                    ps1.setString(1, rs.getString("Id"));
                    ps1.execute();
                    ResultSet rs1 = ps1.getResultSet();
                    rs1.next();
                    ps2.setString(1, rs.getString("Id"));
                    ps2.execute();
                    ResultSet rs2 = ps2.getResultSet();

            %>
            <tr><td> <%=rs.getString("id")%> </td><td><%=rs.getString("username")%></td><td><%=rs.getString("Rating")%></td><td> <%=rs1.getString("Last_Name")%> </td><td><%=rs1.getString("First_Name")%></td>
                <td> <%=rs1.getString("DOB")%> </td><td><%=rs1.getString("SEX")%></td><td> <%=rs1.getString("Address")%> </td><td><%=rs1.getString("City")%></td> 
                <td> <%=rs1.getString("State")%> </td><td><%=rs1.getString("Zip_Code")%></td><td> <%=rs1.getString("Telephone")%> </td><td><%=rs1.getString("Email_Address")%></td>                       
                <td><%while (rs2.next()) {%><%=rs2.getString("preference")%>&nbsp;<%}%></td>

            </tr>
            <%
                    }
                    ps.close();
                    conn.close();
                }
            %>
        </table>
    </body>
    <button type="button" onclick="window.location.href = 'employee_page.jsp'">back</button>
</html>