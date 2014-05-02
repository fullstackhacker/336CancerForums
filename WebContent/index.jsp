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
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
<script> 
$(document).ready(function(){
	$("#breast_threads").hide(); 
	$("#bowel_threads").hide(); 
	$("#prostate_threads").hide(); 
	$("#stomach_threads").hide(); 
	$("#other_threads").hide(); 
	$("#breast").fadeTo("fast", 0.3);
	$("#prostate").fadeTo("fast", 0.3); 
	$("#bowel").fadeTo("fast", 0.3); 
	$("#stomach").fadeTo("fast", 0.3); 
	$("#other").fadeTo("fast", 0.3);
	$("#lung").click(function(){
		$("#lung").fadeTo("fast", 1.0); 
		$("#breast").fadeTo("fast", 0.3);
		$("#prostate").fadeTo("fast", 0.3); 
		$("#bowel").fadeTo("fast", 0.3); 
		$("#stomach").fadeTo("fast", 0.3); 
		$("#other").fadeTo("fast", 0.3); 
		$("#lung_threads").show(); 
		$("#breast_threads").hide(); 
		$("#bowel_threads").hide(); 
		$("#prostate_threads").hide(); 
		$("#stomach_threads").hide(); 
		$("#other_threads").hide();
	});
	$("#breast").click(function(){
		$("#breast").fadeTo("fast", 1.0); 
		$("#lung").fadeTo("fast", 0.3);
		$("#prostate").fadeTo("fast", 0.3); 
		$("#bowel").fadeTo("fast", 0.3); 
		$("#stomach").fadeTo("fast", 0.3); 
		$("#other").fadeTo("fast", 0.3); 
		$("#breast_threads").show(); 
		$("#lung_threads").hide(); 
		$("#bowel_threads").hide(); 
		$("#prostate_threads").hide(); 
		$("#stomach_threads").hide(); 
		$("#other_threads").hide();
	}); 
	$("#prostate").click(function(){
		$("#prostate").fadeTo("fast", 1.0); 
		$("#breast").fadeTo("fast", 0.3);
		$("#lung").fadeTo("fast", 0.3); 
		$("#bowel").fadeTo("fast", 0.3); 
		$("#stomach").fadeTo("fast", 0.3); 
		$("#other").fadeTo("fast", 0.3); 
		$("#prostate_threads").show(); 
		$("#breast_threads").hide(); 
		$("#lung_threads").hide(); 
		$("#bowel_threads").hide(); 
		$("#stomach_threads").hide(); 
		$("#other_threads").hide();
	}); 
	$("#bowel").click(function(){
		$("#bowel").fadeTo("fast", 1.0); 
		$("#breast").fadeTo("fast", 0.3);
		$("#prostate").fadeTo("fast", 0.3); 
		$("#lung").fadeTo("fast", 0.3); 
		$("#stomach").fadeTo("fast", 0.3); 
		$("#other").fadeTo("fast", 0.3); 
		$("#bowel_threads").show(); 
		$("#breast_threads").hide(); 
		$("#prostate_threads").hide(); 
		$("#lung_threads").hide();
		$("#stomach_threads").hide(); 
		$("#other_threads").hide();
	}); 
	$("#stomach").click(function(){
		$("#stomach").fadeTo("fast", 1.0); 
		$("#breast").fadeTo("fast", 0.3);
		$("#prostate").fadeTo("fast", 0.3); 
		$("#bowel").fadeTo("fast", 0.3); 
		$("#lung").fadeTo("fast", 0.3); 
		$("#other").fadeTo("fast", 0.3); 
		$("#stomach_threads").show(); 
		$("#breast_threads").hide(); 
		$("#prostate_threads").hide(); 
		$("#bowel_threads").hide(); 
		$("#lung_threads").hide(); 
		$("#other_threads").hide();
	}); 
	$("#other").click(function(){
		$("#other").fadeTo("fast", 1.0); 
		$("#breast").fadeTo("fast", 0.3);
		$("#prostate").fadeTo("fast", 0.3); 
		$("#bowel").fadeTo("fast", 0.3); 
		$("#stomach").fadeTo("fast", 0.3); 
		$("#lung").fadeTo("fast", 0.3); 
		$("#other_threads").show(); 
		$("#breast_threads").hide(); 
		$("#bowel_threads").hide();
		$("#prostate_threads").hide(); 
		$("#stomach_threads").hide(); 
		$("#lung_threads").hide();
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
Integer votes = (Integer)session.getAttribute("votes");

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
//check if the user has an unread messages


%>


 <jsp:include page="header.jsp" flush="true" />

<div id="wrapper">
<div id="lung_threads" class="threadbox"> 
<%
//get the topic id
String topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"lung\";";
ResultSet topicSet = query.executeQuery(topicIdcall); 
int topicId = -1; //make sure that we get an id 
topicSet.next(); 
topicId = topicSet.getInt("topicId");
if(topicId == -1) out.println("Lung There are no topics yet."); //error


//get the threads in the topic
String threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
ResultSet threadSet = query.executeQuery(threadCall); 

boolean oneThread = false; //tells us if there is at least one thread in the topic
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box
	out.println("<div class=\"forumThread\">");
	
	out.println("<div class=\"threadContent\">");
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	out.println("</div>");

	out.println("<div class=\"threadContent\">");
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
	out.println("</div>");
	
	//
	
	out.println("</div>");
	
}

if(!oneThread) out.println("There are no lung cancer threads yet!");

%>

</div>

<div id="stomach_threads" class="threadbox">
<%
//get the topic id
topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"stomach\";";
topicSet = query.executeQuery(topicIdcall); 
topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println("stomach There are no topics yet."); //error


//get the threads in the topic
threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
threadSet = query.executeQuery(threadCall); 

oneThread = false; 
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box 
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
}

if(!oneThread) out.println("There are no stomach cancer threads yet!");
%>
</div>

<div id="prostate_threads" class="threadbox">
<%
//get the topic id
topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"prostate\";";
topicSet = query.executeQuery(topicIdcall); 
topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println("prostate There are no topics yet."); //error


//get the threads in the topic
threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
threadSet = query.executeQuery(threadCall); 

oneThread = false; 
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box 
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
}

if(!oneThread) out.println("There are no prostate cancer threads yet!");

%>
</div>

<div id="bowel_threads" class="threadbox">
<%
//get the topic id
topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"bowel\";";
topicSet = query.executeQuery(topicIdcall); 
topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println("bowel There are no topics yet."); //error


//get the threads in the topic
threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
threadSet = query.executeQuery(threadCall); 

oneThread = false; 
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box 
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
}

if(!oneThread) out.println("There are no bowel cancer threads yet!");
%>
</div>

<div id="breast_threads" class="threadbox">
<%
///get the topic id
topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"breast\";";
topicSet = query.executeQuery(topicIdcall); 
topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println("breast There are no topics yet."); //error


//get the threads in the topic
threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
threadSet = query.executeQuery(threadCall); 
oneThread = false; 
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box 
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
}

if(!oneThread) out.println("There are no breast cancer threads yet!");
%>
</div>


<div id="other_threads" class="threadbox">
<%
//get the topic id
topicIdcall = "SELECT topicId FROM topic WHERE topic.name = \"other\";";
topicSet = query.executeQuery(topicIdcall); 
topicId = -1; //make sure that we get an id 
if(topicSet.next()) topicId = topicSet.getInt("topicId"); 
else out.println(" other There are no topics yet."); //error


//get the threads in the topic
threadCall = "SELECT * FROM thread WHERE thread.topicId = \"" + topicId + "\";";
threadSet = query.executeQuery(threadCall); 
while(threadSet.next()){ 
	if(!isDoc && threadSet.getInt("doconly") == 1){
		continue; 
	}
	
	oneThread = true;
	
	//get thread title
	String threadtitle = threadSet.getString("title");
		
	//get thread creatation date
	Date date = new Date(threadSet.getTimestamp("datetimeCreated").getTime());
	String dateString = date.toString();
	
	//get threadId
	int threadId = threadSet.getInt("threadId"); 
	
	//get thread votes
	int threadvotes = -1; 
	threadvotes = threadSet.getInt("updownVotes"); 	
	
	//get thread author
	String author = ""; 
	String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + threadSet.getInt("threadId") + "\" AND user.userId = thread.authorId;";
	ResultSet authorname = query2.executeQuery(getAuthorState); 
	if(authorname.next()) author = authorname.getString("userName"); 
	
	//print out the thread in its own div box 
	out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
	out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
	out.println("<p class=\"author\"> Author: " + author + "</p>");  
	out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
	out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
	out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
	out.println("<input type=\"submit\" value=\"View Thread\" />");
	out.println("</form>");
	
	//up vote form 
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
	out.println("</form>");
	
	//down vote form
	out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
	out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
	out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
	out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
	out.println("</form>");
	out.println("<hr/>");
}
if(!oneThread) out.println("There are no other cancer threads yet!");
%>
</div>

<!--  create thread  -->
<h2>Create New </h2>
<form id="createthread" name="createthread" action="createthread.jsp" method="post">
<input name="cthread_name" type="text" size="20" placeholder="Thread Name">
<br/>
<textarea name="cthread_content" form="createthread" placeholder="Thread Description" rows="20" cols="30">
</textarea>
<br/>
<select name="topic"> 
	<option name="lung" value="lung">Lung</option>
	<option name="stomach" value="stomach">Stomach</option>
	<option name="prostate" value="prostate">Prostate</option>
	<option name="bowel" value="bowel">Bowel</option>
	<option name="breast" value="breast">Breast</option>
</select>
<%
if(isDoc){  
	out.println("<input type=\"checkbox\" name=\"doconly\" value=\"doconly\">Doctor Thread Only?"); 
}
%>
<br/>
<input type="submit" value="Create Thread">
</form>

</div>
</body>
</html>