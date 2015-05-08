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
        <style>
        body {
	background-image: url(img/gold.jpg);
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
            if (!type.equals("1")) {
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
        <h1>Advertisements</h1>
       
            <table border="1">
                <tr>
                  
                    <td>Item_Name</td>
                    <td>Company</td>
                    <td>Type</td>
                    <td>Content</td>
                    <td>Price</td>
                    <td>Available_Units</td>
                </tr>
                <%              while (rs.next()) {


                %>
                <tr>
                
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