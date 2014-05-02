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
<title>336CancerForums | Search</title>
</head>
<link rel="stylesheet" type="text/css" href="global.css">
<body>
<h1>Search</h1>

<form id="search" name="search" method="post" action="search.jsp">
<input name="searchquery" type="text" placeholder="Search..." />
<br /> 
Search: 
<br />
<input type="radio" name="searchin" value="user"> Users 
<br />
<input type="radio" name="searchin" value="post"> Posts
<br />
<input type="radio" name="searchin" value="thread"> Threads
<br />
<input type="radio" name="searchin" value="doctor"> Doctors
<br />
<input type="radio" name="searchin" value="postBy"> Find Posts by This User
<br />
<input type="radio" name="searchin" value="threadBy"> Find Threads by This User
<br />
Select a topic: 
<select name="topics">
	<option name="topic" value="all">All</option>
	<option name="topic" value="lung">Lung</option>
	<option name="topic" value="breast">Breast</option>
	<option name="topic" value="stomach">Stomach</option>
	<option name="topic" value="prostate">Prostate</otpion>
	<option	name="topic" value="bowel">Bowel</option>
	<option name="topic" value="other">Other</option>
</select>
<br />
<input type="submit" value="Seach" />
</form>
</body>
</html>