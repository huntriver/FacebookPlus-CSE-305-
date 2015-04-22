<%-- 
    Document   : user_index
    Created on : Apr 21, 2015, 11:01:11 PM
    Author     : Leon
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>My Circles</h1>
        <%= request.getParameter("userid")%>
        <% String userid = request.getParameter("userid");
            String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance(); //init driver
            Connection conn = DriverManager.getConnection(dburl);
        %>
    
    </body>
</html>
