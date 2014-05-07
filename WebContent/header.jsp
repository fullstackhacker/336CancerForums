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
	
	//user attributes
	Integer userId = (Integer)session.getAttribute("userId"); 
	String username = (String)session.getAttribute("username"); 
	String firstname = (String)session.getAttribute("firstname"); 
	String lastname = (String)session.getAttribute("lastname"); 
	String email = (String)session.getAttribute("email");
	Integer votes = (Integer)session.getAttribute("votes");
	
	//see if user is a "special" user
	boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
	boolean atLeastMod = session.getAttribute("usertype") != null && ( ((String)session.getAttribute("usertype")).equals("mod") || ((String)session.getAttribute("usertype")).equals("admin") ); 
	boolean isAdmin = session.getAttribute("usertype") != null && ((String)session.getAttribute("usertype")).equals("admin"); 
	boolean isMod = session.getAttribute("usertype") != null &&  ((String)session.getAttribute("usertype")).equals("mod");

%>

<% //getting ad type(based on topic id)


/*
****Kevin's Fancy SQL Query****

String adTypeQuery = "select topicId from ((SELECT topic.topicId, count(post.postId) as postCount from post, thread, topic WHERE post.threadId = thread.threadId and thread.topicId = topic.topicId and post.authorId = " + userId.toString() +" GROUP BY topic.topicId) as T) HAVING postCount = MAX(postCount);";
ResultSet adTypers = query.executeQuery(adTypeQuery);
int adTypeNum = adTypers.getInt("topicId");
String adCountQuery = "SELECT count(*) as count from advertisement WHERE approved = 1 and adType = " + Integer.toString(adTypeNum);
ResultSet adCountrs = query.executeQuery(adCountQuery);
int adCountNum = adCountrs.getInt("count");
String adQuery = "SELECT imageLink from advertisement WHERE approved = 1 and adType = " + Integer.toString(adTypeNum);
ResultSet adRs = query.executeQuery(adQuery);
Random rV = new Random();
int adSelector = 1;
if(adCountNum > 1) {
	adSelector = (Math.abs(rV.nextInt())%adCountNum)+1;
}
adRs.absolute(adSelector);
String adLink = adRs.getString("imageLink");
*/

//*****Mush's Not-So Fancy SQL Query *****
//what do we want?: ad based on which topic the user posted the most in 
//threads in *topic*: SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = "lung" AND post.authorId = userId;

//get the number in lungs 
String postInLungsQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"lung\" AND post.authorId = " + userId + ";";
String postInStomachQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"stomach\" AND post.authorId = " + userId + ";";
String postInBowelQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"bowel\" AND post.authorId = " + userId + ";";
String postInBreastQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"breast\" AND post.authorId = " + userId + ";";
String postInProstateQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"prostate\" AND post.authorId = " + userId + ";";
String postInOtherQuery = "SELECT COUNT(*) AS count FROM post, thread, topic WHERE post.threadId = thread.threadId AND thread.topicId = topic.topicId AND topic.name = \"other\" AND post.authorId = " + userId + ";";

String maxName = "lung"; 
int maxing = 0; 
ResultSet max = query.executeQuery(postInLungsQuery);
max.next(); 
if(max.getInt("count") > maxing ){
	maxing = max.getInt("count"); 
	maxName = "lung"; 
}
max = query.executeQuery(postInStomachQuery); 
max.next(); 
if(max.getInt("count") > maxing){ 
	maxing = max.getInt("count");
	maxName = "stomach"; 
}
max = query.executeQuery(postInBowelQuery); 
max.next(); 
if(max.getInt("count") > maxing){ 
	maxing = max.getInt("count");
	maxName = "bowel"; 
}
max = query.executeQuery(postInBreastQuery); 
max.next(); 
if(max.getInt("count") > maxing){ 
	maxing = max.getInt("count");
	maxName = "breast"; 
}
max = query.executeQuery(postInProstateQuery); 
max.next(); 
if(max.getInt("count") > maxing){ 
	maxing = max.getInt("count");
	maxName = "prostate"; 
}
max = query.executeQuery(postInOtherQuery); 
max.next(); 
if(max.getInt("count") > maxing){ 
	maxing = max.getInt("count");
	maxName = "other"; 
}
//have the name of the topic get the topic Id now
String getmaxtopicidstring = "SELECT * FROM topic WHERE topic.name = \"" + maxName + "\";";
ResultSet maxtopicId = null;
try{
	maxtopicId = query.executeQuery(getmaxtopicidstring); 
}
catch(Exception e){ 
	out.println(getmaxtopicidstring); 
	out.println(e.getMessage());
	return; 
}
int maxTopicId = -1; 
String imageLink = "";
if(!maxtopicId.next()){
	imageLink = "images/CancerBanner.png";
}
else{ 
	maxTopicId = maxtopicId.getInt("topicId"); 

//have the topic id now pick an ad from the database
String getAd = "SELECT COUNT(*) AS count FROM advertisement WHERE advertisement.adType = " + maxTopicId + " AND advertisement.approved = 1;";
ResultSet ads = query.executeQuery(getAd);
if(!ads.next()) imageLink = "images/CancerBanner.png";
else{
int numads = ads.getInt("count"); 
int rndm = new Random().nextInt(numads); 

String getAds = "SELECT * FROM advertisement WHERE advertisement.adType = " + maxTopicId + " AND advertisement.approved = 1;";
ads = query.executeQuery(getAds); 

//got the number of ads
//get random ad
ads.next();
for(int i=1; i<=rndm; i++){
	ads.next(); 
}
imageLink = "images/" + ads.getString("imageLink");
}
} 	
%>

<% 
//check if the user has an unread messages
//SELECT * FROM messages WHERE userToId = userId AND userToSeen = 0;
String getMessages = "SELECT * FROM messages WHERE userToId = " + userId + " AND userToSeen = 0;";
ResultSet getPaper = query.executeQuery(getMessages); 
String messageButtonString = ""; 
if(!getPaper.next()) messageButtonString = "Messages";
else{ //count new messages
	String countMessages = "SELECT COUNT(*) AS newmessages FROM messages WHERE userToId = " + userId + " AND userToSeen = 0;"; 
	ResultSet counter = query.executeQuery(countMessages);
	counter.next(); 
	messageButtonString = "Messages (" + counter.getInt("newmessages") + ")";
}

%>

<%
conn.close();
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
	<%if(atLeastMod)out.println("<button type=\"button\" onclick=\"window.location='moderator.jsp'\">Moderator Console</button>"); %>
	<button type="button" onclick="window.location='searchform.jsp'">Search</button>
	<button type="button" onclick="window.location='message.jsp'">Messages</button>
	<button type="button" onclick="window.location='logout.jsp'">Log Out</button>
</div>
<a href="donation.jsp"><img src="<%=imageLink %>" alt="advertisementOHGOODY"></a>
<a href="index.jsp"><img src=images/CancerBanner.png></a>

</body>
</html>
