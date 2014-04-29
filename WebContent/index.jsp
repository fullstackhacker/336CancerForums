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
<style rel="stylesheet" type="text/css" href="global.css"></style>
<style rel="stylesheet" type="text/css" href="home.css"></style>
<title>336 is Cancer | Home</title>
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
 <form name="login" method="post" onsubmit="return validateForm()" action="index.jsp">
   <fieldset>
     <input type="text" name="username" id="username" size="30" placeholder="Username" class="text-input" /><%= emailError %> 
     <br/>
     <input type="password" name="password" id="password" size="30" placeholder="Password" class="text-input" /><%= passwordError %>
     <br/>
   	<br />
     <input type="submit" name="login" class="button" id="login_btn" value="Log In" />
   </fieldset>
 </form>
</div>
<% session.invalidate(); %>
<a href="registerform.jsp">REGISTER HERE</a>

<nav> 
<div class="topic" > 
topic1
</div>
<div class="topic">
topic2
</div>
<div class="topic">
topic3
</div>
<div class="topic">
Other
</div>
</nav>

</body>
</html>