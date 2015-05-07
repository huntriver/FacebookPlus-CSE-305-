<%-- 
    Document   : invitation
    Created on : 2015-4-30, 11:45:48
    Author     : Leon
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        body {
	background-image: url(img/purpleflower.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


        <% String userid = (String) session.getAttribute("userid");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);

                PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM invitation Where user_id=?");
                ps.setString(1, userid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();
                int inumber = Integer.valueOf(rs.getString(1));

                ps = conn.prepareStatement("SELECT * FROM invitation Where user_id=?");

                ps.setString(1, userid);
                ps.execute();
                rs = ps.getResultSet();

                //  out.println(inumber);
        %>
    </head>
    <body>
        <h1>Invitations</h1>
        <table>
            <%if (inumber > 0) { %>
            <tr><td>Circle Name</td></tr>
            <%while (rs.next()) {
                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM circle Where id=?");
                    String cid = rs.getString("circle_id");
                    ps1.setString(1, cid);
                    ps1.execute();
                    ResultSet rs1 = ps1.getResultSet();
                    rs1.next();
                    String cname = rs1.getString("name");
                    ps1.close();

            %>
            <tr><td><%=cname%>   </td>

                <td>   <input type="button" value="Accept" onclick="location.href = '${pageContext.request.contextPath}/acceptinvitation?uid=<%=userid%>&cid=<%=cid%>'"> </td>

                <td>   <input type="button" value="Discard" onclick="location.href = '${pageContext.request.contextPath}/discardinvitation?uid=<%=userid%>&cid=<%=cid%>'"> </td>
                </td>
            </tr>


            <%       }
                    }
            else
                %>
                <h2>There is no new invitation</h2>
                <%
                    out.println("</br>");
                    ps.close();
                    conn.close();
                }
            %>
        </table>
        <a href="user_index.jsp">back</a>
    </body>
</html>
