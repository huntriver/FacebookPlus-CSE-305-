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
        <title>logout</title>
        <%String userid = (String) session.getAttribute("userid");
          if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
          else
          { %>
    </head>
    <body>
        <%
            session.invalidate();
            response.sendRedirect("index.html");
        %> 
    </body>
   <% }%>
</html>
