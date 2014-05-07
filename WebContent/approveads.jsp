<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>

<%
//get parameters
String[] adsIdApproved = request.getParameterValues("approvedad"); //all the ads that were approved

for(int x = 0; x < adsIdApproved.length; x++){ // go through the adIds that were approved
	//update the ads to say that they're approved.1 means approved, 0 means unapproved
	String approveAdUpdate = "UPDATE advertisement SET approved=1 WHERE adId = " + adsIdApproved[x] + ";";
	
	try{
		query.executeUpdate(approveAdUpdate); //executes the update
	}
	catch(Exception e){ 
		out.println(e.getMessage());  //outputs the error 
		out.println(approveAdUpdate); //prints out the query
		return; //stop the code from executing furthur so we know we messed up
	}
}

//updated all the ads here

response.sendRedirect("moderator.jsp"); //redirect back to moderator
 //so we dont write anymore headers (bad stuff happens)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>