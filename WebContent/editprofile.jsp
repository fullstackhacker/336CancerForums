<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 

<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>

<%
//get userId
int userId = (Integer)session.getAttribute("userId"); 
String oldType = (String)session.getAttribute("usertype"); 

//get form values 
String userName = request.getParameter("username"); 
String firstName = request.getParameter("firstname"); 
String lastName = request.getParameter("lastname"); 
String email = request.getParameter("email");

//new type have to figure out if a casual -> doc, doc -> casual, mod -> doc, mod -> casual 
String newType = request.getParameter("type");
boolean typeChange = false; 
if(!oldType.equals(newType)){  //user is changing types
	typeChange = true; 
}
String column = ""; 
String doctor = ""; 
if(newType.equals("doctor")){
	column = "doctor"; 
	doctor = ", 0";
}
if(oldType.equals("casual")) column = "casual"; 
if(oldType.equals("mod")) column = "moderator"; 
if(oldType.equals("admin")) column = "admin";


//new passwords
String newPassword = request.getParameter("newpassword"); 
String newConfirmPassword = request.getParameter("newconfirmpassword");
boolean passwordReset = false; 
if(!newPassword.equals("")){
	passwordReset = true; 
}

//do basic update on userName, firstName, lastName, and email 
//user: UPDATE user SET userName = userName, firstName = firstName, lastName = lastName, email = email
String updateUser = "UPDATE user SET userName = \"" + userName + "\", firstName = \"" + firstName + "\", lastName = \"" + lastName + "\", email = \"" + email + "\" WHERE userId = " + userId + ";";
try{ 
	query.executeUpdate(updateUser); 
}
catch(Exception e){ 
	out.println(updateUser); 
	return;
}

//have to update the session variables
session.setAttribute("username", userName); 
session.setAttribute("firstname", firstName); 
session.setAttribute("lastname", lastName);
session.setAttribute("email", email); 

if(typeChange){
	//change the userType
	String deleteOld = "DELETE FROM " + column + " WHERE userId = " + userId + ";";
	String addNew = "INSERT INTO " + newType + " VALUES (0, " + userId + doctor + ");";
	try{ //delete the user from the "old" table 
		query.executeUpdate(deleteOld); 
	}	
	catch(Exception e){ 
		out.println(deleteOld); 
		return; 
	}

	try{ //insert the user into the "new" table 
		query.executeUpdate(addNew); 
	}
	catch(Exception e){ 
		out.println(addNew); 
		return; 
	}
	//update session on user type
	session.setAttribute("usertype", newType);
}

if(passwordReset){ 
	if(!newPassword.equals(newConfirmPassword)){ //paswords do not match
		session.setAttribute("passwordError", "Passwords do not match"); 
		response.sendRedirect("profile.jsp"); 
		return;
	}
	
	//passwords match so update password
	//UPDATE user SET password = newPassword WHERE userId = userId; 
	String changePasswordQuery = "UPDATE user SET password = \"" + newPassword + "\" WHERE userId = " + userId + ";";
	try{
		query.executeUpdate(changePasswordQuery); 
	}
	catch(Exception e){ 
		out.println(changePasswordQuery); 
		return; 
	}
	
	//password updated and we can redirect the user
}

response.sendRedirect("profile.jsp");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>