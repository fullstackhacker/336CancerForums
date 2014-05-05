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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
//get details from the request
String content = request.getParameter("cthread_content");
int threadId = Integer.parseInt(request.getParameter("threadId")); 
Integer authorId = (Integer)session.getAttribute("userId"); 

//timestamp
Timestamp ts = new Timestamp(System.currentTimeMillis()); 

//insert string postId, threadId, content, updownvotes, authorId
String makepost = "INSERT INTO post (postId, threadId, content, updownVotes, authorID) VALUES(0, " + threadId + ", \"" + content + "\", 0, " + authorId + ");";


try{
	query.executeUpdate(makepost); 
}
catch(Exception e){ 
	//couldn't update 
	out.println(makepost);
	out.println("something is wrong with you sql query or something"); 
	return; 
}

conn.close(); 

response.sendRedirect("thread.jsp"); 
%>
</body>
</html>