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
            if (!type.equals("1")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>");
            } else {
                String itemname = request.getParameter("item_name");
                String uname = request.getParameter("username");
                String itemtype = request.getParameter("item_type");

                if (itemname.equals("")) {
                    itemname = "%";
                }
                if (uname.equals("")) {
                    uname = "%";
                }

                if (itemtype.equals("")) {
                    itemtype = "%";
                }
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT a.id,a.item_name,a.unit_price,sum(s.number_of_units),a.unit_price*sum(s.number_of_units) FROM sale s,advertisement a ,user u Where a.id=s.advertisement and s.user=u.id and a.item_name like ? and a.type like ? and u.username like ? group by a.id");

                ps.setString(1, itemname);
                ps.setString(2, itemtype);

                ps.setString(3, uname);

                ps.execute();
                ResultSet rs = ps.getResultSet();


        %>
    </head>
    <body>
        <h1>Summary Revenue</h1>

        <table border="1">
            <tr>

                <td>Ad_Id</td>
                <td>Item name</td>
                <td>Unit price</td>
                <td>Number of Units</td>
                <td>Revenue</td>
            </tr>
            <%              while (rs.next()) {


            %>
            <tr>

                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>

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