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
        <style>
        body {
	background-image: url(img/pinkflower.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            }
            else
            {
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

        <table border="1">
            <tr>
                <td>Item_Name</td>
                <td>Company</td>
                <td>Type</td>
                <td>Content</td>
                <td>Price</td>
                <td>Available_Units</td>
                <td>number you buy</td>
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>        

            <form action="buy?aid=<%=rs.getString("id")%>" method="post" >
                <td><%=rs.getString("item_name")%></td>
                <td><%=rs.getString("company")%></td>
                <td><%=rs.getString("type")%></td>
                <td><%=rs.getString("content")%></td>
                <td><%=rs.getString("unit_price")%></td>
                <td><%=rs.getString("available_units")%></td>
                <td><input type="text" name="num" > </td>
                <td>  <input type="submit" value="Buy"></td>
            </form>
        </tr>
        <%
            }
        %>
    </table>

    <br>
    <h1>BEST-SELLER</h1>
    <%
         ps = conn.prepareStatement("DROP view IF EXISTS ads");
         ps.execute();
        ps = conn.prepareStatement("create view ads as (select sale.advertisement,count(sale.advertisement) as counts from sale group by sale.advertisement) ");
        ps.execute();
          ps = conn.prepareStatement("select * from advertisement,ads where advertisement.id=ads.advertisement order by ads.counts desc");
        ps.execute();
        rs = ps.getResultSet();
    %>
    <table border="1">    
        <tr>
            <td>Item_Name</td>
            <td>Company</td>
            <td>Type</td>
            <td>Content</td>
            <td>Price</td>
            <td>Available_Units</td>
            <td>Sold Times</td>
        </tr>
        <%  while (rs.next()) {
        %> <tr>

            <td><%=rs.getString("item_name")%></td>
            <td><%=rs.getString("company")%></td>
            <td><%=rs.getString("type")%></td>
            <td><%=rs.getString("content")%></td>
            <td><%=rs.getString("unit_price")%></td>
            <td><%=rs.getString("available_units")%></td>
             <td><%=rs.getString("counts")%></td>
        </tr>


        <%
            }


        %>
    </table>
    <br>
 <h1>Suggestion Items</h1>
     <%
         ps = conn.prepareStatement("select * from advertisement where advertisement.type in (select user_preferences.preference from user_preferences where user_preferences.id=?)");
         ps.setString(1, userid);
         ps.execute();
        
        rs = ps.getResultSet();
    %>
    <table border="1">    
        <tr>
            <td>Item_Name</td>
            <td>Company</td>
            <td>Type</td>
            <td>Content</td>
            <td>Price</td>
            <td>Available_Units</td>
         
        </tr>
        <%  while (rs.next()) {
        %> <tr>

            <td><%=rs.getString("item_name")%></td>
            <td><%=rs.getString("company")%></td>
            <td><%=rs.getString("type")%></td>
            <td><%=rs.getString("content")%></td>
            <td><%=rs.getString("unit_price")%></td>
            <td><%=rs.getString("available_units")%></td>
            
        </tr>


        <%
            }


        %>
    </table>
 
    <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
</body>
<%    ps.close();
    conn.close();
            }
%>
</html>
