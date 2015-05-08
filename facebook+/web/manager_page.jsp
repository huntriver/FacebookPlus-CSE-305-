<%-- 
    Document   : manager_profile
    Created on : 2015-4-26, 14:40:47
    Author     : yishuo wang
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <style>
        body {
	background-image: url(img/blossom.jpg);
	background-repeat: repeat;
}
.whiteTextBackground{
    background-color: white; 
}            
        </style>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String[] Months = {"january", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
            if (userid == null) {

                out.println("<script language=\"JavaScript\">alert(\"please login first！\");self.location='index.html';</script>"); //注意该方法的写法

            } else if (!type.equals("1")) {
                out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法 
            } else {
                String dburl = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/fhonda?user=fhonda&password=108180831";
                String driver = "com.mysql.jdbc.Driver";
                Class.forName(driver).newInstance(); //init driver
                Connection conn = DriverManager.getConnection(dburl);
                //     PreparedStatement ps = conn.prepareStatement("SELECT Id,Last_Name,First_Name FROM person");
                PreparedStatement ps = conn.prepareStatement("SELECT e.ssn,p.last_name,p.first_name,sum(s.number_of_units*a.unit_price) as revenue FROM employee e,person p,sale s, advertisement a WHERE a.id=s.advertisement and e.id=p.id and a.employee_id=e.id group by e.id order by revenue desc limit 1");

                ps.execute();
                ResultSet rs = ps.getResultSet();

                PreparedStatement ps1 = conn.prepareStatement("SELECT u.username,p.last_name,p.first_name,sum(s.number_of_units*a.unit_price) as revenue from user u,person p, sale s, advertisement a where a.id=s.advertisement and u.id=p.id and u.id=s.user group by u.id order by revenue desc limit 1");

                ps1.execute();
                ResultSet rs1 = ps1.getResultSet();

                PreparedStatement ps3 = conn.prepareStatement("DROP view IF EXISTS ads");
                ps3.execute();
                ps3 = conn.prepareStatement("create view ads as (select sale.advertisement,sum(sale.number_of_units) as sums from sale group by sale.advertisement) ");
                ps3.execute();
                ps3 = conn.prepareStatement("select * from advertisement,ads where advertisement.id=ads.advertisement order by ads.sums desc");
                ps3.execute();
                ResultSet rs3 = ps3.getResultSet();
                
                


        %>
    </head>
    <body>
        <h1>Manager Page</h1>
        <table border="1" style="height:500px">
            <tr><td><a href="employee_list.jsp">Show all Employees</a> </td> </td></tr>
            <tr><td><a href="user_list.jsp">Show all Users</a> </td></tr>
            <tr><td><a href="add_delete.jsp">add_delete</a> </td></tr>
            <tr><td> sale report 
                    <form action="salereport.jsp" method="post">
                        <select name = "month">
                            <option value = "">Choose a month</option>
                            <%                                for (int i = 1; i <= 12; i++) {%>
                            <option value = "<%=i%>" ><%=Months[i - 1]%></option> 
                            <%}%>

                        </select>
                        <input type="submit" value="check">
                    </form>
                </td></tr>
            <tr><td><a href="showallads.jsp">Show all Advertisements</a> </td></tr>
            <tr><td>Show Transaction Lists
                    <form action="showtranscation.jsp" method="post">
                        Search by:<br>
                        <table border="0"> 
                            <tr><td>   Item_name </td><td><input type="text" name="item_name">  </td></tr>
                            <tr><td>    username </td><td><input type="text" name="username">    </td></tr>
                            <tr><td>     Last Name </td><td><input type="text" name="lname">    </td></tr>           
                            <tr><td>    First Name </td><td><input type="text" name="fname">     </td></tr>           
                            <tr><td colspan="2" align=right>    <input type="submit" value="Search"> </td></tr>
                        </table>
                    </form>
                </td></tr>
            <tr><td>Show Revenue Lists
                    <form action="showrevenue.jsp" method="post">
                        Search by:<br>
                        <table border="0"> 
                            <tr><td>   Item_name </td><td><input type="text" name="item_name">  </td></tr>
                            <tr><td>    username </td><td><input type="text" name="username">    </td></tr>
                            <tr><td>   Item_type </td><td><input type="text" name="item_type">    </td></tr>           

                            <tr><td colspan="2" align=right>    <input type="submit" value="Search"> </td></tr>
                        </table>
                    </form>
                </td></tr>
            <tr><td>most total revenue by employee
                    <%if (rs.next()) {%>
                    <table border="1"> 
                        <tr><td>SSN</td><td>Last Name</td><td>First Name</td><td> Revenue</td></tr>
                        <tr><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td></tr>


                    </table>
                    <%}%>
                </td></tr>
            <tr><td>most total revenue by customer
                    <%if (rs1.next()) {%>
                    <table border="1"> 
                        <tr><td>username</td><td>Last Name</td><td>First Name</td><td> Revenue</td></tr>
                        <tr><td><%=rs1.getString(1)%></td><td><%=rs1.getString(2)%></td><td><%=rs1.getString(3)%></td><td><%=rs1.getString(4)%></td></tr>


                    </table>
                    <%}%>
                </td></tr>
            <tr><td>most active items
                    <table border="1">    
                        <tr>
                            <td>Item_Name</td>
                            <td>Company</td>
                            <td>Type</td>
                            <td>Content</td>
                            <td>Price</td>
                            <td>Available_Units</td>
                            <td>Sold </td>
                        </tr>
                        <%  while (rs3.next()) {
                        %> <tr>

                            <td><%=rs3.getString("item_name")%></td>
                            <td><%=rs3.getString("company")%></td>
                            <td><%=rs3.getString("type")%></td>
                            <td><%=rs3.getString("content")%></td>
                            <td><%=rs3.getString("unit_price")%></td>
                            <td><%=rs3.getString("available_units")%></td>
                            <td><%=rs3.getString("sums")%></td>
                        </tr>


                        <%
                            }

                        %>
                    </table>
                    <br>
                    
                </td></tr>
            <tr><td>Produce a list of all customers who have purchased a particular item
                    <form action="list_of_users_for_an_item.jsp" method="post">
                        Search by:<br>
                        <table border="0"> 
                            <tr><td>   Item_name </td><td><input type="text" name="item_name">  </td></tr>       
                            <tr><td colspan="2" align=right>    <input type="submit" value="Search"> </td></tr>
                        </table>
                    </form>
                </td></tr>
            <tr><td>Produce a list of all items for a given company
                    <form action="list_of_items_for_a_company.jsp" method="post">
                        Search by:<br>
                        <table border="0"> 
                            <tr><td>Company</td><td><input type="text" name="company">  </td></tr>       
                            <tr><td colspan="2" align=right>    <input type="submit" value="Search"> </td></tr>
                        </table>
                    </form>
                </td></tr>
            
        </table>
        <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
    </body>
    <%
            ps.close();
            ps1.close();
            conn.close();

        }%>
</html>
