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
//get form parameters
String messageId = request.getParameter("messageId"); 
String messageTitle = request.getParameter("messageTitle"); 
String fromUserName = request.getParameter("messageFrom");

//get message details 
//message: SELECT * FROM messages WHERE messageId = messageId; 
String messageQuery = "SELECT * FROM messages WHERE messageId = " + messageId + ";";
ResultSet messages = query.executeQuery(messageQuery); 
messages.next(); //should be one

//get contents and shit 
int fromId = messages.getInt("userFromId"); 
int seen = messages.getInt("userToSeen"); 
Date date = new Date(messages.getTimestamp("datetimeCreated").getTime());
String content = messages.getString("content"); 

if(seen == 0){ //mark as viewed
	//UPDATE messages SET userToSeen = 1 WHERE messageId = messageId; 
	String updateSeen = "UPDATE messages SET userToSeen = 1 WHERE messageId = " + messageId + ";";
	query.executeUpdate(updateSeen); 
}
%>

<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336 Beats Cancer | View Message</title>
</head>
<body>

<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>

<div id="wrapper">
<h1><%= messageTitle %></h1>
<p class="message_content">Content: <%= content %></p>
<p class="message_from">From: <%= fromUserName %></p>
<p class="message_date">Date: <%= date.toString() %></p>
</div>
</body>
</html>