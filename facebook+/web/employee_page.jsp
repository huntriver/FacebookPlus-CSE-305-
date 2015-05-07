<%-- 
    Document   : manager_profile
    Created on : 2015-4-26, 14:40:47
    Author     : yishuo wang
purplefractal.jfif
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <style>
        body {
	background-image: url(img/purplefractal.jfif);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>   
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
            else
            if (!type.equals("2")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {

        %>


    </head>
    <body>
        <h1 class="whiteTextBackground">Employee Page</h1>
        <table border="0">
            <tr> <td class="whiteTextBackground"><a href="normal_user_list.jsp">All Customer</a></td> </tr>
            <tr> <td class="whiteTextBackground"> <a href="all_employee.jsp">all Employee</a></td></tr> 
            <tr> <td class="whiteTextBackground"><a href="advertisement.jsp">Advertisements</a> </td></tr>
            <tr> <td class="whiteTextBackground"> <a href="show_mailinglist.jsp">show customer mailing list</a></td></tr> 
            
            <form action="suggestion_list.jsp" method="post">
                <tr> <td class="whiteTextBackground"> Produce a list of item suggestion for a given customer:<input type="text" name="uname"> <input type="submit" value="GO"></td></tr> 
             </form>

            <tr> <td>          <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button></td></tr>
        </table>
        <%}%>
    </body>
</html>
