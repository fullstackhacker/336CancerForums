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
<style rel="stylesheet" type="text/css" href="global.css"></style>
<style rel="stylesheet" type="text/css" href="profile.css"></style>
<title>336 is Cancer | User Profile</title>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<!-- Profile form; the user can update any information except username and type (doctor or patient) -->
<div id="profile">
 <form name="profile method="post" onsubmit="return validateForm()" action="profile.jsp">
   <fieldset>
     <label type="text" name="register">Create a New Account</label><br><br/>
     <input type="text" name="username" id="username" size="30" <% %> class="text-input" /><p class="error"><%= this.usernameError %></p>
     <br/>
     <input type="password" name="password" id="password" size="30" placeholder="New Password" class="text-input" /><p class="error"><%= this.passwordError %></p>
     <br/>
     <input type="password" name="confirm password" id="password" size="30" placeholder="Confirm New Password" class="text-input" /><p class="error"><%= this.cpasswordError %></p>
     <br/>
     <input type="text" name="firstname" size="30" <%if(this.fname.equals("")) out.print("placeholder=\"First Name\""); else out.print("value=\"" + this.fname + "\""); %> class="text-input"><p class="error"><%= this.fnameError %></p>
     <br/>
     <input type="text" name="lastname" size="30" <%if(this.lname.equals("")) out.print("placeholder=\"Lastname\""); else out.println("value=\"" + this.lname + "\""); %> class="text-input"><p class="error"><%= this.lnameError %></p>
     <br/>
     <input type="email" name="email" size="30"  <% if(this.email.equals("")) out.print("placeholder=\"Email\""); else out.print("value=\"" + this.email + "\""); %> class="text-input"><p class="error"><%= this.emailError %></p>
     <br/>
     <br/>
     <label type="text" name="areyoua">I am a:</label><p class="error" ><%= "  " + this.usertypeError %></p></br>
     <input type="radio" name="type" value="doc" /> Doctor </br>
	 <input type="radio" name="type" value="casual" /> Casual </br> 
	 <br />
     <input type="submit" name="Update" class="button" id="update_btn" value="Save Changes" />
   </fieldset>
 </form>
 </div>
 

</body>
</html>