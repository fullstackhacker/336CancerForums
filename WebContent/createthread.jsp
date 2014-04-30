<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>

<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db

//get the thread info 
String threadtitle = (String)request.getParameter("threadtitle");
String firstpost = (String)request.getParameter("cthread_content"); 
String topic = (String)request.getParameter("topic"); 

//getTopicId
String getTopicId = "SELECT * FROM topic WHERE topic.name = \"" + topic + "\""; 
ResultSet topicIdSet = query.executeQuery(getTopicId); 
int topicId = -1; 
if(topicIdSet.next()) topicId = topicIdSet.getInt("topicId");
else{ 
	out.println("Invalid Topic choice"); 
	response.sendRedirect("index.jsp"); 
}

//get current time
Timestamp ts = new Timestamp(System.currentTimeMillis()); 

//add to thread 
//thread; threadId, topicId, title, datetimeCreated, updownVotes,  authorId
String addThreadQ = "INSERT INTO thread VALUES (0, + " + topicId + ", \"" + threadtitle + "\"," + ts + ", 0, " + (Integer)session.getAttribute("userId") + ");";

try{ 
	query.executeUpdate(addThreadQ); 
}
catch(Exception e){ //couldn't add the thread cause something was wrong with your sql statement 
	out.println("UNABLE TO CREATE THREAD"); 
	Thread.sleep(2000); 
	response.sendRedirect("index.jsp");
}

//add post to the thread

//have to get the threadId now
String getThreadId = "SELECT * FROM thread WHERE thread.title = \"" + threadtitle + "\";"; 
ResultSet threadIdSet = query.executeQuery(getThreadId); 
int threadId = -1;
if(threadIdSet.next()) threadId = threadIdSet.getInt("threadId");
else{ 
	out.println("something went wrong --> REDIRECTING");
	Thread.sleep(2000);
	response.sendRedirect("index.jsp"); 
}
//post: postid, threadId, content, datetimeCreated, updownVotes, authorId
String addPost = "INSERT INTO thread VALUES (0, + " + threadId + ", \"" + firstpost + "\"," + ts + ", 0, " + (Integer)session.getAttribute("userId") + ");";
try{ 
	query.executeUpdate(addPost); 
}
catch(Exception e){ 
	out.println("something went mad wrong yo"); 
	Thread.sleep(2000); 
	response.sendRedirect("index.jsp");
}

//redirect the user back to the thing
response.sendRedirect("index.jsp"); 
%>
</body>
</html>