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
                <tr><td>Last Name: </td> <td><input type="text" name="lname" value="<%=lname%>"></td></tr>
                <tr><td>First Name:</td> <td> <input type="text" name="fname" value="<%=fname%>"></td></tr>
                <tr><td>Address: </td> <td><input type="text" name="Address" value="<%=Address%>"></td></tr>
                <tr><td>City:</td> <td> <input type="text" name="City" value="<%=City%>"></td></tr>
                <tr><td>State: </td> <td>
                        <select name = "State">
                            <option value = "">Choose State</option>
                            <option value = "AL" <% if (State.equals("AL")) { %> selected="selected" <% } %>>AL</option> 
                            <option value = "AK" <% if (State.equals("AK")) { %> selected="selected" <% } %>>AK</option>
                            <option value = "AZ" <% if (State.equals("AZ")) { %> selected="selected" <% } %>>AZ</option>
                            <option value = "AR" <% if (State.equals("AR")) { %> selected="selected" <% } %>>AR</option>
                            <option value = "CA" <% if (State.equals("CA")) { %> selected="selected" <% } %>>CA</option>
                            <option value = "CO" <% if (State.equals("CO")) { %> selected="selected" <% } %>>CO</option>
                            <option value = "CT" <% if (State.equals("CT")) { %> selected="selected" <% } %>>CT</option>
                            <option value = "DE" <% if (State.equals("DE")) { %> selected="selected" <% } %>>DE</option>
                            <option value = "FL" <% if (State.equals("FL")) { %> selected="selected" <% } %>>FL</option>
                            <option value = "GA" <% if (State.equals("GA")) { %> selected="selected" <% } %>>GA</option>
                            <option value = "HI" <% if (State.equals("HI")) { %> selected="selected" <% } %>>HI</option>
                            <option value = "ID" <% if (State.equals("ID")) { %> selected="selected" <% } %>>ID</option>
                            <option value = "IL" <% if (State.equals("IL")) { %> selected="selected" <% } %>>IL</option>
                            <option value = "IN" <% if (State.equals("IN")) { %> selected="selected" <% } %>>IN</option>
                            <option value = "IA" <% if (State.equals("IA")) { %> selected="selected" <% } %>>IA</option>
                            <option value = "KS" <% if (State.equals("KS")) { %> selected="selected" <% } %>>KS</option>
                            <option value = "KY" <% if (State.equals("KY")) { %> selected="selected" <% } %>>KY</option>
                            <option value = "LA" <% if (State.equals("LA")) { %> selected="selected" <% } %>>LA</option>
                            <option value = "ME" <% if (State.equals("ME")) { %> selected="selected" <% } %>>ME</option>
                            <option value = "MD" <% if (State.equals("MD")) { %> selected="selected" <% } %>>MD</option>
                            <option value = "MA" <% if (State.equals("MA")) { %> selected="selected" <% } %>>MA</option>
                            <option value = "MI" <% if (State.equals("MI")) { %> selected="selected" <% } %>>MI</option>
                            <option value = "MN" <% if (State.equals("MN")) { %> selected="selected" <% } %>>MN</option>
                            <option value = "MS" <% if (State.equals("MS")) { %> selected="selected" <% } %>>MS</option>
                            <option value = "MO" <% if (State.equals("MO")) { %> selected="selected" <% } %>>MO</option>
                            <option value = "MT" <% if (State.equals("MT")) { %> selected="selected" <% } %>>MT</option>
                            <option value = "NE" <% if (State.equals("NE")) { %> selected="selected" <% } %>>NE</option>
                            <option value = "NV" <% if (State.equals("NV")) { %> selected="selected" <% } %>>NV</option>
                            <option value = "NH" <% if (State.equals("NH")) { %> selected="selected" <% } %>>NH</option>
                            <option value = "NJ" <% if (State.equals("NJ")) { %> selected="selected" <% } %>>NJ</option>
                            <option value = "NM" <% if (State.equals("NM")) { %> selected="selected" <% } %>>NM</option>
                            <option value = "NY" <% if (State.equals("NY")) { %> selected="selected" <% } %>>NY</option>
                            <option value = "NC" <% if (State.equals("NC")) { %> selected="selected" <% } %>>NC</option>
                            <option value = "ND" <% if (State.equals("ND")) { %> selected="selected" <% } %>>ND</option>
                            <option value = "OH" <% if (State.equals("OH")) { %> selected="selected" <% } %>>OH</option>
                            <option value = "OK" <% if (State.equals("OK")) { %> selected="selected" <% } %>>OK</option>
                            <option value = "OR" <% if (State.equals("OR")) { %> selected="selected" <% } %>>OR</option>
                            <option value = "PA" <% if (State.equals("PA")) { %> selected="selected" <% } %>>PA</option>
                            <option value = "RI" <% if (State.equals("RI")) { %> selected="selected" <% } %>>RI</option>
                            <option value = "SC" <% if (State.equals("SC")) { %> selected="selected" <% } %>>SC</option>
                            <option value = "SD" <% if (State.equals("SD")) { %> selected="selected" <% } %>>SD</option>
                            <option value = "TN" <% if (State.equals("TN")) { %> selected="selected" <% } %>>TN</option>
                            <option value = "TX" <% if (State.equals("TX")) { %> selected="selected" <% } %>>TX</option>
                            <option value = "UT" <% if (State.equals("UT")) { %> selected="selected" <% } %>>UT</option>
                            <option value = "VT" <% if (State.equals("VT")) { %> selected="selected" <% } %>>VT</option>
                            <option value = "VA" <% if (State.equals("VA")) { %> selected="selected" <% } %>>VA</option>
                            <option value = "WA" <% if (State.equals("WA")) { %> selected="selected" <% } %>>WA</option>
                            <option value = "WV" <% if (State.equals("WV")) { %> selected="selected" <% } %>>WV</option>
                            <option value = "WI" <% if (State.equals("WI")) { %> selected="selected" <% } %>>WI</option>
                            <option value = "WY" <% if (State.equals("WY")) { %> selected="selected" <% } %>>WY</option>
                            <option value = "OTHER"  <% if (State.equals("OTHER")) { %> selected="selected" <% } %>>OTHER</option>
                    </td></tr>



                <tr><td>Zip Code:</td> <td> <input type="text" name="Zip" value="<%=Zip%>"></td></tr>
                <tr><td>Telephone: </td> <td><input type="text" name="Tel" value="<%=Tel%>"></td></tr>
                <tr><td>Email Address:</td> <td> <input type="text" name="Email" value="<%=Email%>"></td></tr>
                <input type="checkbox" name="fruit" value ="apple" >苹果<br>
                <input type="checkbox" name="fruit1" value ="orange">桔子<br>
                <input type="checkbox" name="fruit2" value ="mango">芒果<br>
            </table>
            </br>
            <input type="submit" value="Submit" />  &nbsp;&nbsp; &nbsp;
        </form>
    </body>
</html>

