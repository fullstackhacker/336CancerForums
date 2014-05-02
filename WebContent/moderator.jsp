<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 
<%
if(!session.getAttribute("usertype").equals("mod")){ //only mods can access this page
	response.sendRedirect("index.jsp"); 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CS336: Cancer Forum | Moderator Console</title>
</head>
<body>
<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>
<% out.println("Moderator Console"); %>
<form name="verify_doctor" action="verify_doctor.jsp" method="post">
<select id="verify" name="doctor_list" size="25" multiple>
<%
String queerE = "SELECT * FROM user, doctor WHERE user.userId = doctor.userId AND doctor.verified = 0;"; 
ResultSet doctors = query.executeQuery(queerE); 

while(doctors.next()){ // print out all the doctors that need to be verified
	out.println("<option value=\"" + doctors.getString("userId") + "\">" + doctors.getString("userName") + "</option>");
}

%>
</select>
<br />
<input type="submit" value="Verify" />
</form>
</body>
</html>