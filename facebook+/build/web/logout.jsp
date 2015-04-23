<%-- 
    Document   : logout
    Created on : 2015-4-22, 22:12:29
    Author     : 鑫河
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.invalidate();
            response.sendRedirect("index.html");
        %> 
    </body>
</html>
