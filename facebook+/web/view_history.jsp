<%-- 
    Document   : account
    Created on : 2015-4-30, 22:58:44
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
            String acnum =(String) session.getAttribute("acnum");
          
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM sale Where account=?");
               
                ps.setString(1, acnum);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                %>
              
        
      
    </head>
    <body>
        
        <table border="1">
            <tr><td>item_name</td><td>number of units</td><td>sale date</td></tr>
                <%
                while(rs.next()){
                   
                    
                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM advertisement Where id=?");
               
                ps1.setString(1, rs.getString("advertisement"));
                ps1.execute();
                ResultSet rs1 = ps1.getResultSet();
               rs1.next();
                 
                    %>
                    
                    <tr><td><%=rs1.getString("item_name")%></td>
                   <td><%=rs.getString("number_of_units")%></td>
                        <td>
                               
                           <%=rs.getString("date")%>
                        </td>
                    </tr>
                    <%    
                    ps1.close();
                }

         %>
         
        </table>
     
            <button type="button" onclick="window.location.href = 'account.jsp'">back</button>
    </body>
          <%
                ps.close();
                conn.close();
            }
            
          %>
</html>
