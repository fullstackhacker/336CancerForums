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
%>

<%

String table = request.getParameter("type"); 
int id = Integer.parseInt(request.getParameter("id"));

//get current votes 
String getCurrVotes = "SELECT updownVotes FROM " + table + " WHERE " + table + "id = " + id + ";"; 
ResultSet voteSet = null;
try{
	voteSet = query.executeQuery(getCurrVotes); 
}
catch(Exception e){ 
	out.println(e.getMessage()); 
	out.println("   "); 
	out.println(getCurrVotes); 
	return; 
}
voteSet.next(); 
int currentVotes = voteSet.getInt("updownVotes"); 

//increment
currentVotes++; 

//update current votes
String updateCurrVotes = "UPDATE " + table + " SET updownVotes =" + currentVotes + " WHERE " + table + "id = " + id + ";";
try{ 
	query.executeUpdate(updateCurrVotes); 
}
catch(Exception e){ 
	out.println(updateCurrVotes); 
	return; 
}

if(table.equals("thread")) response.sendRedirect("index.jsp"); 
else response.sendRedirect("thread.jsp"); 
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