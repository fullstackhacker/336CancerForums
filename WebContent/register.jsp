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
	if(request.getParameter("username")==null){
		//form should be outputted here
	}
	else{
		//process response 
		this.name = request.getParameter("username"); 
		this.email = request.getParameter("email"); 
		this.password = request.getParameter("password"); 
		String passwordR = request.getParameter("rpassword"); //retype the password
		boolean isDoctor = request.getParameter("usertype").equals(DOCTOR); 
		
		//validate the response
		boolean valid = true;
		
		//validate the name
		if(this.name == null || this.name.isEmpty()){
			valid = false; 
			this.nameError = "Name is invalid.";
		}
		//validate the email
		if(this.email == null || this.email.isEmpty() || !this.email.contains("@") || !this.email.contains(".com")){
			this.emailError = "Email is invalid.";
			valid = false; 
		}
		//validate the password 
		if(this.password == null || this.password.isEmpty() || passwordR == null || passwordR.isEmpty() || this.password.equals(passwordR)){
			this.passwordError = "The password you entered is invalid OR the passwords do not match"; 
			valid = false; 
		}
		
		if(valid){	//if valid continue to input the user data into the database
			java.sql.Connection conn; //connection to the database
			Statement query; //query to insert the new person into the database
 		
			//not sure what these things do 
			Context cunt = new InitialContext(); 
			DataSource powerSource = (DataSource) cunt.lookup("java:comp/env/jdbc/test"); // this is this right thing - it refers to Context.xml			
			conn = powerSource.getConnection(); //gets the connnection
			query = conn.createStatement(); // create the querier thingy
			query.executeQuery("INSERT INTO users VALUES ('" + this.email + "', 0, '" + this.name + "', '" + this.password + "', '');");
			
			if(isDoctor){ //the user is applying to be a doctor 
				query.executeQuery("INSERT INTO doctor VALUES ('', '0', " + this.email + "');");  //insert doctor table
			}
			else{ //the user is a filthy casual 
				query.executeQuery("INSERT INTO casual VALUES ('', " + this.email + "');"); //insert into filthy casual table
			}
		}
		else{ //else redraw the form showing the errors
			
		}
	}


%>
</body>
</html>