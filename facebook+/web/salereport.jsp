<%-- 
    Document   : manager_profile
    Created on : 2015-4-26, 14:40:47
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        body {
	background-image: url(img/floral.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            String[] Months = {"january", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            String month = request.getParameter("month");

            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else if (!type.equals("1") || (month == null)) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法

            } else if (month.equals("")) {
                out.println("<script language=\"JavaScript\">alert(\"you must choose one month！\");self.location='manager_page.jsp';</script>");
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                //     PreparedStatement ps = conn.prepareStatement("SELECT Id,Last_Name,First_Name FROM person");
                PreparedStatement ps = conn.prepareStatement("SELECT A.id,A.Item_Name,a.employee_id,sum(p.number_of_units),sum(p.number_of_units*a.unit_price) from Sale p,Advertisement A WHERE a.id=p.advertisement and MONTH(p.date)=? group by a.id");

                ps.setString(1, month);
                ps.execute();
                ResultSet rs = ps.getResultSet();

        %>
    </head>
    <body>
        <h1>Sale Report For <%=Months[Integer.valueOf(month)-1]%></h1>
        <table border="1">
            <tr><td>Advertisement Id </td><td>Advertisement name</td><td>Employee_Id</td><td>Monthly sales</td><td>Monthly sales volume</td> </tr>
            <%while (rs.next()) {%>
            <tr><td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
            </tr>
            <%}%>
        </table>
        <button type="button" onclick="window.location.href = 'manager_page.jsp'">back</button>
    </body>
    <%
            ps.close();
            conn.close();

        }
    %>
</html>
