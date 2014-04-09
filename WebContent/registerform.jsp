<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%! private String username = "";  %>
<%! private String email = ""; %>
<%! private String emailError = ""; %>
<%! private String passwordError = ""; %>
<%! private String usernameError = ""; %>

<%
if(request.getParameter("username") != null && request.getParameter("email") != null && request.getParameter("password") != null && !request.getParameter("email").isEmpty() && !request.getParameter("username").isEmpty() && !request.getParameter("password").isEmpty()){ 
	session.setAttribute("username", request.getParameter("username")); 
	session.setAttribute("email", request.getParameter("email")); 
	session.setAttribute("password", request.getParameter("password")); 
	//session.setAttribute("isDoc", request.getParameter("doc")); 
	response.sendRedirect("register.jsp");
}

if(request.getParameter("username") != null && request.getParameter("username").isEmpty()){ 
	
}

if(request.getParameter("email") != null && request.getParameter("email").isEmpty()){ 
	
}

if(request.getParameter("password") != null && request.getParameter("password").isEmpty()){ 
	
}

%>

<div id="register_form">
 <form name="register" method="post" onsubmit="return validateForm()" action="registerform.jsp">
   <fieldset>
     <label type="text" name="register">Create a New Account</label></br></br>
   
     <input type="text" name="username" id="username" size="30" <% if(this.username.equals("")) out.print("placeholder=\"Desired Username\""); else out.print("value=\"" + this.username + "\""); %> class="text-input" />
     </br>
     <input type="password" name="password" id="password" size="30" placeholder="Password" class="text-input" />
     </br>
     <input type="password" name="confirm password" id="password" size="30" placeholder="Confirm Password" class="text-input" />
     </br>
     <input type="email" name="email" size="30"  placeholder="Enter your email">
     </br>
     </br>
     <label type="text" name="areyoua">I am a:</label></br>
     <input type="radio" name="type" value="doc" /> Doctor </br>
	 <input type="radio" name="type" value="pat" /> Patient </br>
     
     
   	<br />
     <input type="submit" name="register" class="button" id="reg_btn" value="Register" />
   </fieldset>
 </form>
 </div>
</body>
</html>