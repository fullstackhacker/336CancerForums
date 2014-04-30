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
%>

<%
	//connecting to the database
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db

%>

<%
String username = (String)session.getAttribute("username"); //get the user's username
String email = (String)session.getAttribute("email"); //get the user's email
String first = (String)session.getAttribute("firstname"); //get the user's firstname
boolean IsDoc = ((String)session.getAttribute("IsDoc")).equals("yes"); //true or false if the user is a doctor 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style rel="stylesheet" type="text/css" href="global.css"></style>
<style rel="stylesheet" type="text/css" href="profile.css"></style>
<title>336 is Cancer | User Profile</title>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<!-- Profile form; the user can update any information except username and type (doctor or patient) -->
<div id="profile">
 <form name="profile method="post" onsubmit="return validateForm()" action="profile.jsp">
   <fieldset>
     <label type="text" name="register">User Profile Information</label><br><br/>
     <label type="text" name="username">Username:</label>
     <input type="text" name="username" size="30" <%out.print("placeholder=username")%> class="text-input" />
     <br/>
     <label type="text" name="first">First Name:</label>
     <input type="text" name="firstname" size="30" <%out.print("placeholder=first")%> class="text-input">
     <br/>
     <label type="text" name="last">Last Name:</label>
     <input type="text" name="lastname" size="30" <%out.print("placeholder=last")%> class="text-input">
     <br/>
     <label type="text" name="email">Email:</label>
     <input type="email" name="email" size="30"  <%out.print("placeholder=email")%> class="text-input">
     <br/>
     <br/>
     <label type="text" name="areyoua">You are a:</label></br>
     <input type="radio" name="type" value="doc" <%if (IsDoc) out.print("checked="checked"")%> /> Doctor </br>
	 <input type="radio" name="type" value="casual" <%if (!IsDoc) out.print("checked="checked"")%>/> Casual </br> 
	 <br />
	 <input type="password" name="password" id="password" size="30" placeholder="New Password" class="text-input" />
     <br/>
     <input type="password" name="confirm password" id="password" size="30" placeholder="Confirm New Password" class="text-input" />
     <br/>
     <input type="submit" name="Update" class="button" id="update_btn" value="Save Changes" />
   </fieldset>
 </form>
 </div>
 

</body>
</html>