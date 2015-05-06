<%-- 
    Document   : buy
    Created on : 2015-5-5, 23:08:44
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            }
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
        <h1>You can buy whatever you like in this page!</h1>
        <form action="buy" method="post">
            <table border="1">
                <tr>
                    <td>Item_Name</td>
                    <td>Company</td>
                    <td>Content</td>
                    <td>Price</td>
                    <td>Available_Units</td>
                    <td>Check if buy</td>
                    <td>number you buy</td>
                </tr>
                <%
                    while (rs.next()) {
                %>
                <tr>                    
                    <td><%=rs.getString("item_name")%></td>
                    <td><%=rs.getString("company")%></td>
                    <td><%=rs.getString("content")%></td>
                    <td><%=rs.getString("unit_price")%></td>
                    <td><%=rs.getString("available_units")%></td>
                    <td><input type="checkbox" name="aids" value=<%=rs.getString("Id")%>> </td> 
                    <td><input type="text" name="num" value=<%=""%>> </td>
                </tr>
                <%
                    }
                %>
            </table>
            <input type="submit" value="Buy">
        </form>
        <br>


    </body>
    <%
        ps.close();
        conn.close();

    %>
    <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
</html>
