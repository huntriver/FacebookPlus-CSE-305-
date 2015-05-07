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
        <style>
  body {
	background-image: url(img/sky.jpg);
        background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}
        </style>
        <%
            String userid = (String) session.getAttribute("userid");
            String pid = (String) session.getAttribute("pid");
            Boolean isowner = (Boolean) session.getAttribute("owner");
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

                ps = conn.prepareStatement("SELECT * FROM user_likes_post Where User=? and Post=?");
                ps.setString(1, userid);
                ps.setString(2, pid);
                ps.execute();
                rs = ps.getResultSet();
                boolean likepost;
                if (rs.next()) {
                    likepost = true;
                } else {
                    likepost = false;
                }

        %>
    </head>
    <body>
        <%if (isowner || authorid.equals(userid)) { %>
        <form action="modify_post_subject" method="post">
            <%}%>
            <h1> Subject:<input type="text" name="psubject"<%if ((!isowner) && (!authorid.equals(userid))) {%>disabled="disabled"<%}%>  value="<%=subject%>"/> 
                <% if (isowner || authorid.equals(userid)) {%>
                <input type="submit" value="Modify" /> 

        </form>
        <%}%>
    </h1> 
    <%if (isowner || authorid.equals(userid)) { %>
    <form  method="post" action="modify_post">
        <%}%>
        <textarea name="content" <%if ((!isowner) && (!authorid.equals(userid))) {%>disabled="disabled"<%}%>style="height:150px;width:900px;resize: none;"><%=content%></textarea>
        </br>
        <% if (isowner || authorid.equals(userid)) {%>

        <input type="submit" value="Modify">
    </form>
   <%}%>

    <form id="form1" name="form1" method="post" action="<%=likepost ? "dislikepost" : "likepost"%>">
        <%=author%> posted on <%=date%>   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;


        <input name="like" type="image" value="like" src="<%=likepost ? "img/dislike.png" : "img/like.png"%>"  width="40px" height="50px" />
        <% ps = conn.prepareStatement("SELECT Count(*) FROM user_likes_post Where post=?");
            ps.setString(1, pid);

            ps.execute();
            rs = ps.getResultSet();
            rs.next();
        %>
       &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=rs.getString(1)%> likes!   
    </form>



    <% if (isowner || authorid.equals(userid)) {%>
    <a href="delete_post">delete this post</a>
    <%}%>
    <h2>Comments</h2>
    <%
        ps = conn.prepareStatement("SELECT * FROM comment Where post=?");
        ps.setString(1, pid);

        ps.execute();
        rs = ps.getResultSet();
        while (rs.next()) {
            String aid = rs.getString("author");
            PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM user Where id=?");
            ps1.setString(1, aid);
            ps1.execute();
            ResultSet r = ps1.getResultSet();
            r.next();
            String auname = r.getString("username");

            ps1 = conn.prepareStatement("SELECT * FROM user_likes_comment Where User=? and Comment=?");
            ps1.setString(1, userid);
            ps1.setString(2, rs.getString("Id"));
            ps1.execute();
            ResultSet r1 = ps1.getResultSet();
            boolean likecomment;
            if (r1.next()) {
                likecomment = true;
            } else {
                likecomment = false;
            }

            if (isowner || aid.equals(userid)) { %>
    <form  method="post" action="modify_comment">
        <%}%>
        <textarea name="content"  <%if ((!isowner) && (!aid.equals(userid))) {%>disabled="disabled" <%}%>  style="height:150px;width:800px;resize: none;"><%=rs.getString("content")%></textarea>
        </br>
        <% if (isowner || aid.equals(userid)) {%>
        <input name="coid" type="hidden" value="<%=rs.getString("Id")%>">
        <input type="submit" value="Modify">
    </form>
    <%}%>
    <form id="form1" name="form1" method="post" action="<%=likecomment ? "dislikecomment" : "likecomment"%>">
        <%=auname%> posted on <%=rs.getString("date")%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <input name="like" type="image"  src="<%=likecomment ? "img/dislike.png" : "img/like.png"%>"  width="40px" height="50px" />
        <% PreparedStatement ps2= conn.prepareStatement("SELECT Count(*) FROM user_likes_comment Where comment=?");
            ps2.setString(1, rs.getString("Id"));

            ps2.execute();
            ResultSet rs2 = ps2.getResultSet();
            rs2.next();
        %>
       &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <%=rs2.getString(1)%> likes!   
        <input name="cid" type="hidden" value="<%=rs.getString("Id")%>">
    </form>
    <% if (isowner || aid.equals(userid)) {%>
    <a href="delete_comment?coid=<%=rs.getString("Id")%>">delete this comment</a>
    <%}%>
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
<%            conn.close();
    }
%>
</html>
