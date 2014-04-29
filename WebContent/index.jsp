<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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
//user is logged in 

//user attributes
Integer userId = (Integer)session.getAttribute("userId"); 
String username = (String)session.getAttribute("username"); 
String firstname = (String)session.getAttribute("firstname"); 
String lastname = (String)session.getAttribute("lastname"); 
String email = (String)session.getAttribute("email");
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
	<button type="button" onclick="window.location='logout.jps'">Logout</button>
</div>

<h1>Cancer Ends Here</h1>

<div id="lung_threads" class="threadbox"> 
<%
String topicIdcall = "SELECT topic"
//fill via db call
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



</body>
</html>