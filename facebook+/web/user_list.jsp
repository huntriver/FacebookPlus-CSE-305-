<%-- 
    Document   : user_list
    Created on : 2015-4-26, 14:43:59
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Users</title>
        <%
            String userid = (String) session.getAttribute("userid");
   
          
            String type = "3";

            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                //     PreparedStatement ps = conn.prepareStatement("SELECT Id,Last_Name,First_Name FROM person");
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user");

                //ps.setString(1, userid);
                //ps_type.setString(1, userid);
                ps.execute();
                //    ps_type.execute();

                ResultSet rs = ps.getResultSet();
          //      ResultSet rs_type = ps_type.getResultSet();
        %>

    </head>
    <body>
        <h1>All Users</h1>
        <form action="list" method="post">
            <table border="1">
                <tr><td>id</td><td>username</td><td>roll</td>
                </tr>
                <%
                    for (int i = 0; rs.next(); i++) {
                %>
                <tr> <td> <input type="hidden" name="id" value="<%=rs.getString("id")%>" /> <%=rs.getString("id")%></td> 
                    <td><%=rs.getString("username")%></td> 
                    <td> 
                        <select name = "type" <% if (rs.getString("type").equals("1")) { %> disabled="disabled" <% } %> >
                            <% if (rs.getString("type").equals("1")) { %>  <option value = "1"  select qed="selected" >Manager</option> <% } %>
                            <option value = "2" <% if (rs.getString("type").equals("2"))  { %> selected="selected" <% } %>>Employee</option> 
                            <option value = "3" <% if(rs.getString("type").equals("3"))  { %> selected="selected" <% } %>>Customer</option> 
                        </Select>
                        
                    </td>

                </tr>
                <%
           
                        }


                        ps.close();
                        conn.close();
                    }
                %>



            </table>
            <input type="submit" value="Submit" /> 
        </form>
    </body>
</html>
