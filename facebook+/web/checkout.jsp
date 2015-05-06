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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
            String aid = (String) session.getAttribute("baid");
            String num = (String) session.getAttribute("bnum");
            if (userid == null) {
                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM advertisement WHERE id=?");
                ps.setString(1, aid);
                ps.execute();
                ResultSet rs = ps.getResultSet();
                rs.next();
        %>
    </head>
    <body>
        You buy: <br>
        <%=rs.getString("item_name")%><br>
        Number:  <%=num%><br>

        <form action="checkout" method="post">
            <%
                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM user_has_account WHERE user_id=?");
                ps1.setString(1, userid);
                ps1.execute();
                ResultSet rs1 = ps1.getResultSet();
                while (rs1.next()) {
                    PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM account WHERE account_number=?");
                    ps2.setString(1, rs1.getString("Account_Number"));
                    ps2.execute();
                    ResultSet rs2 = ps2.getResultSet();
                    rs2.next();
            %>
            <input type="radio" name="acnum" value="<%=rs1.getString("Account_Number")%>"><%=rs2.getString("Credit_card_number")%>
            <%
                }

            %>
            <br>
            <input type="submit" value="checkout">
        </form>

    </body>

    <button type="button" onclick="window.location.href = 'buy.jsp'">back</button>
    <%                ps.close();
            conn.close();
        }
    %>
</html>