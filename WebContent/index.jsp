<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336 Beats Cancer | Home</title>
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
<script> 
$(document).ready(function(){
	$("lung").click(function(){
		$("lung").fadeTo("fast", 1.0); 
		$("breast").fadeTo("fast", 0.3);
		$("prostate").fadeTo("fast", 0.3); 
		$("bowel").fadeTo("fast", 0.3); 
		$("stomach").fadeTo("fast", 0.3); 
		$("other").fadeTo("fast", 0.3); 
		$("lung_threads").show(); 
		$("breast_threads").hide(); 
		$("bowel_threads").hide(); 
		$("prostate_threads").hide(); 
		$("stomach_threads").hide(); 
		$("other_threads").hide();
	});
	$("breast").click(function(){
		$("breast").fadeTo("fast", 1.0); 
		$("lung").fadeTo("fast", 0.3);
		$("prostate").fadeTo("fast", 0.3); 
		$("bowel").fadeTo("fast", 0.3); 
		$("stomach").fadeTo("fast", 0.3); 
		$("other").fadeTo("fast", 0.3); 
		$("breast_threads").show(); 
		$("lung_threads").hide(); 
		$("bowel_threads").hide(); 
		$("prostate_threads").hide(); 
		$("stomach_threads").hide(); 
		$("other_threads").hide();
	}); 
	$("prostate").click(function(){
		$("prostate").fadeTo("fast", 1.0); 
		$("breast").fadeTo("fast", 0.3);
		$("lung").fadeTo("fast", 0.3); 
		$("bowel").fadeTo("fast", 0.3); 
		$("stomach").fadeTo("fast", 0.3); 
		$("other").fadeTo("fast", 0.3); 
		$("prostate_threads").show(); 
		$("breast_threads").hide(); 
		$("lung_threads").hide(); 
		$("bowel_threads").hide(); 
		$("stomach_threads").hide(); 
		$("other_threads").hide();
	}); 
	$("bowel").click(function(){
		$("bowel").fadeTo("fast", 1.0); 
		$("breast").fadeTo("fast", 0.3);
		$("prostate").fadeTo("fast", 0.3); 
		$("lung").fadeTo("fast", 0.3); 
		$("stomach").fadeTo("fast", 0.3); 
		$("other").fadeTo("fast", 0.3); 
		$("bowel_threads").show(); 
		$("breast_threads").hide(); 
		$("prostate_threads").hide(); 
		$("lung_threads").hide();
		$("stomach_threads").hide(); 
		$("other_threads").hide();
	}); 
	$("stomach").click(function(){
		$("stomach").fadeTo("fast", 1.0); 
		$("breast").fadeTo("fast", 0.3);
		$("prostate").fadeTo("fast", 0.3); 
		$("bowel").fadeTo("fast", 0.3); 
		$("lung").fadeTo("fast", 0.3); 
		$("other").fadeTo("fast", 0.3); 
		$("stomach_threads").show(); 
		$("breast_threads").hide(); 
		$("prostate_threads").hide(); 
		$("bowel_threads").hide(); 
		$("lung_threads").hide(); 
		$("other_threads").hide();
	}); 
	$("other").click(function(){
		$("other").fadeTo("fast", 1.0); 
		$("breast").fadeTo("fast", 0.3);
		$("prostate").fadeTo("fast", 0.3); 
		$("bowel").fadeTo("fast", 0.3); 
		$("stomach").fadeTo("fast", 0.3); 
		$("lung").fadeTo("fast", 0.3); 
		$("other_threads").show(); 
		$("breast_threads").hide(); 
		$("bowel_threads").hide();
		$("prostate_threads").hide(); 
		$("stomach_threads").hide(); 
		$("lung_threads").hide();
	});
}); 

</script>
</head>
<body>
<%
if(session.getAttribute("userId")==null){ //user is not logged in 
	response.sendRedirect("loginform.jsp"); 
}

if(request.getParameter("threadtitle") != null){ //user wants to view this thread 
	session.setAttribute("currentThread", request.getParameter("threadtitle")); 
	response.sendRedirect("thread.jsp"); 
}
 
//user is logged in 

//user attributes
Integer userId = (Integer)session.getAttribute("userId"); 
String username = (String)session.getAttribute("username"); 
String firstname = (String)session.getAttribute("firstname"); 
String lastname = (String)session.getAttribute("lastname"); 
String email = (String)session.getAttribute("email");
boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
Integer votes = (Integer)session.getAttribute("votes");

//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db


%>

<div id="userbox">
	<button type="button" onclick="window.location='profile.jsp'"><%= username %></button>
	<button type="button" onclick="window.location='messages.jsp'">Messages</button>
	<button type="button" onclick="window.location='logout.jsp'">Logout</button>
</div>

<h1>Cancer Ends Here</h1>


 <jsp:include page="header.jsp" flush="true" />

<div id="lung_threads" class="threadbox"> 
<%
//get the topic id
String topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"lung\";";
ResultSet topicSet = query.executeQuery(topicIdcall); 
int topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println("There are no topics yet."); //error


//get the threads in the topic
String threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
ResultSet threadSet = query.executeQuery(threadCall); 
while(threadSet.next()){ 
	//get thread title
	String threadtitle = threadSet.getString("title");
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT username FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("username"); 
	
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime()); 
	String dateString = date.toString(); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//print out the thread in its own div box 
	out.println("<form name=\"" + threadtitle + "\" class=\"thread\" action=\"index.jsp\">");
	out.println("<p class=\"threadtitle\">" + threadtitle + "</p>");
	out.println("<p class=\"author\">" + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\">" + threadvotes + "</p>");
	out.println("<input class=\"hidden\" name=\"threadtitle\" value=\"" + threadtitle + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
}
%>

</div>

<div id="stomach_threads" class="threadbox">
<%
//fill in 
%>
</div>

<div id="prostate_threads" class="threadbox">
<%
//fill in
%>
</div>

<div id="bowel_threads" class="threadbox"></div>

<div id="breast_threads" class="threadbox"></div>

<div id="other_threads" class="threadbox"></div>

<!--  create thread  -->

<form name="createthread" action="createthread.jsp" method="post">
<input name="cthread_name" type="text" size="20" placeholder="Thread Name">
<br/>
<textarea name="cthread_content" form="createthread" rows="20" cols="30"> 
Thread Description
</textarea>
<br/>
<select name="topic"> 
	<option name="lung" value="lung">Lung</option>
	<option name="stomach" value="stomach">Stomach</option>
	<option name="prostate" value="prostate">Prostate</option>
	<option name="bowel" value="bowel">Bowel</option>
	<option name="breast" value="breast">Breast</option>
</select>
<br/>
<input type="submit" value="Create Thread">
</form>

</body>
</html>