<%-- 
    Document   : user_profile
    Created on : Apr 23, 2015, 4:18:08 PM
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%
            String userid = (String) session.getAttribute("userid");
            String lname = null;
            String fname = null;
            //String Sex = null;
            String Address = null;
            String City = null;
            String State = null;
            String Zip = null;
            String Tel = null;
            String Email = null;
            //String Preference = null;
            
            String type = null;
                    
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM person Where id=?");
                PreparedStatement ps_type = conn.prepareStatement("SELECT * FROM user Where id=?");
                
                ps.setString(1, userid);
                ps_type.setString(1, userid);
                
                ps.execute();
                ps_type.execute();
                
                ResultSet rs = ps.getResultSet();
                ResultSet rs_type = ps_type.getResultSet();

                rs.next();
                rs_type.next();
                
                lname = rs.getString("Last_Name");
                fname = rs.getString("First_Name");
                Address = rs.getString("Address");
                City = rs.getString("City");
                State = rs.getString("State");
                Zip = rs.getString("Zip_Code");
                Tel = rs.getString("Telephone");
                Email = rs.getString("Email_Address");
                
                type = rs_type.getString("type");

                if (lname == null) {
                    lname = "";
                }
                if (fname == null) {
                    fname = "";
                }
                if (Address == null) {
                    Address = "";
                }
                if (City == null) {
                    City = "";
                }
                if (State == null) {
                    State = "";
                }
                if (Zip == null) {
                    Zip = "";
                }
                if (Tel == null) {
                    Tel = "";
                }
                if (Email == null) {
                    Email = "";
                }

                //    String date = rs.getString("date");
                //    String authorid = rs.getString("author");
                ps.close();
            }
        %>

    </head>
    <body>
        <h1>Profile Information</h1>
        <%
        if(type.equals("1")){
        %>
        <a href="manager_profile.jsp">Manager Profile</a> 
        <%
        }
        %>
        
        <form action="profile" method="post">
            <table border="0">
                <tr><td>Last Name: </td> <td><input type="text" name="lname" value=<%=lname%>></td></tr>
                <tr><td>First Name:</td> <td> <input type="text" name="fname" value=<%=fname%>></td></tr>
                <tr><td>Address: </td> <td><input type="text" name="Address" value=<%=Address%>></td></tr>
                <tr><td>City:</td> <td> <input type="text" name="City" value=<%=City%>></td></tr>
                <tr><td>State: </td> <td>
                        <select name = "State">
                            <option value = "">Choose State</option>
                            <option value = "AL">AL</option>
                            <option value = "AK">AK</option>
                            <option value = "AZ">AZ</option>
                            <option value = "AR">AR</option>
                            <option value = "CA">CA</option>
                            <option value = "CO">CO</option>
                            <option value = "CT">CT</option>
                            <option value = "DE">DE</option>
                            <option value = "FL">FL</option>
                            <option value = "GA">GA</option>
                            <option value = "HI">HI</option>
                            <option value = "ID">ID</option>
                            <option value = "IL">IL</option>
                            <option value = "IN">IN</option>
                            <option value = "IA">IA</option>
                            <option value = "KS">KS</option>
                            <option value = "KY">KY</option>
                            <option value = "LA">LA</option>
                            <option value = "ME">ME</option>
                            <option value = "MD">MD</option>
                            <option value = "MA">MA</option>
                            <option value = "MI">MI</option>
                            <option value = "MN">MN</option>
                            <option value = "MS">MS</option>
                            <option value = "MO">MO</option>
                            <option value = "MT">MT</option>
                            <option value = "NE">NE</option>
                            <option value = "NV">NV</option>
                            <option value = "NH">NH</option>
                            <option value = "NJ">NJ</option>
                            <option value = "NM">NM</option>
                            <option value = "NY">NY</option>
                            <option value = "NC">NC</option>
                            <option value = "ND">ND</option>
                            <option value = "OH">OH</option>
                            <option value = "OK">OK</option>
                            <option value = "OR">OR</option>
                            <option value = "PA">PA</option>
                            <option value = "RI">RI</option>
                            <option value = "SC">SC</option>
                            <option value = "SD">SD</option>
                            <option value = "TN">TN</option>
                            <option value = "TX">TX</option>
                            <option value = "UT">UT</option>
                            <option value = "VT">VT</option>
                            <option value = "VA">VA</option>
                            <option value = "WA">WA</option>
                            <option value = "WV">WV</option>
                            <option value = "WI">WI</option>
                            <option value = "WY">WY</option>
                            <option value = "OTHER">OTHER</option>
                    </td></tr>



                <tr><td>Zip Code:</td> <td> <input type="text" name="Zip" value=<%=Zip%>></td></tr>
                <tr><td>Telephone: </td> <td><input type="text" name="Tel" value=<%=Tel%>></td></tr>
                <tr><td>Email Address:</td> <td> <input type="text" name="Email" value=<%=Email%>></td></tr>
                <input type="checkbox" name="fruit" value ="apple" >苹果<br>
                <input type="checkbox" name="fruit1" value ="orange">桔子<br>
                <input type="checkbox" name="fruit2" value ="mango">芒果<br>
            </table>
            </br>
            <input type="submit" value="Submit" />  &nbsp;&nbsp; &nbsp;
        </form>
    </body>
</html>

