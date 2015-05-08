<%-- 
    Document   : user_profile
    Created on : Apr 23, 2015, 4:18:08 PM
    Author     : yishuo wang
--%>
<%@page import="java.util.ArrayList"%>
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
        <style>
            body {
                background-image: url(img/lanyanlei.jpg);
                background-repeat: repeat;
            }
            .whiteTextBackground{
                background-color: white; 
            }

        </style>
        <title>User Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%
            String userid = (String) session.getAttribute("userid");
            String lname = null;
            String fname = null;
            String birth = null;
            String Address = null;
            String City = null;
            String State = null;
            String Zip = null;
            String Tel = null;
            String Email = null;
            String sex = null;
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
                PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM user_preferences Where id=?");
                ps.setString(1, userid);
                ps_type.setString(1, userid);
                ps1.setString(1, userid);
                ps.execute();
                ps_type.execute();
                ps1.execute();
                ResultSet rs = ps.getResultSet();
                ResultSet rs_type = ps_type.getResultSet();
                ResultSet rs1 = ps1.getResultSet();
                rs.next();
                rs_type.next();

                lname = rs.getString("Last_Name");
                fname = rs.getString("First_Name");
                birth = rs.getString("DOB");
                sex = rs.getString("SEX");
                Address = rs.getString("Address");
                City = rs.getString("City");

                State = rs.getString("State");
                Zip = rs.getString("Zip_Code");
                Tel = rs.getString("Telephone");
                Email = rs.getString("Email_Address");
                String rating = rs_type.getString("rating");
                type = rs_type.getString("type");
                ArrayList<String> pref = new ArrayList<String>();
                for (int i = 0; rs1.next(); i++) {
                    pref.add(rs1.getString("preference"));
                }
                if (lname == null) {
                    lname = "";
                }
                if (fname == null) {
                    fname = "";
                }
                if (sex == null) {
                    sex = "";
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
                if (birth == null) {
                    birth = "";
                }

                //    String date = rs.getString("date");
                //    String authorid = rs.getString("author");
%>
    </head>
    <body>
        <h1 style="color:white">Your Profile Information</h1>

        <form action="profile" method="post">
            <table border="0">
                <tr><td style="background-color: white">Last Name: </td> <td><input type="text" name="lname" value="<%=lname%>"></td></tr>
                <tr><td style="background-color: white">First Name:</td> <td> <input type="text" name="fname" value="<%=fname%>"></td></tr>
                <tr><td style="background-color: white">Birth:</td> <td> <input type="text" name="birth" value="<%=birth%>"></td><td>Format:mmddyyyy</td></tr>
                <tr><td style="background-color: white">Gender:</td> <td> 
                        <select name = "Sex">
                            <option value = "">Choose</option>
                            <option value = "Male" <% if (sex.equals("Male")) { %> selected="selected" <% } %>>Male</option> 
                            <option value = "Female" <% if (sex.equals("Female")) { %> selected="selected" <% }%>>Female</option> 
                    </td></tr>
                <tr><td style="background-color: white">Address: </td> <td><input type="text" name="Address" value="<%=Address%>"></td></tr>
                <tr><td style="background-color: white">City:</td> <td> <input type="text" name="City" value="<%=City%>"></td></tr>
                <tr><td style="background-color: white">State: </td> <td>
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
                            <option value = "OTHER"  <% if (State.equals("OTHER")) { %> selected="selected" <% }%>>OTHER</option>
                    </td></tr>



                <tr><td style="background-color: white">Zip Code:</td> <td> <input type="text" name="Zip" value="<%=Zip%>"></td></tr>
                <tr><td style="background-color: white">Telephone: </td> <td><input type="text" name="Tel" value="<%=Tel%>"></td></tr>
                <tr><td style="background-color: white">Email Address:</td> <td> <input type="text" name="Email" value="<%=Email%>"></td></tr>
                <tr> <th colspan="2">

                <table style="background-color: white">
                    <caption style="background-color: white" >Preference</caption>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("car")) {%>checked="checked" <%}%> value="car"></td><td>Car</td></tr>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("clothing")) {%>checked="checked" <%}%> value="clothing"></td><td>clothing</td></tr>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("food")) {%>checked="checked" <%}%> value="food"></td><td>food</td> </tr>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("game")) {%>checked="checked" <%}%> value="game"></td><td>game </td></tr>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("life insurance")) {%>checked="checked" <%}%> value="life insurance"></td><td>life insurance </td></tr>
                    <tr><td><input   type="checkbox" name="pre" <%if (pref.contains("toys")) {%>checked="checked" <%}%> value="toys"></td><td>toys </td></tr>
                </table>
                </th>
                </tr>
                <tr><td style="background-color: white">Rating:</td><td><input type="text" name="rating" <%if (type.equals("3")) {%>disabled="disabled"<%}%> value="<%=rating%>">(added by 1 for one transaction MAX 10)</td></tr>
                        <%if (!type.equals("3")) {
                                PreparedStatement ps3;
                                if (type.equals("2")) {
                                    ps3 = conn.prepareStatement("SELECT * FROM employee Where id=?");
                                } else {
                                    ps3 = conn.prepareStatement("SELECT * FROM manager Where id=?");
                                }
                                ps3.setString(1, userid);
                                ps3.execute();
                                ResultSet rs3 = ps3.getResultSet();
                                rs3.next();
                        %>
                <tr><td>SSN</td><td><input type="text" name="ssn" value="<%=rs3.getString("ssn") == null ? "" : rs3.getString("ssn")%>"></td></tr>
                <tr><td>Start Date</td><td><input type="text" name="sdate" disabled="dsiabled" value="<%=rs3.getString("start_date")%>"></td></tr>
                <tr><td>Hourly Rate</td><td><input type="text" name="hrate" <%if (!type.equals("1")) {%>disabled="disabled"<%}%> value="<%=rs3.getString("hourly_rate") == null ? "" : rs3.getString("hourly_rate")%>"></td></tr>
                        <%ps3.close();
                    }%>
                <input type="hidden" value="0" name="q"> 
            </table>
            </br>
            <input type="submit" value="Submit" /> 
        </form>
        <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
    </body>
    <%
            ps.close();
            conn.close();

        }%>
</html>

