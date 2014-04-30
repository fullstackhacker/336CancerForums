<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
String threadtitle = request.getParameter("threadtitle"); 

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
<title><%= "Cancer Forums | " + threadtitle %></title>
</head>
<body>
<h1><%= threadtitle %></h1>
<% 

//get the thread ID
String getThreadId = "SELECT * FROM thread WHERE thread.threadtitle = \"" + threadtitle + "\";"; 
ResultSet threadSet = query.executeQuery(getThreadId);
int threadId = -1; 
if(threadSet.next()) threadId = threadSet.getInt("threadId"); 
else{ 
	out.println("Spontaneous Error");
	response.sendRedirect("index.jsp"); 
} 

//get all the posts in that thread
String getPosts = "SELECT * FROM post WHERE post.threadID = " + threadId + ";";
ResultSet postSet = query.executeQuery(getPosts); 
while(postSet.next()){ 
	//get attributes 
	String content = postSet.getString("content"); 
	int postId = postSet.getInt("postId"); 
	Timestamp ts = postSet.getTimestamp("datetimeCreated"); 
	Date date = new Date(ts.getTime());
	int votes = postSet.getInt("updownVotes"); 
	
	//get the author
	String authorQ = "SELECT userName FROM user WHERE user.userId = " + postSet.getInt("authorId"); 
	ResultSet authorIdSet = query.executeQuery(authorQ);
	String author = ""; 
	if(authorIdSet.next()) author = authorIdSet.getString("userName");   
	
	//display the post	
	out.println("<div class=\"post\">"); 
	out.println("<p class = \"content\">");
	out.println(content); 
	out.println("</p>"); 
	out.println("<p class=\"author\">" + author + "</p>"); 
	out.println("<p class=\"date\">" + date.toString() + "</p>");
	out.println("<p class=\"votes\">" + votes + "</p>"); 
	out.println("</div>"); 
}
%>

<!-- post a reply -->
Reply to thread: 
<form name="createpost" action="createpost.jsp" method="post"> 
<textarea name="cpcontent" form="createpost" row="30" cols="20"> 
Post a reply
</textarea>
</form>

</body>
</html>