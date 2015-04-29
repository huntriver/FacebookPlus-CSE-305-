<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body> 	 
<h1>Employee</h1>
<p>View As</p>
<button>
User
</button>
&nbsp;
<button>
Employee
</button>
&nbsp; <br />
<button class="button" onClick="window.open('employeeInfo.html');"><span class="icon">View Employee Data</span></button>


<br>
<br>

<script type="text/JavaScript">
<!-- Begin
function popjack()
 {
window.open('createAd.html','popjack','toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,copyhistory=no,scrollbars=yes,width=480,height=320');
 }
//-->
</script>

<a href="JavaScript: popjack()" onMouseOver="window.status='Status Bar Message';
   return true" onMouseOut="window.status=''; return true">
Create an advertisement</a>.


<br>

</p>
<form>
  Delete an advertisement(name):<br>
<input type="number" name="adId">
<input type="submit" value="Submit" />
</form>
<br>
<button>
Record a transaction
</button>

<br /><br />


<button>
Produce customer mailing lists 
</button>


<form id="form1" name="form1" method="post" action="">
  <label for="userId">Produce a list of item suggestions for a given customer (based on that customer's past transactions)</label>
  <input type="text" name="userId" id="userId" />
</form>
<br />
<form id="form2" name="form2" method="post" action="">
Add information for a customer (by Id)
<input type="text" name="userId" id="userId" />  <input type="submit" value="Submit">
</form>

<form id="form2" name="form2" method="post" action="">
Edit information for a customer (by Id)
<input type="text" name="userId" id="userId" />  <input type="submit" value="Submit">
</form>
<form id="form2" name="form2" method="post" action="">
Delete information for a customer (by Id)
<input type="text" name="userId" id="userId" />   <input type="submit" value="Submit">
</form> 

</body> 	
</html>
