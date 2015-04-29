<%-- 
    Document   : message
    Created on : Apr 24, 2015, 3:18:04 PM
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
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM message Where Receiver=?");
                ps.setString(1, userid);

                ps.execute();
                ResultSet rs = ps.getResultSet();
        %>
    </head>
    <body>
        <h1>Inbox</h1>
        <button type="button"onclick="window.location.href = '${pageContext.request.contextPath}/message'">New Message!</button>
            <div style="left:120px">
<input type="button" value="123213" style="background-color:#66CCFF" />
</div></div>
        <table board="1">
            <tr><td></td><td  width="200">From</td><td  width="300" >Subject</td><td  width="200">Date</td></tr>
            <%
                while (rs.next()) {
                    String subject = rs.getString("Subject");
                    String mid = rs.getString("Id");
                    String date = rs.getString("date");
                    String senderid = rs.getString("sender");
                    String content = rs.getString("content");
                    PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM user Where id=?");
                    ps1.setString(1, senderid);

                    ps1.execute();
                    ResultSet rs1 = ps1.getResultSet();
                    rs1.next();
                    String sender = rs1.getString("username");

            %>    
            <tr> <td><input type="checkbox" name="mid" value=<%=mid%>> </td> <td><%=sender%></td><td><a href="${pageContext.request.contextPath}/show_message?sender=<%=sender%>&date=<%=date%>&subject=<%=subject%>&content=<%=content%>"><%=subject%></a></td><td><%=date%></td></tr>
                    <%
                            ps1.close();
                        }
                    %>





        </table>
        <%
                ps.close();
                conn.close();
                
            }
        %>
        <button type="button"onclick="window.location.href = 'user_index.jsp'">back</button>
    </body>
</html>
