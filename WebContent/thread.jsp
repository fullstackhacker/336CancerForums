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

String orderBy = ""; 
if(request.getParameter("orderBy") != null){ 
	orderBy = " ORDER BY " + request.getParameter("orderBy");  
}


//see if user is a "special" user
boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
boolean atLeastMod = session.getAttribute("usertype") != null && ( ((String)session.getAttribute("usertype")).equals("mod") || ((String)session.getAttribute("usertype")).equals("admin") ); 
boolean isAdmin = session.getAttribute("usertype") != null && ((String)session.getAttribute("usertype")).equals("admin"); 
boolean isMod = session.getAttribute("usertype") != null &&  ((String)session.getAttribute("usertype")).equals("mod"); 

//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
Statement query2 = conn.createStatement();

%>

<%
//get the title of thread  --- varialbe threadittle is ireally the ID

String threadtitleQ = "SELECT * FROM thread WHERE thread.threadId = " + threadtitle + ";";
ResultSet threadTitle = query.executeQuery(threadtitleQ); 
threadTitle.next(); //there should only be one 
String threadName = threadTitle.getString("title"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= "336 Beats Cancer | " + threadName %></title>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
<div id="wrapper">
<h1><%= threadName %></h1>
<form id="ordering" name="ordering" method="post" action="thread.jsp" >
Order By:
<select name="orderBy">
	<option value="updownVotes DESC">Votes</option>
	<option value="user.userName ASC">Author</option>
	<option value="datetimeCreated">Time</option>
</select>
<input type="submit" value="Re-Order" />
</form>
<hr />
<%
//got the threadId
int threadId = Integer.parseInt(threadtitle);

//get the posts
String getPostString = "SELECT * FROM post, user WHERE post.threadId = " + threadId + " AND post.authorId = user.userId" + orderBy + ";";
ResultSet posts = null; 

try{
	posts = query.executeQuery(getPostString);
}
catch(Exception e){ 
	out.println(getPostString); 
	return;
}

while(posts.next()){ 
	//get attributes
	String content = posts.getString("content"); 
	int postId = posts.getInt("postId"); 
	Timestamp ts = posts.getTimestamp("datetimeCreated"); 
	Date date = new Date(ts.getTime()); 
	int votes = posts.getInt("updownVotes"); 
	String author = posts.getString("userName");
	
	//get authorsout.println("<div class=\"post\">");
	
	/* 
	String authorQ = "SELECT userName FROM user WHERE user.userId = " + posts.getInt("authorId"); 
	ResultSet hasAuthor = query2.executeQuery(authorQ); 
	hasAuthor.next(); 
	author = hasAuthor.getString("userName");
	*/
	
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
	
	if(atLeastMod){ //only a moderator or admin can delete or edit posts
		//edit button
		out.println("<form id=\"edit" + postId + "\" name=\"edit" + postId + "\" action=\"editform.jsp\" method=\"post\" >");
		out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"post\" />");
		out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + postId + "\" /> ");
		out.println("<input type=\"text\" class=\"hidden\" name=\"meat\" value=\"" + content + "\" />"); 
		out.println("<input type=\"submit\" value=\"Edit\" >"); 
		out.println("</form>"); 
		
		//delete button 
		out.println("<form id=\"delete" + threadId + "\" name=\"delete" + threadId + "\" action=\"delete.jsp\" method=\"post\" >");
		out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"post\" />");
		out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + postId + "\" /> ");
		out.println("<input type=\"text\" class=\"hidden\" name=\"meat\" value=\"" + content + "\" />"); 
		out.println("<input type=\"submit\" value=\"Delete\" >"); 
		out.println("</form>"); 
		
	}
	
	//view profile
	out.println("<form id=\"" + posts.getInt("authorId") + "\" name=\"viewprofile\" method=\"post\" action=\"userProfile.jsp\" >");
	out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + posts.getInt("authorId") + "\" />");
	out.println("<input type=\"submit\" value=\"View Profile\" />");
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

<%conn.close(); %>
</div>
</body>
</html>
