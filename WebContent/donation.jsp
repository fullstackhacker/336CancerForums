<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Donation to company</title>
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
<div id="wrapper">
<%
if(session.getAttribute("userId")==null){ //user is not logged in 
	response.sendRedirect("loginform.jsp"); 
}
 
//user is logged in 

//user attributes
Integer userId = (Integer)session.getAttribute("userId"); 
String username = (String)session.getAttribute("username"); 
String firstname = (String)session.getAttribute("firstname"); 
String lastname = (String)session.getAttribute("lastname"); 
String email = (String)session.getAttribute("email");
boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
Integer votes = (Integer)session.getAttribute("votes");

%>

<%
int customerId = 0;
String address = "";
String creditCardNumber = "";
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db;
ResultSet rs= null;
try {
	Statement query = conn.createStatement(); //create the thing that will query the db
	String selectStatement = "SELECT address,creditCardNumber FROM customer WHERE userId = " + userId;
	rs = query.executeQuery(selectStatement);
	if(!rs.next()){
	}
	else {
		address = rs.getString("address");
		creditCardNumber = rs.getString("creditCardNumber");
		session.setAttribute("customerId",customerId);
	}
}
catch(Exception e) {
    System.out.print(e);
    e.printStackTrace();
	out.println("<label> Error "+ e.toString() + "</label><br/>");
}
finally {
	conn.close();
}
%>

 <div id="donation_form">
 <form name="donation" method="post" action="donationInsert.jsp">
   <fieldset>
     Credit Card Number: <input type="text" name="creditCardNum" id="creditCardNum" size="30" value="<%=creditCardNumber %>" class="text-input" /> 
     <br/>
     Address: <input type="text" name="address" id="address" size="30" value="<%=address %>" class="text-input" />
     <br/>
     Donation Amount: <input type="text" name="donationAmt" id=""donationAmt"" size="30" placeholder="Amount" class="text-input" />
     <br/>
     Company Id: <input type="text" name="companyId" id=""companyId"" size="30" placeholder="Company Id" class="text-input" />
     <br/>
   	<br />
     <input type="submit" name="donate" class="button" id="donate_btn" value="Donate" />
   </fieldset>
 </form>
</div>
</div>
</body>
</html>