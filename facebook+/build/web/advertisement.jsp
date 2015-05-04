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
            if (!type.equals("2")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {

                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM advertisement");
                ps.execute();
                ResultSet rs = ps.getResultSet();


        %>
    </head>
    <body>
        <h1>Advertisments</h1>
         <form action="delete_ad" method="post">
        <table border="1">
            <tr>
                <td></td>
                <td>Item_Name</td>
                <td>Company</td>
                <td>Content</td>
                <td>Price</td>
                <td>Available_Units</td>
            </tr>
            <%              while (rs.next()) {


            %>
            <tr>
                <td><input   type="checkbox" name="aids" value=<%=rs.getString("id")%>> </td> 
                <td><%=rs.getString("item_name")%></td>
                <td><%=rs.getString("company")%></td>
                <td><%=rs.getString("content")%></td>
                <td><%=rs.getString("unit_price")%></td>
                <td><%=rs.getString("available_units")%></td>
            </tr>
            <%
                }
            %>
        </table>
        <input type="submit" value="Delete Selected Advertisments">
 </form>
    </body>
    <%
        }
    %>
</html>