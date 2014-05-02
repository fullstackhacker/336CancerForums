<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%! private final static String DOCTOR = "Doctor"; %>
<%! private String email = ""; //user's email %> 
<%! private String username = ""; //user's name %>
<%! private String password = ""; //user's password %>
<%! private String fname = ""; //user's firstname %>
<%! private String lname = ""; //user's lastname %>
<%! private boolean isDoc = false; %>
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
	this.username =(String) session.getAttribute("username"); 
	this.password = (String)session.getAttribute("password"); 
	this.fname = (String)session.getAttribute("firstname"); 
	this.lname = (String)session.getAttribute("lastname"); 
	this.isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
	
	//connecting to the database
	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	Statement query = conn.createStatement(); //create the thing that will query the db
	
	//userdatabase: userid, firstname, lastname, email, 0, password, userName
	String queryString = "INSERT INTO user (userId, firstName, lastName, email, updownVote, password, userName) VALUES(0, '" + this.fname +"','" + this.lname + "','" + this.email + "', 0, '" + this.password + "','" + this.username + "')";
	
	query.executeUpdate(queryString); //insert into the database
	
	queryString = "SELECT * FROM user WHERE user.username = '" + this.username + "'";
	ResultSet dot = query.executeQuery(queryString); //get the user's log into the table
	if(!dot.next()){ 
		//server error -> gtfo 
		return; 
	}
	int userId = dot.getInt("userId"); 
	
	if(isDoc){ //insert into doctor table 
		queryString = "INSERT INTO doctor VALUES(0,'" + userId + "', 0);";
		query.executeUpdate(queryString); 
	}
	else { //insert into casual table 
		queryString = "INSERT INTO casual VALUES(0, " + userId + ");";
		query.executeUpdate(queryString); 
	}
	out.println("REGISTERED SUCCESFULLY -->REDIRECT GOES HERE");
	session.invalidate(); 
	response.sendRedirect("index.jsp");
%>
</body>
</html>