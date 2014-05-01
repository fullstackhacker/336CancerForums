<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%  
String emailError;
String passwordError;

if(session.getAttribute("emailError") == null) emailError = ""; 
else emailError = (String)session.getAttribute("emailError"); 
if(session.getAttribute("passwordError") == null) passwordError = ""; 
else passwordError = (String)session.getAttribute("passwordError"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="global.css">
<link rel="stylesheet" type="text/css" href="home.css">
<title>336 Beats Cancer | Log In</title>
</head>
<body>
<%


if(request.getParameter("username")!=null && request.getParameter("password") != null){
	session.setAttribute("username", request.getParameter("username")); 
	session.setAttribute("password", request.getParameter("password")); 
	response.sendRedirect("login.jsp");
}

%>
<div id="login_form">
 <form name="login" method="post" onsubmit="return validateForm()" action="loginform.jsp">
   <fieldset>
     <input type="text" name="username" id="username" size="30" placeholder="Username" class="text-input" /><%= emailError %> 
     <br/>
     <input type="password" name="password" id="password" size="30" placeholder="Password" class="text-input" /><%= passwordError %>
     <br/>
   	<br />
     <input type="submit" name="login" class="button" id="login_btn" value="Log In" />
     <br><p>Don't have an account?</p>
     <a href=registerform.jsp><input type="submit" name="reg" class="button" id="reg_btn" value="Register Now" /></a>
   </fieldset>
 </form>
</div>
</body>
</html>