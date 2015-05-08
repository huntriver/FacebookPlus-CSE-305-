<%-- 
    Document   : search_result
    Created on : 2015-5-2, 19:40:09
    Author     : 鑫河
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        body {
	background-image: url(img/colorpark.jfif);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}            
        </style> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <% String userid = (String) session.getAttribute("userid");
            String cname = request.getParameter("cname");
            if (cname==null)
            {
                cname=(String) session.getAttribute("searchString");
            }
            
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            }
            else
            if (cname!=null){
                session.setAttribute("searchString", cname);
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM circle Where name LIKE ?");
                ps.setString(1, "%"+cname+"%");
                ps.execute();
                ResultSet rs = ps.getResultSet();

        %>


    </head>
    <body>
        <h1>Search Result</h1>
        <%if (rs.next()) {%>
        <table>
            <%do {
                PreparedStatement ps1  = conn.prepareStatement("SELECT * FROM addedto Where User_id=? and Circle_id=?");
                ps1.setString(1, userid);
                String cid=rs.getString("id");
                ps1.setString(2, cid);
                ps1.execute();
                ResultSet rs1=ps1.getResultSet();
                Boolean p=rs1.next();
            %>
            <tr>
                <td> <%if (p) {%>  <a href="${pageContext.request.contextPath}/circle?cid=<%=cid%>"> <%}%><%=rs.getString("name")%> <%if (p) {%></a><%}%>  </td>
                 <td>   <input type="button" value="Apply" <%if (p) {%> disabled="disabled"<%}%>onclick="location.href = '${pageContext.request.contextPath}/applyjoin?cid=<%=cid%>'"> </td>
             
            <tr>
                <%
                ps1.close();
            } while (rs.next());%>
        </table>
        <%} else {%>
        No such a Circle!
        <%}
            ps.close();

            conn.close();
            }
        %>
           <a href="user_index.jsp">back</a>
    </body>
</html>
