<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 
<%
if(!(session.getAttribute("usertype").equals("mod") || session.getAttribute("usertype").equals("admin"))){ //only mods and admin can access this page
	response.sendRedirect("index.jsp"); 
}
int companyId = 1; 
if(request.getParameter("companyId") != null){ 
	companyId = Integer.parseInt(request.getParameter("companyId")); 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>336 Beats Cancer | Moderator Console</title>
</head>
<body>
<div id="header">
<jsp:include page="header.jsp" flush="true" />
</div>
<div id="wrapper">
<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>
<h2>Moderator Console</h2>
<br />
Doctor's that need verification:
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
<br />
<form id="verifycompanies" name="verifycompanies" action="verifycompanies.jsp" method="post" >
<select id="verify" name="companylist" size="25" multiple>
<%
//get companies that are unverified
String getCompaniesQuery = ""; 

//execute query
ResultSet unverifiedCompanies = null; 
try{ 
	unverifiedCompanies = query.executeQuery(getCompaniesQuery);
}
catch(Exception e){
	out.println(getCompaniesQuery);
	out.println(e.getMessage()); 
	return;
}

while(unverifiedCompanies.next()){ 
	out.println("<option value=\"" + unverifiedCompanies.getInt("companyId") + "\"> " + unverifiedCompanies.getString("name") + " </option>");
}
%>
</select>
<br />
<input type="submit" value="verify" />
</form>

<br />
<!-- Pick company to approve ads from  -->
Pick the company that you want to approve ads for:
<select name="companies" onchange="window.location.href='moderator.jsp?companyId=' + document.getElementId('companies').value">
<%
//get VERIFIED companies
String getVerifiedCompanies = "";
ResultSet verifiedCompanies = null;
try{ 
	verifiedCompanies = query.executeQuery(getVerifiedCompanies); 
}
catch(Exception e){ 
	out.println(getVerifiedCompanies);
	out.println(e.getMessage());
	return;
}

while(verifiedCompanies.next()){
	out.println("<option value=\"" + verifiedCompanies.getInt("companyId") + "\"> " + verifiedCompanies.getString("name") + " </option>");
}

%>
</select>
</form>

<!-- approve ads form -->
<form id="approveads" name="approveads" action="approveads.jsp" method="post">
<%
//get all the unverified ads and display them with checkboxes
String getUnapprovedAds = ""; 
ResultSet unapprovedAds = null; 

try{ 
	unapprovedAds = query.executeQuery(getUnapprovedAds); 
}
catch(Exception e){ 
	out.println(getUnapprovedAds); 
	out.println(e.getMessage()); 
}
if(unapprovedAds != null){
	while(unapprovedAds.next()){ 
		out.println("<div class=\"adverify\">");
		out.println("<img src=\"images/" + unapprovedAds.getString("imageLink") + "\" alt=\"missing link\">");
		out.println("<input type=\"checkbox\" name=\"approvedad\" value=\"" + unapprovedAds.getInt("adId") + "\" />");
		out.println("</div>");
	}
}

conn.close();
%>
<input type="submit" value="Verify Ads" />
</form>
</div>
</body>
</html>
