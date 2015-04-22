<%-- 
    Document   : login_check
    Created on : Apr 21, 2015, 10:43:08 PM
    Author     : Leon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String username = request.getParameter("username");
            String pwd = request.getParameter("pwd");
            String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance(); //init driver
            Connection conn = DriverManager.getConnection(dburl);
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user");
            ps.execute();  //execute the query
            ResultSet rs = ps.getResultSet();
            while (rs.next()) {
                if (rs.getString("username").equals(username)) {  //if what's at column username at database matches user's input
                    if (rs.getString("pwd").equals(pwd)) {
                        String id = rs.getString("Id");

                        request.setAttribute("userid", id);

                        ps.close();
        %>

        <jsp:forward page="user_index.jsp"/>


        <%     } else {
                        break;
                    }
                }
            }
            out.println("login failed");
            out.println("<button onclick=\"window.location='index.html'\">back</button>");

            ps.close();
        %>
    </body>
</html>
