<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
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
//get form attributes
String title = request.getParameter("subject"); 
String content = request.getParameter("message"); 
String userTo = request.getParameter("to"); 

if(title == null){
	out.println(title); 
	out.println(content);
	out.println(userTo);
	return;
}
//getUserToid
String gettingUserToId = "SELECT * FROM user WHERE userName = \"" + userTo + "\""; 
ResultSet userIdSet = query.executeQuery(gettingUserToId); 
userIdSet.next(); 
int userToId = userIdSet.getInt("userId"); 

//getFromUserid 
int userFrom = (Integer)session.getAttribute("userId");
if(userFrom == 0) return;

//faggot
String insertQuery;
//INSERT INTO messages (messageId, userFromId, userToId, userToSeen, content, title) VALUES (0, userId, userTo, 0, content, title);
insertQuery = "INSERT INTO messages (messageId, userFromId, userToId, userToSeen, content, title) VALUES (0, " + (Integer)session.getAttribute("userId") + ", " + userToId + ", 0, \"" + content + "\", \"" + title + "\");";
try{
	query.executeUpdate(insertQuery); 
}
catch(Exception e){ 
	out.println(e.getMessage()); 
	out.println(insertQuery);
	return; 
}

response.sendRedirect("message.jsp"); 
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