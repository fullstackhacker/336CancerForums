<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%! private String email  = "";  //user's login email%>
<%! private String password = ""; //user's loginn password%>
<%! private String emailError = ""; //error on the user's email%>
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
<title>Cancer Forums</title>
</head>
<body>


<div id="login_form">
 <form name="contact" method="post" action="index.jps">
   <fieldset>
     <label for="username" id="username_label">Username:</label>
     <input type="text" name="username" id="username" size="30" value="" class="text-input" /></br>

     <label for="password" id="password_label">Password:</label>
     <input type="password" name="password" id="password" size="30" value="" class="text-input" /></br>
   	<br />
     <input type="submit" name="login" class="button" id="login_btn" value="Log In" />
   </fieldset>
 </form>
 </div>


<% 
	if(request.getParameter("email")==null){ //first page
		//draw form login form here
	}
	else{ //user submitted form 
		this.email = request.getParameter("email"); 
		this.password = request.getParameter("password"); 
		
		//check if the inputs are valids
		boolean valid = true; 
		
		//validate the email
		if(this.email == null || this.email.isEmpty() || !this.email.contains("@") || !this.email.contains(".com")){
			this.emailError = "Email is invalid.";
			valid = false; 
		}
		//validate the password
		if(this.password == null || this.password.isEmpty()){ 
			this.passwordError = "Password is emtpy.";
		}
		
		if(valid){ //the login input is valid, so try logging in. 
			java.sql.Connection conn; //connection to the database
			Statement query; //query to insert the new person into the database
 		
			//not sure what these things do 
			Context cunt = new InitialContext(); 
			DataSource powerSource = (DataSource) cunt.lookup("java:comp/env/jdbc/test"); // this is this right thing - it refers to Context.xml			
			
			conn = powerSource.getConnection(); //gets the connnection
			query = conn.createStatement(); // create the querier thingy
			
			ResultSet talkingBack = query.executeQuery("SELECT password FROM users WHERE users.email = '" + this.email + "';");				
			String testP = talkingBack.getString(1); //password to test against
			
			if(!this.password.equals(testP)){ //password is not valid
				//get out of the "valid" if statment... how though? 
			}
			
			//password is valid = gotta do the redirect here 
		}
		//redraw the form attaching the errors, doesn't need to be in an else because ^^ will login in the user 
	}
%>
</body>
</html>