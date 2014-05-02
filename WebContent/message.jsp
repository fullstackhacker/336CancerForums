<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
if(session.getAttribute("userId")==null){ //user is not logged in 
	response.sendRedirect("loginform.jsp"); 
}
%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	//connecting to the database
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db

%>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336 Beats Cancer | Messages</title>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
</head>
<body>

<% 
	String username = (String)session.getAttribute("username"); //get the user's username 		
%>

<div id="wrapper">
<form id="message" name="message" method="post" onsubmit="return validateForm()" action="message.jsp">
<label type="text" name="register">Send a Message</label>
<br>
	<input form="message" type="text" name="to" id="to" size="30" placeholder="Send Message to:" class="text-input" />
	<br />
	<input form="message" type="text" name="subject" id="subject" size="30" placeholder="Subject" maxlength="30" class="text-input" />
	<br />
    <textarea form="message" type="text" name="message" size="30" id="message" placeholder="Message Body" class="text-input" /></textarea>
    <br />
    <input type="submit" name="send" class="button" id="send" value="Send" />
</form>

</div>
</body>
</html>