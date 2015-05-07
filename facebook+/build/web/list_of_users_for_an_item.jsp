<%-- 
    Document   : advertisement
    Created on : 2015-5-4, 10:53:54
    Author     : Leon
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
            else
            if (!type.equals("1")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {
                String itemname = request.getParameter("item_name");

                if (itemname.equals("")) {
                    itemname = "%";
                }

                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT Distinct u.Id,u.Username,p.last_name, p.first_name FROM sale s, advertisement a, user u, person p Where a.id=s.advertisement and u.id=p.id and "
                        + "s.user=u.id and a.item_name like ?");
                //   out.println(itemname+" "+lname+" "+fname+" "+uname);
                ps.setString(1, itemname);

                ps.execute();
                ResultSet rs = ps.getResultSet();


        %>
    </head>
    <body>
        <h1>All Customers who buy <%=itemname%></h1>

        <table border="1">
            <tr>
                <td>User Id</td>
                <td>User Name</td>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
            <%              while (rs.next()) {


            %>
            <tr>

                <td><%=rs.getString("Id")%></td>
                <td><%=rs.getString("Username")%></td>
                <td><%=rs.getString("first_name")%></td>
                <td><%=rs.getString("last_name")%></td>

                <%
                    }
                %>
        </table>

        <br>
        <br>
        <br>
        <button type="button" onclick="window.location.href = 'manager_page.jsp'">back</button>
    </body>
    <%
            ps.close();
            conn.close();
        }
    %>

</html>