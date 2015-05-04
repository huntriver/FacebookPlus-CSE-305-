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
               }
             else{
                 
             %>
           
        
    </head>
    <body>
        <h1>Employee Page</h1>
        <a href="user_list.jsp">All Users</a> 
       <a href="advertisement.jsp">Advertisments</a> 
    </body>
    <%}%>
</html>
