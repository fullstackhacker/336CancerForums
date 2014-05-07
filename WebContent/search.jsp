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
Statement query2 = conn.createStatement(); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336CancerForum | Search</title>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
<div id="wrapper">
<%
String searchQuery = request.getParameter("searchquery"); 
String searchingType = request.getParameter("searchin"); 
String topic = request.getParameter("topics"); 

int topicId = -1; 
if(!topic.equals("all")){ //get the topicId
	String queryshit = "SELECT * FROM topic WHERE name = \"" + topic + "\";"; 
	ResultSet queryShit = query.executeQuery(queryshit); 
	queryShit.next(); 
	topicId = queryShit.getInt("topicId"); 
}
String fuckingTopic = ""; 

String forMessage = searchingType.equals("messages") ? " WHERE messages.userToId = " + ((Integer)session.getAttribute("userId")).toString() + " " : "";


boolean isDoc  = session.getAttribute("isDoc") != null && session.getAttribute("isDoc").equals("yes");

if(searchingType.equals("postBy")){ //want posts by searchQuery
	if(topicId != -1){
		fuckingTopic = " AND thread.threadId = post.threadId AND thread.topicId = " + topicId; 
	}

	//get userId
	String userIdString = "SELECT * FROM user WHERE user.userName = \"" + searchQuery + "\";";
	ResultSet userIdSet = null; 
	try{ 
		userIdSet = query2.executeQuery(userIdString); 
	}
	catch(Exception e){ 
		out.println(userIdString); 
		out.println(e.getMessage());
		return; 
	}
	//should only be one that matches
	int userId = -1; 
	if(userIdSet.next()){
		userId = userIdSet.getInt("userId"); 
	}
	else{ //user doesn't exist
		out.println("Invalid User Name");
		response.sendRedirect("searchform.jsp");
	}
	//SELECT * FROM post, thead WHERE post.authorId = userId AND thread.threadId = post.threadId AND thread.topicId = topicId; 
	//get posts by the user now
	String tablefuck = ""; 
	if(fuckingTopic.equals("")) tablefuck = "post"; 
	else tablefuck = "post, thread"; 
	String postByQuery = "SELECT * FROM " + tablefuck + " WHERE post.authorId =" + userId + fuckingTopic +";";
	ResultSet rs = null; 
	try{ 
		rs = query.executeQuery(postByQuery); 
	}
	catch(Exception e){ 
		out.println(e.getMessage()); 
		out.println(postByQuery); 
		return; 
	}
	
	boolean atleastOne = false; 
	while(rs.next()){ 
		atleastOne = true; 
		
		//get attributes
		String content = rs.getString("content"); 
		int postId = rs.getInt("postId"); 
		Timestamp ts = rs.getTimestamp("datetimeCreated"); 
		Date date = new Date(ts.getTime()); 
		int votes = rs.getInt("updownVotes"); 
		
		//get authorsout.println("<div class=\"post\">");
		String author = ""; 
		String authorQ = "SELECT userName FROM user WHERE user.userId = " + rs.getInt("authorId"); 
		ResultSet hasAuthor = query2.executeQuery(authorQ); 
		hasAuthor.next(); 
		author = hasAuthor.getString("userName");
		
		//display post
		out.println("<div class=\"post\">");
		out.println("<p class=\"content\">" + content + "</p>"); 
		out.println("<p class=\"author\"> Author: " + author + "</p>"); 
		out.println("<p class=\"date\"> Posted Date: " + date.toString() + "</p>");
		out.println("<p class=\"votes\"> Votes:" + votes + "</p>");
		
		//upvoting form 
		out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"upvote.jsp\" method=\"post\" >"); 
		out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
		out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
		out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
		out.println("</form>"); 
		
		//down voting form 
		out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"downvote.jsp\" method=\"post\" >"); 
		out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
		out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
		out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
		out.println("</form>");
		
		//view profile
		out.println("<form id=\"" + rs.getInt("authorId") + "\" name=\"viewprofile\" method=\"post\" action=\"userProfile.jsp\" >");
		out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + rs.getInt("authorId") + "\" />");
		out.println("<input type=\"submit\" value=\"View Profile\" />");
		out.println("</form>"); 
		
		out.println("</div>");
		out.println("<hr />");
	}
	
	if(!atleastOne){
		out.println("User doesn't have any posts!");
		return;
	}
}
else if(searchingType.equals("threadBy")){
	if(topicId != -1){ //good for threads
		fuckingTopic = " AND topicId = " + Integer.toString(topicId); 
	}
	
	//get userId
	String userIdString = "SELECT * FROM user WHERE user.userName = \"" + searchQuery + "\";";
	ResultSet userIdSet = null; 
	try{ 
		userIdSet = query2.executeQuery(userIdString); 
	}
	catch(Exception e){ 
		out.println(userIdString); 
		out.println(e.getMessage());
		return; 
	}
	//should only be one that matches
	int userId = -1; 
	if(userIdSet.next()){
		userId = userIdSet.getInt("userId"); 
	}
	else{ //user doesn't exist
		out.println("Invalid User Name");
		response.sendRedirect("searchform.jsp");
	}
	
	//get posts by the user now
	String postByQuery = "SELECT * FROM thread WHERE thread.authorId =" + userId + fuckingTopic +";";
	ResultSet rs = null; 
	try{ 
		rs = query.executeQuery(postByQuery); 
	}
	catch(Exception e){ 
		out.println(e.getMessage()); 
		out.println(postByQuery); 
		return; 
	}
	
	boolean atleastOne = false;
	
	while(rs.next()){ 
		//get thread title
		String threadtitle = rs.getString("title");
			
		//get thread creatation date
		Date date = new Date(rs.getTimestamp("datetimeCreated").getTime());
		String dateString = date.toString();
		
		//get threadId
		int threadId = rs.getInt("threadId"); 
		
		//get thread votes
		int threadvotes = -1; 
		threadvotes = rs.getInt("updownVotes"); 	
		
		//get thread author
		String author = ""; 
		String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + rs.getInt("threadId") + "\" AND user.userId = thread.authorId;";
		ResultSet authorname = query2.executeQuery(getAuthorState); 
		if(authorname.next()) author = authorname.getString("userName"); 
		
		//print out the thread in its own div box 
		out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
		out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
		out.println("<p class=\"author\"> Author: " + author + "</p>");  
		out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
		out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
		out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
		out.println("<input type=\"submit\" value=\"View Thread\" />");
		out.println("</form>");
		
		//up vote form 
		out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
		out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
		out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
		out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
		out.println("</form>");
		
		//down vote form
		out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
		out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
		out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
		out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
		out.println("</form>");
		
		//view author
		out.println("<form id=\"" + rs.getInt("authorId") + "\" name=\"viewprofile\" method=\"post\" action=\"userprofile.jsp\" >");
		out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + rs.getInt("authorId") + "\" />");
		out.println("<input type=\"submit\" value=\"View Profile\" />");
		out.println("</form>"); 
		
		out.println("<hr/>");
	}
}
else{ 
	String getData = "SELECT * FROM " + searchingType + forMessage + ";"; 
	ResultSet rs = null;  
	try{ 
		rs = query.executeQuery(getData);
	}
	catch(Exception e){ 
		out.println(e.getMessage()); 
		out.println(" ");
		out.println(getData);
		response.sendRedirect("searchform.jsp");
		return; 
	}
	boolean atleastOne = false; 
	while(rs.next()){
		//do something to make sure that casuals cant search through doctor posts
		if(!searchingType.equals("user")){
			//do that shit in here
			
		}
		
		atleastOne = true; 
		
		// get columnName : userName for users, content for post, and title for thread
		String column = ""; String column2 = ""; // column2 only for messages
		if(searchingType.equals("user")){ 
			column = "userName"; 
		}
		else if(searchingType.equals("post")){ 
			column = "content"; 
		}
		else if(searchingType.equals("thread")){
			column = "title"; 
		}
		else if(searchingType.equals("messages")){
			column = "content";
			column2 = "title"; 
		}
		
		String info = rs.getString(column); 
		if(searchingType.equals("messages")){
			info += rs.getString(column2); 
		}
		
		if(info == null){
			out.println("searchQuery: " + searchQuery); 
			out.println("searchingType: " + searchingType);
			out.println("column: " + column); 
			out.println("info is null");
			return; 
		}
		else if(searchQuery == null){ 
			out.println("searchQuery: " + searchQuery); 
			out.println("searchingType: " + searchingType);
			out.println("column: " + column); 
			out.println("searchQuery is null");
			return; 
		}
		
		
		if(info.contains(searchQuery)){ //print it out
			if(searchingType.equals("post")){
				//get attributes
				String content = rs.getString("content"); 
				int postId = rs.getInt("postId"); 
				Timestamp ts = rs.getTimestamp("datetimeCreated"); 
				Date date = new Date(ts.getTime()); 
				int votes = rs.getInt("updownVotes"); 
				
				//get authorsout.println("<div class=\"post\">");
				String author = ""; 
				String authorQ = "SELECT userName FROM user WHERE user.userId = " + rs.getInt("authorId"); 
				ResultSet hasAuthor = query2.executeQuery(authorQ); 
				hasAuthor.next(); 
				author = hasAuthor.getString("userName");
				
				//display post
				out.println("<div class=\"post\">");
				out.println("<p class=\"content\">" + content + "</p>"); 
				out.println("<p class=\"author\"> Author: " + author + "</p>"); 
				out.println("<p class=\"date\"> Posted Date: " + date.toString() + "</p>");
				out.println("<p class=\"votes\"> Votes:" + votes + "</p>");
				
				//upvoting form 
				out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"upvote.jsp\" method=\"post\" >"); 
				out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
				out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
				out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
				out.println("</form>"); 
				
				//down voting form 
				out.println("<form id=\"" + postId + "\" name=\"" + postId + "\" action=\"downvote.jsp\" method=\"post\" >"); 
				out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + postId + "\" />"); 
				out.println("<input class=\"hidden\" type=\"text\" name=\"type\" value=\"post\" />"); 
				out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
				out.println("</form>");
				
				//view user form
				out.println("<form id=\"" + rs.getInt("authorId") + "\" name=\"viewprofile\" method=\"post\" action=\"userprofile.jsp\" >");
				out.println("<input class=\"hidden\" type=\"text\" name=\"id\" value=\"" + rs.getInt("authorId") + "\" />");
				out.println("<input type=\"submit\" value=\"View Profile\" />");
				out.println("</form>"); 
				out.println("</div>");
			}
			else if(searchingType.equals("thread")){
				//get thread title
				String threadtitle = rs.getString("title");
					
				//get thread creatation date
				Date date = new Date(rs.getTimestamp("datetimeCreated").getTime());
				String dateString = date.toString();
				
				//get threadId
				int threadId = rs.getInt("threadId"); 
				
				//get thread votes
				int threadvotes = -1; 
				threadvotes = rs.getInt("updownVotes"); 	
				
				//get thread author
				String author = ""; 
				String getAuthorState = "SELECT userName FROM user, thread WHERE threadId = \"" + rs.getInt("threadId") + "\" AND user.userId = thread.authorId;";
				ResultSet authorname = query2.executeQuery(getAuthorState); 
				if(authorname.next()) author = authorname.getString("userName"); 
				
				//print out the thread in its own div box 
				out.println("<form id=\"" + threadId + "\" name=\"" + threadtitle + "\" class=\"thread\" action=\"thread.jsp\">");
				out.println("<p class=\"threadtitle\" Title:>" + threadtitle + "</p>");
				out.println("<p class=\"author\"> Author: " + author + "</p>");  
				out.println("<p class=\"date\"> Created On: " + dateString +  "</p>"); 	
				out.println("<p class=\"votes\"> Votes: " + threadvotes + "</p>");
				out.println("<input type=\"text\" class=\"hidden\" name=\"title\" value=\"" + threadId + "\" />");
				out.println("<input type=\"submit\" value=\"View Thread\" />");
				out.println("</form>");
				
				//up vote form 
				out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"upvote.jsp\" method=\"post\" >");
				out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />"); 
				out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
				out.println("<input type=\"submit\" value=\"Up Vote\" />"); 
				out.println("</form>");
				
				//down vote form
				out.println("<form id=\"up" + threadId + "\" name=\"up" + threadId + "\" action=\"downvote.jsp\" method=\"post\" >");
				out.println("<input type=\"text\" class=\"hidden\" name=\"id\" value=\"" + threadId + "\" />");
				out.println("<input type=\"text\" class=\"hidden\" name=\"type\" value=\"thread\" />"); 
				out.println("<input type=\"submit\" value=\"Down Vote\" />"); 
				out.println("</form>");
			}
			else if(searchingType.equals("user")){ 
				//get attributes
				out.println("<form id=\"" + rs.getString("userName") + "\" name=\"" + rs.getString("userName") + "\" method=\"post\" action=\"userProfile.jsp\" >");
				out.println("<input class=\"hidden\" name=\"id\" value=\"" + rs.getString("userId") + "\" />");
				out.println("<p class=\"username\">" + rs.getString("userName") + "</p>");
				out.println("<input type=\"submit\" value=\"View Profile\" />"); 
				out.println("</form>"); 
			}
			else if(searchingType.equals("messages")){
				//get message contents
				int messageId = rs.getInt("messageId"); 
				int fromId = rs.getInt("userFromId"); 
				int seen = rs.getInt("userToSeen"); 
				Date date = new Date(rs.getTimestamp("datetimeCreated").getTime());
				String content = rs.getString("content"); 
				String title = rs.getString("title");
				
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
				out.println("<form class=\"buttonform\" id=\"message\" name=\"message=\" method=\"post\" action=\"viewmessage.jsp\">");
				out.println(displayText);
				out.println(" From: " + fromUserName + "</p>");
				out.println("<input class=\"hidden\" type=\"text\" name=\"messageId\" value=\"" + messageId + "\" />");
				out.println("<input class=\"hidden\" type=\"text\" name=\"messageTitle\" value=\"" + title + "\" />");
				out.println("<input class=\"hidden\" type=\"text\" name=\"messageFrom\" value=\"" + fromUserName + "\" />");
				out.println("<input type=\"submit\" value=\"View Message\" />"); 
				out.println("</form>"); 
				
				//delete
				out.println("<form class=\"buttonform\" id=\"deletemessage\" name=\"deletemessage=\" method=\"post\" action=\"deletemessage.jsp\" >");
				out.println("<input class=\"hidden\" name=\"messageId\" value=\"" + messageId + "\" />");
				out.println("<input type=\"submit\" value=\"Delete\" />");
				out.println("</form>");
			}
			else{ 
				//shouldn't get here 
			}
			out.println("<hr />"); 
		}
	}
}


conn.close();
%>

</div>
</body>
</html>