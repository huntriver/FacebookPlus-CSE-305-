<%-- 
    Document   : showMessage
    Created on : Apr 24, 2015, 4:52:40 PM
    Author     : Leon
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            String userid = (String) session.getAttribute("userid");
          
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } 
            else
            {
                String sender=(String) session.getAttribute("sender");
                String date=(String) session.getAttribute("date");
                String content=(String) session.getAttribute("content");
                 String subject=(String) session.getAttribute("subject");
        %>
    </head>
    <body>
        <table> 
            <tr><td>Subject</td><td><input style="width:250px" type="text" name="subject" disabled="disabled" value="<%=subject%>"></td></tr> 
           
            <tr><td>content</td><td><textarea name="content" style="height:150px;width:900px;resize: none;"disabled="disabled" ><%=content%></textarea></td></tr> 
            
        </table> 
             <%=sender%> sends on <%=date%>  
           <% }
        %>
        </br>
         <button type="button"onclick="window.location.href = 'message.jsp'">back</button>
         
    </body>
</html>
