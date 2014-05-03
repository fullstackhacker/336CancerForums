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
//get the form values
String table = request.getParameter("type");
String id = request.getParameter("id"); 
String value = request.getParameter("meat"); 

//if its a thread we have to delete all the posts pertaining to it first
if(table.equals("thread")){ //if thread, have to delete all posts associated with that thread 
	//posts in thread: DELETE FROM post WHERE post.threadId = id; 
	String deleteAllPostsQuery = "DELETE FROM post WHERE post.threadId = " + id + ";";
	try{ 
		query.executeUpdate(deleteAllPostsQuery); 
	}
	catch(Exception e){ 
		out.println(deleteAllPostsQuery); 
		return; 
	}
}

//post: DELETE FROM post WHERE postId = id;
//thread: DELETE FROM thread WHERE threadId = id; 
String deleteQuery = "DELETE FROM " + table + " WHERE " + table + "Id = " + id + ";";
try{ 
	query.executeUpdate(deleteQuery); 
}
catch(Exception e){ 
	out.println(deleteQuery); 
	return; 
}


if(request.getParameter("topic").equals("thread")) response.sendRedirect("index.jsp"); 
response.sendRedirect("thread.jsp");
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