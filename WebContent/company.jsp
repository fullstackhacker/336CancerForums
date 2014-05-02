<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Company Page</title>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function()
	    {

	    jQuery("#list10").jqGrid({

	        url:'companyGridData.jsp',
	    colNames:['company Id','Name', 'Address'],
	        colModel:[{name:'companyId',index:'companyId', width:55},{name:'name',index:'name', width:90},{name:'address',index:'address', width:100}],
	    rowNum:10,
	    rowList:[5,7,10],
	    pager: '#pager10',
	    sortname: 'companyId',
	        datatype: 'json',
	        viewrecords: true,
	        sortorder: "desc",
	    multiselect: false,
	    loadonce: true,
	    caption: "Companies"
	        });

	    jQuery("#list10").jqGrid('navGrid','#pager10',{add:false,edit:false,del:false});

	     }//function
	    );//ready 
</script>
</head>
<body>
 <jsp:include page="header.jsp" flush="true" />
<%
if(session.getAttribute("userId")==null){ //user is not logged in 
	response.sendRedirect("loginform.jsp"); 
}
 
//user is logged in 

//user attributes
Integer userId = (Integer)session.getAttribute("userId"); 
String username = (String)session.getAttribute("username"); 
String firstname = (String)session.getAttribute("firstname"); 
String lastname = (String)session.getAttribute("lastname"); 
String email = (String)session.getAttribute("email");
boolean isDoc = session.getAttribute("isDoc") != null && ((String)session.getAttribute("isDoc")).equals("yes"); 
Integer votes = (Integer)session.getAttribute("votes");

if(isDoc) out.println("isDoc"); 
else out.println("!isDoc"); 

%>
<table id="companyGrid"></table>

 <div id="company_form">
 <form name="companyCreate" method="post" onsubmit="return validateForm()" action="companyInsert.jsp">
   <fieldset>
     <input type="text" name="companyName" id="companyName" size="30" placeholder="Company Name" class="text-input" /> 
     <br/>
     <input type="text" name="companyAddress" id="companyAddress" size="30" placeholder="Company Address" class="text-input" />
     <br/>
   	<br />
     <input type="submit" name="createCompany" class="button" id="createCompany_btn" value="Create Company" />
   </fieldset>
 </form>
</div>

</body>
</html>