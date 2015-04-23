<%-- 
    Document   : post_page
    Created on : Apr 23, 2015, 11:26:54 AM
    Author     : Leon
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            String userid = (String) session.getAttribute("userid");
            String pid = (String) session.getAttribute("pid");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM post Where id=?");
                ps.setString(1, pid);

                ps.execute();
                ResultSet rs = ps.getResultSet();

                rs.next();
                String subject = rs.getString("Subject");
                String content = rs.getString("content");
                String date = rs.getString("date");
                String authorid = rs.getString("author");

                ps = conn.prepareStatement("SELECT * FROM user Where id=?");
                ps.setString(1, authorid);

                ps.execute();
                rs = ps.getResultSet();
                rs.next();
                String author = rs.getString("username");

                ps.close();

       %>
    </head>
    <body>
        <h1>Subject: <%=subject%></h1>
        <textarea name="textarea" disabled="disabled"style="height:150px;width:900px;resize: none;"><%=content%></textarea>
        </br>
        <%=author%> posted on <%=date%>
        <h2>Comments</h2>
        <%
                ps = conn.prepareStatement("SELECT * FROM comment Where post=?");
                ps.setString(1, pid);

                ps.execute();
                rs = ps.getResultSet();
                while (rs.next())
                {
                   String aid=rs.getString("author");
                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM user Where id=?");
                    ps1.setString(1, aid);
                    ps1.execute();
                    ResultSet r=ps1.getResultSet();
                    r.next();
                    
                   %>
                     <textarea name="textarea" disabled="disabled"style="height:150px;width:800px;resize: none;"><%=rs.getString("content")%></textarea>
                     </br> <%=r.getString("username")%> posted on <%=rs.getString("date")%>
                     </br>
                   <%
                   ps1.close();
                }

        %>
         <h2>Make a Comment</h2>
        <form action="new_comment" method="post"> 
            <table> 
                <tr><td>content</td><td><textarea name="content" style="height:150px;width:900px;resize: none;"></textarea></td></tr> 
                <tr><td></td><td><input type="submit" name="submit" value="Submit"></td></tr> 
            </table> 
        </form> 
         
          </br></br></br>
            <a href="Circle_page.jsp">back</a>
            &nbsp;
            <a href="logout.jsp">logout</a>
    </body>
        <% }
        %>
</html>
