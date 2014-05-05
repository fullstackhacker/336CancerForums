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
//get the request parameters
String table = request.getParameter("type"); 
String id = request.getParameter("id"); 
String value = request.getParameter("meat"); 

//if thread we will need to get the first post 
boolean isThread = table.equals("thread"); 
String content = ""; 
int postId = -1; 
//get the first post
if(isThread){
	//out.println("isthread"); 
	String firstPostQuery = "SELECT * FROM post WHERE post.threadId = " + id + ";";
	//out.println(firstPostQuery); 
	ResultSet firstPost = query.executeQuery(firstPostQuery); 
	firstPost.next(); //first post will be the first one in this set
	content = firstPost.getString("content");
	postId = firstPost.getInt("postId"); 
	//out.println(content); 
	//out.println(postId); 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336CancerForums | Edit <%= table %></title>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>
<h1>Edit <%= table %></h1>
<form id="edit" name="edit" action="edit.jsp" method="post">
<input type="text" class="hidden" name="id" value="<%= id %>" />
<%
if(isThread){ //thread can change the first post or the thread title 
	out.println("<input type=\"text\" name=\"newMeat\" value=\"" + value + "\" />"); 
	out.println("<br/>"); 
	out.println("<textarea name=\"newContent\" form=\"edit\" rows=\"35\" cols=\"50\" />" + content); 
	out.println("</textarea>"); 
	out.println("<br/>"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"postId\" value=\"" + postId + "\" />");
	out.println("<input type=\"submit\" value=\"Edit Thread\"> "); 
}
else{ //post only thing to change is the content
	out.println("<textarea name=\"newMeat\" form=\"edit\" rows=\"35\" cols=\"50\" >" + value);	
	out.println("</textarea>");
	out.println("<br />"); 
	out.println("<input type=\"text\" name=\"type\" class=\"hidden\" value=\"post\" />");
	out.println("<input type=\"submit\" value=\"Edit Post\" />"); 
}

%>
</form>
<% conn.close();%>
</body>
</html>