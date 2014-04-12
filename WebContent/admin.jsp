<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CS336:Cancer Forum | Admin Console</title>
</head>
<body>
<h1>Admin Console</h1>

<section id = "casuals"> 
<select id="current_casuals" size="25" multiple>
<%
//get all casuals
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db

String queryString = "SELECT * FROM casuals;";
ResultSet casuals = query.executeQuery(queryString); 

while(casuals.next()){ //<option value="name"> name </option>
	out.println("<option value=\"" + casuals.getString("username") + "\">" + casuals.getString("username")  + "</option>" );
}

%>
</select>
<button name = "addMod">Add to Mods</button>
</section>


<section id = "mods">
<select id="current_mods" size="25" multiple>

</select>
<button name = "removeMod">Remove Mods</button>
</section>
</body>
</html>