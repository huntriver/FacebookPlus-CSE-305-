<%-- 
    Document   : manager_profile
    Created on : 2015-4-26, 14:40:47
    Author     : yishuo wang
--%>

<%-- 
    Document   : manager_pageFumi
    Created on : May 6, 2015, 12:15:47 PM
    Author     : Fumi Honda
--%>

<!------------
Author: Fumi Honda
-->
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<<<<<<< HEAD
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String[] Months = {"january", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            String userid = (String) session.getAttribute("userid");
            String type = (String) session.getAttribute("type");
=======

<head>
<!----
Old part from Fumi using DreamWeaver
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
--->

<!---This part is taken from Yishuo Wang  Start -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String userid = (String) session.getAttribute("userid");
>>>>>>> 138384b4a1dce83358d8ef2af4f9ac10e0945e86
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
                PreparedStatement ps = conn.prepareStatement("SELECT e.ssn,p.last_name,p.first_name,sum(s.number_of_units*a.unit_price) as revenue FROM employee e,person p,sale s, advertisement a WHERE a.id=s.advertisement and e.id=p.id group by e.id order by revenue desc limit 1");

                ps.execute();
                ResultSet rs = ps.getResultSet();
<<<<<<< HEAD

                PreparedStatement ps1 = conn.prepareStatement("SELECT u.username,p.last_name,p.first_name,sum(s.number_of_units*a.unit_price) as revenue from user u,person p, sale s, advertisement a where a.id=s.advertisement and u.id=p.id group by u.id order by revenue desc limit 1");

                ps1.execute();
                ResultSet rs1 = ps1.getResultSet();


        %>
    </head>
    <body>
        <h1>Manager Page</h1>
        <table border="1" style="height:500px">
            <tr><td><a href="employee_list.jsp">Show all Employees</a> </td></tr>
            <tr><td> sale report 
                    <form action="salereport.jsp" method="post">
                        <select name = "month">
                            <option value = "">Choose a month</option>
                            <%                                for (int i = 1; i <= 12; i++) {%>
                            <option value = "<%=i%>" ><%=Months[i - 1]%></option> 
                            <%}%>

                        </select>
                        <input type="submit" value="ckeck">
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
        </table>
        <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
    </body>
    <%
            ps.close();
            ps1.close();
            conn.close();

        }%>
=======
                rs.next();

                if (!rs.getString("type").equals("1")) {
                    out.println("<script language=\"JavaScript\">alert(\"access deny！\");self.location='user_index.jsp';</script>"); //注意该方法的写法
                    ps.close();
                    conn.close();
                    return;
                }
                ps.close();
                conn.close();
 
            }
        %>
        
<!---End This part is taken from Yishuo Wang -->

<title>Manager</title>
</head>

<body>
<h1>Manager</h1>
 <a href="#" class="f90-logout-button"><button>Logout</button></a>
<p>&nbsp;</p>
<table style="width: 100%">
<tr>
  <td><form>
    <table style="width: 100%">
    <tr>
      <td style="width: 394px; height: 33px;"><table style="width: 100%">
        <tr>
          <td style="width: 394px"><strong>Employee Administrative</strong></td>
          <td><strong>Sales</strong></td>
        </tr>
        <tr>
          <td style="width: 394px; height: 33px;"> <p>Add Employee by ID
  <input type="number" name="employeeID" maxlength="6" />
            <input type="submit" />
          </p>
            <p>&nbsp; </p></td>
          <td >
          Sales Report <form action="sale_report.jsp" method="post">
                        <select name = "salereport">
                            <option value = "">Choose a month</option>
                            <%
                    for (int i = 1; i <= 12; i++) {%>
                            <option value = "<%=i%>" name="month"><%=i%></option> 
                            <%}%>

                        </select>
                        <input type="submit" value="check">
                    </form>
          </td>
        </tr>
<tr>
  <td>&nbsp;</td>
</tr>
        <tr>
          <td style="width: 394px; height: 33px;">Edit Employee Info by ID
            <input type="number" name="employeeID" maxlength="6" />
            <input type="submit" /></td>
        </tr>
        <tr>
          <td style="width: 394px; height: 33px;"><p>Remove Employee by ID
            <input type="number" name="employeeID" maxlength="6" />
            <input type="submit" />
          </p>
            <p><br />
            </p>
            <a href="employee_list.jsp">View All Employees</a></td>
        </tr>
        <tr>
          <td style="width: 394px"><strong>By Item..</strong></td>
          <td> Summary listing of revenue generated by a particular item(Name)
            <input type="text" name="itemName" maxlength="15" /></td>
        </tr>
        <tr>
          <td> All customers who have purchased a particular item (Name)
            <input type="text" name="itemName" maxlength="15" />
            <input type="submit" />
            <script>
function myFunction1() {	
    alert("Result is");
}
        </script></td>
          <td> Summary listing of revenue generated by a particular item type (Name)
            <input type="text" name="itemName" maxlength="15" /></td>
        </tr>
        <tr>
          <td style="width: 394px; height: 33px;"><button class="button" onclick="window.open('allAdItemsOnSite.html');"><span class="icon">All items being advertised on the site</span></button></td>
          <td style="height: 33px"><strong>By Customer....</strong></td>
        </tr>
        <tr>
          <td style="width: 394px"><button class="button" onclick="window.open('listTransactionsByItemName.html');"><span class="icon">List of Transactions by Item Name</span></button>
            <button class="button" onclick="window.open('listTransactionsByCustomerName.html');"><span class="icon">List of Transactions by Customer Name</span></button></td>
          <td> Summary listing of revenue generated by a particular customer(Name)
            <input type="text" name="customerName" maxlength="15" /></td>
        </tr>
        <tr>
          <td style="width: 394px"><button class="button" onclick="window.open('listMostActiveItems.html');"><span class="icon">Most active items</span></button></td>
          <td></td>
        </tr>
        <tr>
          <td style="width: 394px"> All items for a given company :
            <input type="text" name="firstname" maxlength="15" />
            <input type="submit" /></td>
          <td><button onclick="myFunction()">Customer who generated the most revenue</button>
            <script>
function myFunction() {
    alert("Customer name & CustomerId");
}
        </script></td>
        </tr>
      </table>
<br />
  
  
  <button type="button" onclick="window.location.href = 'user_index.jsp'">back</button>
</body>

>>>>>>> 138384b4a1dce83358d8ef2af4f9ac10e0945e86
</html>

