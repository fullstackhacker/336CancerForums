<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%! private final static String DOCTOR = "Doctor"; %>
<%! private String email = ""; //user's email %> 
<%! private String name = ""; //user's name %>
<%! private String password = ""; //user's password %>
<%! private String emailError = ""; //error on the email %>
<%! private String nameError = ""; //error on the name %>
<%! private String passwordError = ""; //error on the user's password %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>	
<% 
	//attrs
	this.email = (String)session.getAttribute("email"); 
	this.name =(String) session.getAttribute("username"); 
	this.password = (String)session.getAttribute("password"); 
	

	//connecting to the database
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db
	
	query.executeUpdate("INSERT INTO user VALUES ('" + this.email + "', 0, '" + this.name + "', '" + this.password + "', 0);");
	
	out.println("REGISTERED SUCCESFULLY -->REDIRECT GOES HERE");
%>
</body>
</html>