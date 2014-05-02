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
	
	
	String username = (String)session.getAttribute("username"); //get the user's username 
	
	//see if user is a "special" user
	boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
	boolean atLeastMod = session.getAttribute("usertype") != null && ( ((String)session.getAttribute("usertype")).equals("mod") || ((String)session.getAttribute("usertype")).equals("admin") ); 
	boolean isAdmin = session.getAttribute("usertype") != null && ((String)session.getAttribute("usertype")).equals("admin"); 
	boolean isMod = session.getAttribute("usertype") != null &&  ((String)session.getAttribute("usertype")).equals("mod");

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
<img src=images/CancerBanner.png>
</body>
</html>
