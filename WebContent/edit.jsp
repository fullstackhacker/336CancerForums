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
//get the form parameters
String table = request.getParameter("type"); 
String id = request.getParameter("id");
String value = request.getParameter("newMeat"); 

//only things that are additional in thread
boolean isThread = table.equals("thread");
String newContent = isThread ? request.getParameter("newContent") : "";
String postId = request.getParameter("postId") != null ? request.getParameter("postId") : ""; 
 
//column to edit
String column = isThread ? "title" : "content";

//post: UPDATE post SET content = value WHERE postId = id
//thread: UPDATE thread SET title = value WHERE threadId = id 
//thread: UPDATE post SET content = newContent WHERE postId = postId
String updateQuery = "UPDATE " + table + "SET " + column + " = " + value + " WHERE " + table +"id = " + id + ";";
try{ 
	query.executeUpdate(updateQuery); 
}
catch(Exception e){ 
	out.println(e.getMessage()); 
	out.println(updateQuery); 
	return; 
}

if(isThread){ 
	String firstPostUpdate = "UPDATE post SET content = " + newContent + " WHERE postId = " + postId + ";";
	try{ 
		query.executeUpdate(firstPostUpdate); 
	}
	catch(Exception e){ 
		out.println(e.getMessage()); 
		out.println(firstPostUpdate); 
		return;
	}
}
//idk where to send them at this point
out.println("Updated " + table);
Thread.sleep(3000); 
response.sendRedirect("index.jsp"); 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

</body>
</html>