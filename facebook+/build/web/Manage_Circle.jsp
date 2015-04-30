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
        <% String userid = (String) session.getAttribute("userid");
            String cid = (String) session.getAttribute("cid");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else if (cid == null) {
                out.println(cid);
                out.println("<script language=\"JavaScript\">alert(\"no such a circle！\");self.location='index.html';</script>"); //注意该方法的写法
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps;

                ps = conn.prepareStatement("SELECT * FROM circle Where Id=?");

                ps.setString(1, cid);

                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();
                String cname = rs.getString("Name");
                String oid = rs.getString("owner");
                if (!oid.equals(userid)) {

                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='Circle_page.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                }

                ps = conn.prepareStatement("SELECT * FROM addedto,user Where addedto.Circle_Id=? and addedto.User_Id=user.Id");

                ps.setString(1, cid);

                ps.execute();
                rs = ps.getResultSet();


        %>
    </head>
    <body>
        <form action="modify_circle_name" method="post">
            <h1> Circle Name: <input type="text" name="cname" value="<%=cname%>"/>  
                <input type="submit" value="Modify" /> </h1>

        </form>

        <h2>Membership management</h2>

        <form action="delete_user_from_circle" method="post">

            <table style="width:300px" border="1">
                <tr> <td> </td> <td>username</td><td>roll</td> </tr>
                <% while (rs.next()) {
                %>
                
                <tr>
                    <td>
                       
                        <input type="checkbox" name="dusers" value="<%=rs.getString("id")%>"  <% if (rs.getString("id").equals(oid)) { %>
                                DISABLED <%}%> >
                        
                    </td>
                    <td> <%=rs.getString("username")%></td>
                    <td><%=rs.getString("id").equals(oid) ? "owener" : "member"%></td>
                </tr>
                <br>

                <%}%>
            </table>

            <br>
            <input type="submit" value="Delete Selected Users">
        </form>
        <%ps.close();
                conn.close();
            }
        %>
        <br>
        <br>
        <form action="send_invitation" method="post">
            Send an invitation:  <input type="text" name="iuname" /> 
            
            <input type="submit" value="Send" />
        </form>
        <br>
        <br>

        <input name="delete_circle" type="button" value="Delete this circle"  onClick="if (confirm('Are u sure? (All post and members will lose)')) {
                    location.href = '${pageContext.request.contextPath}/delete_circle';
                }" />
     <a href="Circle_page.jsp">back</a>
    </body>
</html>
