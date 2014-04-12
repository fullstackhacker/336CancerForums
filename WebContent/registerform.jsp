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
<%! private String emailError = ""; %>
<%! private String passwordError = ""; %>
<%! private String usernameError = ""; %>
<%! private String cpasswordError = ""; %>
<%! private String usertypeError = ""; %>

<%
boolean valid = true; 
if(request.getParameter("username")==null){
	valid = false;
}

if(request.getParameter("username") != null && request.getParameter("username").isEmpty()){ 
	valid = false; 
	this.usernameError = "User Name cannot be empty."; 
}

if(request.getParameter("email") != null && request.getParameter("email").isEmpty()){ 
	valid = false; 
	this.emailError  = "Email cannot be empty";
}

if(request.getParameter("password") != null && request.getParameter("password").isEmpty()){ 
	valid = false;
	this.passwordError = "Password cannot be empty."; 
}

if(request.getParameter("confirm password") != null && (request.getParameter("confirm password").isEmpty() || !request.getParameter("confirm password").equals(request.getParameter("password")))){
	valid = false; 
	this.cpasswordError = "Passwords must match";
}

if(request.getParameter("type") != null && (request.getParameter("type").equals("doc") || request.getParameter("type").equals("casual"))){
	valid = false; 
	this.usertypeError = "Must pick a user type";
}

if(valid){
	session.setAttribute("username", request.getParameter("username")); 
	session.setAttribute("email", request.getParameter("email")); 
	session.setAttribute("password", request.getParameter("password")); 
	if(request.getParameter("type").equals("doc")){ //user wants to register as a doctor
		session.setAttribute("isDoc", "yes"); 
	}
	else{
		session.setAttribute("isDoc", "no"); 
	}
	response.sendRedirect("register.jsp");
}

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
     <input type="email" name="email" size="30"  <% if(this.email.equals("")) out.print("placeholder=\"Enter your email\""); else out.print(this.email); %> class="text-input"><p class="error"><%= this.emailError %></p>
     <br/>
     <br/>
     <label type="text" name="areyoua">I am a:</label><p class="error" ><%= "  " + this.usertypeError %></p></br>
     <input type="radio" name="type" value="doc" /> Doctor </br>
	 <input type="radio" name="type" value="pat" /> Casual </br> 
	 <br />
     <input type="submit" name="register" class="button" id="reg_btn" value="Register" />
   </fieldset>
 </form>
 </div>
</body>
</html>