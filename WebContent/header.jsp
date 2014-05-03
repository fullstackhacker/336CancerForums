<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 



<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	//connecting to the database
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db	
	
	//user attributes
	Integer userId = (Integer)session.getAttribute("userId"); 
	String username = (String)session.getAttribute("username"); 
	String firstname = (String)session.getAttribute("firstname"); 
	String lastname = (String)session.getAttribute("lastname"); 
	String email = (String)session.getAttribute("email");
	Integer votes = (Integer)session.getAttribute("votes");
	
	//see if user is a "special" user
	boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
	boolean atLeastMod = session.getAttribute("usertype") != null && ( ((String)session.getAttribute("usertype")).equals("mod") || ((String)session.getAttribute("usertype")).equals("admin") ); 
	boolean isAdmin = session.getAttribute("usertype") != null && ((String)session.getAttribute("usertype")).equals("admin"); 
	boolean isMod = session.getAttribute("usertype") != null &&  ((String)session.getAttribute("usertype")).equals("mod");

%>

<% //getting ad type(based on topic id)
/*
String adTypeQuery = "select topicId from ((SELECT topic.topicId, count(post.postId) as postCount from post, thread, topic WHERE post.threadId = thread.threadId and thread.topicId = topic.topicId and post.authorId = " + userId.toString() +" GROUP BY topic.topicId) as T) HAVING postCount = MAX(postCount);";
ResultSet adTypers = query.executeQuery(adTypeQuery);
int adTypeNum = adTypers.getInt("topicId");
String adCountQuery = "SELECT count(*) as count from advertisement WHERE approved = 1 and adType = " + Integer.toString(adTypeNum);
ResultSet adCountrs = query.executeQuery(adCountQuery);
int adCountNum = adCountrs.getInt("count");
String adQuery = "SELECT imageLink from advertisement WHERE approved = 1 and adType = " + Integer.toString(adTypeNum);
ResultSet adRs = query.executeQuery(adQuery);
Random rV = new Random();
int adSelector = 1;
if(adCountNum > 1) {
	adSelector = (Math.abs(rV.nextInt())%adCountNum)+1;
}
adRs.absolute(adSelector);
String adLink = adRs.getString("imageLink");
*/

%>

<% 
//check if the user has an unread messages
//SELECT * FROM messages WHERE userToId = userId AND userToSeen = 0;
String fuckMessages = "SELECT * FROM messages WHERE userToId = " + userId + " AND userToSeen = 0;";
ResultSet getPaper = query.executeQuery(fuckMessages); 
String messageButtonString = ""; 
if(!getPaper.next()) messageButtonString = "Messages";
else{ //count new messages
	String countMessages = "SELECT COUNT(*) AS newmessages FROM messages WHERE userToId = " + userId + " AND userToSeen = 0;"; 
	ResultSet faggot = query.executeQuery(countMessages);
	faggot.next(); 
	messageButtonString = "Messages (" + faggot.getInt("newmessages") + ")";
}

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style rel="stylesheet" type="text/css" href="global.css"></style>
<style rel="stylesheet" type="text/css" href="profile.css"></style>
</head>
<body>

<div id="userbox">
	Welcome back, <a href="profile.jsp"><%= username %></a>
	<%if(isAdmin)out.println("<button type=\"button\" onclick=\"window.location='admin.jsp'\">Admin Console</button>"); %>
	<button type="button" onclick="window.location='message.jsp'">Messages</button>
	<button type="button" onclick="window.location='logout.jsp'">Log Out</button>
</div>
<a href="index.jsp"><img src=images/CancerBanner.png></a>
<!-- <img src=<%=adLink %>> -->
</body>
</html>
