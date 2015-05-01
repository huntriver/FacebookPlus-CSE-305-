<%-- 
    Document   : newAccount
    Created on : 2015-4-30, 23:40:08
    Author     : yishuo wang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account page</title>
    </head>
    <body>
        <form action="creditAccount" method="post">
            <table>
                <tr><td>Credit Card Number </td> <td><input type="text" name="Card_Num"/></td></tr>
                <tr><td>Name On Your Card:</td> <td> <input type="text" name="Full_Name" /></td></tr>
            </table>
            </br>
            <input type="submit" value="Create" />       &nbsp;&nbsp; &nbsp;   
            <input type="reset" value="Reset" /></br>

        </form>
        <button type="button" onclick="window.location.href = 'account.jsp'">back</button>
    </body>
</html>
