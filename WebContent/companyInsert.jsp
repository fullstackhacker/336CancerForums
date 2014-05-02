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
<title>Company Page</title>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
</head>
<body>
<div>
<%
String companyName;
String companyAddress;
companyName = request.getParameter("companyName");
companyAddress = request.getParameter("companyAddress");
try {
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db
	String insertStatement = "INSERT INTO company (name,address,approved) VALUES("+companyName+","+companyAddress+",1)";
	int i = query.executeUpdate(insertStatement);
	out.println("<label Company data successfully inserted!</label");
	out.println("<label Company name: " + companyName + "</label");
	out.println("<label Company address: " + companyAddress + "</label");
}
catch(Exception e) {
    System.out.print(e);
    e.printStackTrace();
	out.println("<label Error </label");
}
%>
</div>
</body>
</html>