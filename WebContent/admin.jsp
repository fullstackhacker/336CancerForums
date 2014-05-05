<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>  
    
    
<%! private String cdtom = ""; //casual/doctor to make into a mod %>
<%! private String mtocd = ""; //mod to make into a casual/doctor %>

<% 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Selected Casuals to Moderators")){ //adding casuals to moderators 
	//response.sendRedirect("index.jsp");
	String[] casuals = request.getParameterValues("currentCasuals");
	int x; //counting how many casuals we have to upgrade
	for(x=0; x<casuals.length; x++){
		session.setAttribute("tomod"+x, casuals[x]); 
	}
	session.setAttribute("numUp", Integer.toString(x)); 
	response.sendRedirect("makeMods.jsp"); 

}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Selected Doctors to Moderators")){ //adding doctors to moderators 
	String[] doctors = request.getParameterValues("currentDoctors"); 
	int x; //counting how many doctors we have to upgrade
	for(x=0; x<doctors.length; x++){
		session.setAttribute("tomod"+x, doctors[x]); 
	}
	session.setAttribute("numUp", Integer.toString(x)); 
	response.sendRedirect("makeMods.jsp");
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Remove Selected from Moderatoring Staff")){ //removed selected moderators
	String[] mods = request.getParameterValues("currentModerators"); 
	int x; //counting how many mods to remove
	for(x=0; x<mods.length; x++){
		session.setAttribute("mod"+x, mods[x]); 
	}
	session.setAttribute("numdown", Integer.toString(x)); 
	response.sendRedirect("downMods.jsp"); 
}
%>

<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336 Beats Cancer | Admin Console</title>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
</head>
<body>
<div id="wrapper">
<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>
<div id="center">
<h1>Admin Console</h1>
</div>

<section id = "casuals"> 
<form name = "casualtomod" action="makeMods.jsp" method="post">
<p>List of Patients</p>
<select id="current_casuals" name="newMods" size="20" multiple>
<%
//get all casuals
String queryString = "SELECT * FROM user, casual WHERE user.userId = casual.userId AND NOT EXISTS (SELECT * FROM moderator WHERE moderator.userId = user.userId);";
ResultSet casuals = query.executeQuery(queryString); 

while(casuals.next()){ //<option value="name"> name </option>
	out.println("<option value=\"" + casuals.getString("userId") + "\">" + casuals.getString("userName")  + "</option>" );
}
%>
</select>
<br/>
<input type="submit" value="Add Selected Patients to Moderators">
</form>
</section>
<br/>
<section id = "doctors">
<form name = "doctortomod" action="makeMods.jsp" method="post">
<p>List of Doctors</p>
<select id="current_doctors" name="newMods" size="20" multiple>
<%
//get all doctors
queryString = "SELECT * FROM user, doctor WHERE user.userId = doctor.userId AND doctor.verified = 1 AND NOT EXISTS (SELECT * FROM moderator WHERE moderator.userId = user.userId);";// add doctor is verified
ResultSet doctors = query.executeQuery(queryString); 

while(doctors.next()){ //<option value="name"> name </option>
	out.println("<option value=\"" + doctors.getString("userId") + "\">" + doctors.getString("userName")  + "</option>" );
}
%>
</select>
<br/>
<input type="submit" value="Add Selected Doctors to Moderators">
</form>
</section>
<br>
<section id = "mods">
<form name="currentMods" id="currentMods" method="post" action="deletemods.jsp">
<p>List of Moderators</p>
<select id="current_mods" name="oldMods" size="20" multiple>
<%
//get all moderators
queryString = "SELECT * FROM user, moderator WHERE user.userId = moderator.userId;";
ResultSet moderators = query.executeQuery(queryString);

while(moderators.next()){ 
	out.println("<option value=\"" + moderators.getString("userId") + "\">" + moderators.getString("userName") + "</option>" ); 
}
%>
</select>
<br />
<input type="submit" value="Remove Selected from Moderatoring Staff">
</form>
</section>
</div>

<% conn.close();%>
</body>
</html>
