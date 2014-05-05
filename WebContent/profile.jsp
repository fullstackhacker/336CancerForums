<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 

<%
String passwordError = ""; 

if(session.getAttribute("passwordError") != null){
	passwordError = (String)session.getAttribute("passwordError"); 
}

if(session.getAttribute("userId")==null){ //user is not logged in 
	response.sendRedirect("loginform.jsp"); 
}

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
String email = (String)session.getAttribute("email"); //get the user's email
String firstname = (String)session.getAttribute("firstname"); //get the user's firstname
String lastname = (String)session.getAttribute("lastname"); //get the user's firstname 

//see if user is a "special" user
boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
boolean atLeastMod = session.getAttribute("usertype") != null && ( ((String)session.getAttribute("usertype")).equals("mod") || ((String)session.getAttribute("usertype")).equals("admin") ); 
boolean isAdmin = session.getAttribute("usertype") != null && ((String)session.getAttribute("usertype")).equals("admin"); 
boolean isMod = session.getAttribute("usertype") != null &&  ((String)session.getAttribute("usertype")).equals("mod"); 

%>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style rel="stylesheet" type="text/css" href="global.css"></style>
<style rel="stylesheet" type="text/css" href="profile.css"></style>
<title>336 is Cancer | User Profile</title>
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>

<!-- Profile form; the user can update any information except username and type (doctor or patient) -->
<div id="wrapper">
<div id="profile">
 <form id="profile" name="profile" method="post" action="editprofile.jsp">
   <fieldset>
     <label type="text" name="register">User Profile for <%= username %></label><br/><br/>
     <label type="text" name="user">Username:</label>
     <input type="text" name="username" size="30" value="<%= username %>" class="text-input" />
     <br/>
     <label type="text" name="first">First Name:</label>
     <input type="text" name="firstname" size="30" value="<%= firstname %>" class="text-input">
     <br/>
     <label type="text" name="last">Last Name:</label>
     <input type="text" name="lastname" size="30" value="<%= lastname %>" class="text-input">
     <br/>
     <label type="text" name="emailname">Email:</label>
     <input type="email" name="email" size="30"  value="<%= email %>" class="text-input">
     <br/>
     <br/> 
     <label type="text" name="areyoua">You are a:</label><br/>
     <input type="radio" name="type" value="casual" <%if(!isDoc) out.print("checked=\"checked\"");%> > Casual <br/> 
     <input type="radio" name="type" value="doctor" <%if(isDoc) out.print("checked=\"checked\""); %> > Doctor <br/>
	 <%if(isMod)out.print("<input type=\"radio\" name=\"type\" value=\"moderator\" checked=\"checked\"> Moderator <br/>");%>
	 <%if(isAdmin)out.print("<input type=\"radio\" name=\"type\" value=\"admin\" checked=\"checked\"> Admin <br/>");%>
	 <br />
	 <label type="text" name="resetPassword">Reset Password:</label><br/>
	 <input type="password" name="newpassword" id="password" size="30" placeholder="New Password" class="text-input" /><%= passwordError %>
     <br/>
     <input type="password" name="newconfirmpassword" id="password" size="30" placeholder="Confirm New Password" class="text-input" />
     <br />
     <br />
     <input type="submit" name="Update" class="button" id="update_btn" value="Save Changes" />
   </fieldset>
 </form>
 </div>
 
</div>
<% conn.close(); %>
</body>
</html>