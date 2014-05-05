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
<title>Sales View</title>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<link rel="stylesheet" type="text/css" media="screen" href="jquery.jqGrid-4.6.0/css/ui.jqgrid.css" />
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="jquery.jqGrid-4.6.0/js/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="jquery.jqGrid-4.6.0/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function() {

	    jQuery("#salesGrid").jqGrid({
		    url:'salesGridData.jsp',
		    datatype: "json",
		    colNames:['Order Id','Date Ordered', 'Donation', "Customer Id", "Company Id"],
		    colModel:[
		              {name:'orderId',index:'orderId', width:55},
		              {name:'datetimeOrdered',index:'datetimeOrdered', width:90},
		              {name:'total',index:'total', width:90},
		              {name:'customerId',index:'customerId', width:90},
		              {name:'companyId',index:'companyId', width:100}],
		    rowNum:10,
		    rowList:[5,7,10],
		    pager: '#salesPager',
		    sortname: 'orderId',
		    //viewrecords: true,
		    //sortorder: "desc",
		    multiselect: false,
		    loadonce: true,
		    caption: "Sales"
	    });
	    jQuery("#salesGrid").jqGrid('navGrid','#salesPager',{add:false,edit:false,del:false});
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

%>

<br/>
<div id="jqGrid">
	<table id="salesGrid"></table>
	<div id="salesPager"></div>
</div>
<br/>

</body>
</html>