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
        <style>
        body {
	background-image: url(img/undersea.jfif);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
            
        </style>   
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
                
                PreparedStatement ps_ = conn.prepareStatement("SELECT * FROM employee Where id=?");
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE id=?");
                ps.setString(1, userid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();

                if (!rs.getString("type").equals("1")) {
                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                    return ;
                }
               
                
                ps = conn.prepareStatement("SELECT * FROM user");
                ps.execute();
                rs = ps.getResultSet();
          //      ResultSet rs_type = ps_type.getResultSet();
        %>

    </head>
    <body>
        <h1>All Users</h1>
        <form action="list" method="post">
            <table border="1">
                <tr><td class="whiteTextBackground">id</td><td class="whiteTextBackground">username</td><td class="whiteTextBackground">Role</td><td class="whiteTextBackground">Hourly Rate</td>
                </tr>
                <%
                    for (int i = 0; rs.next(); i++) {
                        
                %>
                <tr> <td class="whiteTextBackground"> <% if (!rs.getString("type").equals("1")) { %>  <input type="hidden" name="id" value="<%=rs.getString("id")%>" >  <%}%> <%=rs.getString("id")%></td> 
                    <td class="whiteTextBackground"><%=rs.getString("username")%></td> 
                    <td>  <% if (rs.getString("type").equals("1")) { %> 
                                    Manager
                        <%}
                        else
                    {%>
                        <select name = "type"  >
                         
                            <option value = "2" <% if (rs.getString("type").equals("2"))  { %> selected="selected" <% } %>>Employee</option> 
                            <option value = "3" <% if(rs.getString("type").equals("3"))  { %> selected="selected" <% } %>>Customer</option> 
                          <%  }%>
                        </Select>
                        
                    </td>
                    <td class="whiteTextBackground"> <% if (!rs.getString("type").equals("1")) { %> 
                        <input type="text" name="H_Rate" <% if (rs.getString("type").equals("3")) { %> value="<%=""%>"<% } %>                                            
                                                          <% if (rs.getString("type").equals("2")) {                                                              
                                                              ps_.setString(1, rs.getString("id"));
                                                              ps_.execute();
                                                              ResultSet rs_ = ps_.getResultSet();
                                                              rs_.next();
                                                          %> value="<%=rs_.getString("Hourly_Rate")%>"<% } }%>
                        
                    </td> 

                </tr>
                <%
           
                        }

                        ps_.close();
                        ps.close();
                        conn.close();
                    }
                %>



            </table>
            <input type="submit" value="Submit" /> 
        </form>
    </body>
    <button type="button" onclick="window.location.href = 'manager_page.jsp'">back</button>
</html>
