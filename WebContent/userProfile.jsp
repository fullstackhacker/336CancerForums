<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
Statement query2 = conn.createStatement(); 
%>

<%
//get userId from where we will get all the other info
int userId = Integer.parseInt(request.getParameter("id"));

//user details that we need to fill in!!:
String firstName; 
String lastName; 
String email; 
String userName; 

String getInfo = "SELECT * FROM user WHERE userId = " + userId + ";";
ResultSet userInfo = null;
try{ 
	userInfo = query.executeQuery(getInfo); 
}
catch(Exception e){
	out.println(getInfo);
	return; 
}
 userInfo.next(); //should only be one
 
//got user info at this point
firstName = userInfo.getString("firstName");
lastName = userInfo.getString("lastName"); 
email = userInfo.getString("email"); 
userName = userInfo.getString("userName");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336CancerForums | <%= userName %></title>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
<div id="wrapper">
<!-- display user profile --> 
<p> User Name: <%= userName %> </p>
<p> First Name: <%= firstName %> </p>
<p> Last Name: <%= lastName %> </p>
<p> Email: <%= email %> </p>

<% conn.close(); %>
</div>
</body>
</html>