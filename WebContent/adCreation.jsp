<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 
<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ad Image Uploading Form</title>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
</head>
<body>
<div id="header">
 <jsp:include page="header.jsp" flush="true" />
 </div>
 <div id="wrapper">
<h3>File Upload:</h3>
Select a file to upload: <br />
<form id="uploadform" action="uploadfile.jsp" method="post" enctype="multipart/form-data">
<input type="file" name="file" size="50" />
<br />
<select form="uploadform" name="type">
<option value="1">lung</option>
<option value="2">stomach</option>
<option value="3">bowel</option>
<option value="4">prostate</option>
<option value="5">breast</option>
<option value="6">other</option>
</select>
<br />
Pick a Company: <br />
<select name="companyId">
<%
//get all the companies 
String getCompaniesString = "SELECT * FROM company WHERE approved = 1;";
ResultSet company = null;
try{ 
	company = query.executeQuery(getCompaniesString); 
}
catch(Exception e){ 
	out.println(getCompaniesString); 
	return; 
}
boolean one = false; 
while(company.next()){ //go through approved companies
	//get company info: 
	String name = company.getString("name"); 
	int id = company.getInt("companyId"); 
	one = true;
	
	//display as a drop down 
	out.println("<option value=\"" + id + "\"> " + name + "</option>");
}

if(!one) out.println("<option value=\"-1\"> None </option>");
%>
</select>
<br />
<input type="submit" value="Upload File" />
</form>
</div>
</body>
</html>