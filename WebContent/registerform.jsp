<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="regform.css">
<title>CS336: Cancer Forums</title>
</head>
<body>

<%! private String username = "";  %>
<%! private String email = ""; %>
<%! private String password = ""; %>
<%! private String cpassword = ""; %>
<%! private String fname = ""; %>
<%! private String lname = ""; %>
<%! private String emailError = ""; %>
<%! private String passwordError = ""; %>
<%! private String usernameError = ""; %>
<%! private String cpasswordError = ""; %>
<%! private String fnameError = ""; %>
<%! private String lnameError = ""; %>
<%! private String usertypeError = ""; %>
<%! private String myError = "";  %>

<%
boolean valid = true; 
if(request.getParameter("username")==null){
	out.println("set false cause user name was null"); 
	valid = false;
}

if(request.getParameter("username") != null && request.getParameter("username").isEmpty()){ 
	out.println("set false cause username was not null and empty"); 
	valid = false; 
	this.usernameError = "User Name cannot be empty."; 
}
else if(request.getParameter("username") != null && !request.getParameter("username").isEmpty()){
	this.username = request.getParameter("username"); 
}

if(request.getParameter("email") != null && request.getParameter("email").isEmpty()){ 
	out.println("set false cause email was not null and empty"); 
	valid = false; 
	this.emailError  = "Email cannot be empty";
}
else if(request.getParameter("email") != null && !request.getParameter("email").isEmpty()){
	this.email = request.getParameter("email"); 
	out.println("email: " + this.email);
}

if(request.getParameter("password") != null && request.getParameter("password").isEmpty()){ 
	out.println("set false cause password was not null and empty"); 
	valid = false;
	this.passwordError = "Password cannot be empty."; 
}
else if(request.getParameter(password) != null && !request.getParameter("password").isEmpty()){
	this.password = request.getParameter("password"); 
}

if(request.getParameter("confirm password") != null && (request.getParameter("confirm password").isEmpty() || !request.getParameter("confirm password").equals(request.getParameter("password")))){
	out.println("set false cause confirm password was not null and empty"); 
	valid = false; 
	this.cpasswordError = "Passwords must match";
}

if(request.getParameter("firstname") != null && request.getParameter("firstname").isEmpty()){ 
	valid = false; 
	this.fnameError = "First Name cannot be empty";
}
else if(request.getParameter("firstname") != null && !request.getParameter("firstname").isEmpty()){
	this.fname = request.getParameter("firstname"); 
}

if(request.getParameter("lastname") != null && request.getParameter("lastname").isEmpty()){ 
	valid = false; 
	this.lnameError = "Last Name cannot be empty";
}
else if(request.getParameter("lastname") != null && !request.getParameter("lastname").isEmpty()){
	this.lname = request.getParameter("lastname"); 
}

if(!(request.getParameter("type") != null && (request.getParameter("type").equals("doc") || request.getParameter("type").equals("casual")))){
	out.println("set face cause type was not doc or casual" + request.getParameter("type"));
	valid = false; 
	this.usertypeError = "Must pick a user type";
}

if((request.getParameter("username") != null || request.getParameter("email") != null || request.getParameter("password") != null || request.getParameter("confirm password") != null) && (request.getParameter("type") == null)){
	out.println("set false cause type was not picked and other stuff was filled in "); 
	valid = false; 
	this.usertypeError = "Must pick a user type"; 
}

if(valid){
	session.setAttribute("username", request.getParameter("username")); 
	session.setAttribute("email", request.getParameter("email")); 
	session.setAttribute("password", request.getParameter("password")); 
	session.setAttribute("firstname", request.getParameter("firstname")); 
	session.setAttribute("lastname", request.getParameter("lastname")); 
	if(request.getParameter("type").equals("doc")){ //user wants to register as a doctor
		session.setAttribute("isDoc", "yes"); 
	}
	else{
		session.setAttribute("isDoc", "no"); 
	}
	response.sendRedirect("register.jsp");
}

// user database attributes: first name, last name, email, updownVote(NULL), password, userName

%>

<div id="register_form">
 <form name="register" method="post" onsubmit="return validateForm()" action="registerform.jsp">
   <fieldset>
     <label type="text" name="register">Create a New Account</label><br><br/>
     <input type="text" name="username" id="username" size="30" <% if(this.username.equals("")) out.print("placeholder=\"Desired Username\""); else out.print("value=\"" + this.username + "\""); %> class="text-input" /><p class="error"><%= this.usernameError %></p>
     <br/>
     <input type="password" name="password" id="password" size="30" placeholder="Password" class="text-input" /><p class="error"><%= this.passwordError %></p>
     <br/>
     <input type="password" name="confirm password" id="password" size="30" placeholder="Confirm Password" class="text-input" /><p class="error"><%= this.cpasswordError %></p>
     <br/>
     <input type="text" name="firstname" size="30" <%if(this.fname.equals("")) out.print("placeholder=\"First Name\""); else out.print("value=\"" + this.fname + "\""); %> class="text-input"><p class="error"><%= this.fnameError %></p>
     <br/>
     <input type="text" name="lastname" size="30" <%if(this.lname.equals("")) out.print("placeholder=\"Lastname\""); else out.println("value=\"" + this.lname + "\""); %> class="text-input"><p class="error"><%= this.lnameError %></p>
     <input type="email" name="email" size="30"  <% if(this.email.equals("")) out.print("placeholder=\"Email\""); else out.print("value=\"" + this.email + "\""); %> class="text-input"><p class="error"><%= this.emailError %></p>
     <br/>
     <br/>
     <label type="text" name="areyoua">I am a:</label><p class="error" ><%= "  " + this.usertypeError %></p></br>
     <input type="radio" name="type" value="doc" /> Doctor </br>
	 <input type="radio" name="type" value="casual" /> Casual </br> 
	 <br />
     <input type="submit" name="register" class="button" id="reg_btn" value="Register" />
   </fieldset>
 </form>
 </div>
 
 <%= this.myError %>
</body>
</html>