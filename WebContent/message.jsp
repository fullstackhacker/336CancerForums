<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
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
	Statement query2 = conn.createStatement();

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
//get session information 
String userName = (String)session.getAttribute("username"); //get the user's username
Integer userId = (Integer)session.getAttribute("userId"); //get the user's id
String firstName = (String)session.getAttribute("firstname"); //don't think i'll need this 
String lastName = (String)session.getAttribute("lastname");  //dont think i'll need this
%>


<h1>Messages Inbox:</h1>
<%
//get new messages: SELECT * FROM messages WHERE userToId = userId; 
String getNewMessagesQuery = "SELECT * FROM messages WHERE userToId = " + userId + ";";
ResultSet messages = null; 
try{ 
	messages = query.executeQuery(getNewMessagesQuery);
}
catch(Exception e){
	out.println(getNewMessagesQuery); 
	return; 
}

if(messages == null){ 
	//shouldn't happen 
}

boolean hasMessage = false; 
while(messages.next()){ 
	hasMessage = true; 
	
	//get message contents
	int messageId = messages.getInt("messageId"); 
	int fromId = messages.getInt("userFromId"); 
	int seen = messages.getInt("userToSeen"); 
	Date date = new Date(messages.getTimestamp("datetimeCreated").getTime());
	String content = messages.getString("content"); 
	String title = messages.getString("title");
	
	//get fromUserName
	//user: SELECT * FROM user WHERE userId = fromId; 
	String fromUserQuery = "SELECT * FROM user WHERE userId = " + fromId + ";";
	ResultSet fromUserSet = null; 
	try{ 
		fromUserSet = query2.executeQuery(fromUserQuery); 
	}
	catch(Exception e){ 
		out.print(e.getMessage());
		out.println(fromUserQuery); 
		return; 
	}
	fromUserSet.next(); // should be on 
	String fromUserName = fromUserSet.getString("userName");  
	
	//differentiate between seen and unseen messages
	String displayText = ""; 
	if(seen == 0){//not seen 
		displayText = "<p class=\"unseen\"> Title:  " + title ; 
	}
	else{
		displayText = "<p class=\"seen\"> Title: " + title ;
	}
	
	//display message
	out.println("<form id=\"message\" name=\"message=\" method=\"post\" action=\"viewmessage.jsp\">");
	out.println(displayText);
	out.println(" From: " + fromUserName + "</p>");
	out.println("<input class=\"hidden\" type=\"text\" name=\"messageId\" value=\"" + messageId + "\" />");
	out.println("<input class=\"hidden\" type=\"text\" name=\"messageTitle\" value=\"" + title + "\" />");
	out.println("<input class=\"hidden\" type=\"text\" name=\"messageFrom\" value=\"" + fromUserName + "\" />");
	out.println("<input type=\"submit\" value=\"View Message\" />"); 
	out.println("</form>"); 
	
}

if(!hasMessage) out.println("You have no messages"); 
%>
<div id="wrapper">
<form id="message" name="message" method="post"  action="sendmessage.jsp">
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