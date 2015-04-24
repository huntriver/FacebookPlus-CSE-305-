<%-- 
    Document   : newMessage
    Created on : Apr 24, 2015, 3:49:58 PM
    Author     : Leon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>New Message</h1>
        <form action="new_message" method="post"> 
            <table> 
                <tr><td>Subject</td><td><input style="width:250px" type="text" name="subject" value=<%=session.getAttribute("m_subject")%>></td></tr> 
                 <tr><td>To</td><td><input style="width:250px" type="text" name="receiver" value=<%=session.getAttribute("m_receiver")%> ></td></tr> 
                <tr><td>content</td><td><textarea name="content" style="height:150px;width:900px;resize: none;" ><%=session.getAttribute("m_content")%></textarea></td></tr> 
                <tr><td></td><td><input type="submit"  value="Send"></td></tr> 
            </table> 
        </form> 
    </body>
</html>
