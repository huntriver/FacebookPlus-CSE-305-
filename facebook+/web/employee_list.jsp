<%-- 
    Document   : normal_user_list
    Created on : 2015-5-5, 5:12:14
    Author     : yishuo wang
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        body {
	background-image: url(img/lavenderfarm.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}            
        </style>   
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Employees</title>
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            } 
            else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE id=?");
                ps.setString(1, userid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();

                if (!rs.getString("type").equals("1") && !rs.getString("type").equals("1")) {
                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                    return ;
                }
 
                ps = conn.prepareStatement("SELECT * FROM user WHERE type=2");
                ps.execute();
                rs = ps.getResultSet();
        %>
    </head>
    <body>
        <h1>All Employees</h1>
            <table border="1">
                <tr><td>id</td><td>username</td><td>Edit</td></tr>
                <%
                    for (int i = 0; rs.next(); i++) {                        
                %>
                <tr><td> <%=rs.getString("id")%> </td> 
                    <td><%=rs.getString("username")%></td>    

                    <td><button type="button" onclick="window.location.href = 'modify_profile?uid=<%=rs.getString("id")%>'">go</button></td> 
                </tr>
                <%
                    }
                    ps.close();
                    conn.close();
            }
                %>
            </table>
    </body>
    <button type="button" onclick="window.location.href = 'manager_page.jsp'">back</button>
</html>