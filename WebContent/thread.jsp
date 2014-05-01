<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
String threadtitle = "";
if(request.getParameter("title") != null) {
	threadtitle = request.getParameter("title"); // this is really infact the threadId!!
	session.setAttribute("currentThread", threadtitle); 
}
else{ 
	threadtitle = (String)session.getAttribute("currentThread");
}
 


//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
Statement query2 = conn.createStatement();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= "Cancer Forums | " + threadtitle %></title>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>
<h1><%= threadtitle %></h1>


<%
//got the threadId
int threadId = Integer.parseInt(threadtitle);

//get the posts
String getPostString = "SELECT * FROM post WHERE post.threadId = " + threadId + ";";
ResultSet posts = query.executeQuery(getPostString);

while(posts.next()){ 
	//get attributes
	String content = posts.getString("content"); 
	int postId = posts.getInt("postId"); 
	Timestamp ts = posts.getTimestamp("datetimeCreated"); 
	Date date = new Date(ts.getTime()); 
	int votes = posts.getInt("updownVotes"); 
	
	//get authorsout.println("<div class=\"post\">");
	String author = ""; 
	String authorQ = "SELECT userName FROM user WHERE user.userId = " + posts.getInt("authorId"); 
	ResultSet hasAuthor = query2.executeQuery(authorQ); 
	hasAuthor.next(); 
	author = hasAuthor.getString("userName");
	
	//display post
	out.println("<div class=\"post\">");
	out.println("<p class=\"content\">" + content + "</p>"); 
	out.println("<p class=\"author\"> Author: " + author + "</p>"); 
	out.println("<p class=\"date\"> Posted Date: " + date.toString() + "</p>");
	out.println("<p class=\"votes\"> Votes:" + votes + "</p>");
	
	//upvoting form 
	out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"upvote.jsp\" method=\"post\" >"); 
	out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
	out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>"); 
	
	//down voting form 
	out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"downvote.jsp\" method=\"post\" >"); 
	out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
	out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	
	out.println("</div>");
	out.println("<hr/>"); //something to separate the lines temporarily
}

%>
<h2>Reply to thread:</h2>
<form id="createpost" name="createpost" method="post" action="createpost.jsp">
<textarea form="createpost" name="cthread_content" placeholder="Reply..." cols='50' row="20"></textarea>
<br/>
<input class="hidden" name="threadId" value="<%= threadId %>" />
<br/>
<input type="submit" value="Add Post" />
</form> 




<button type="button" onclick="window.location.href='index.jsp'">Back</button>
</body>
</html>