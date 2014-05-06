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
		              {name:'orderId',index:'orderId', width:90},
		              {name:'datetimeOrdered',index:'datetimeOrdered', width:90},
		              {name:'total',index:'total', width:90},
		              {name:'customerId',index:'customerId', width:90},
		              {name:'companyId',index:'companyId', width:90}],
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

<script type="text/javascript">
jQuery(document).ready(function() {

	    jQuery("#donationsGrid").jqGrid({
		    url:'donationPerCompany.jsp',
		    datatype: "json",
		    colNames:['Company Id','Donation Total','Company Name'],
		    colModel:[
		              {name:'companyId',index:'companyId', width:90},
		              {name:'donationTotal',index:'donationTotal', width:120},
		              {name:'name',index:'name', width:120}],
		    rowNum:10,
		    rowList:[5,7,10],
		    pager: '#donationsPager',
		    sortname: 'companyId',
		    //viewrecords: true,
		    //sortorder: "desc",
		    multiselect: false,
		    loadonce: true,
		    caption: "Donations"
	    });
	    jQuery("#donationsGrid").jqGrid('navGrid','#donationsPager',{add:false,edit:false,del:false});
	}//function
);//ready 
</script>

<script type="text/javascript">
jQuery(document).ready(function() {

	    jQuery("#userGrid").jqGrid({
		    url:'userDonation.jsp',
		    datatype: "json",
		    colNames:['User Id','User Name', 'Donation'],
		    colModel:[
		              {name:'userId',index:'userId', width:55},
		              {name:'userName',index:'userName', width:90},
		              {name:'total',index:'total', width:90}],
		    rowNum:10,
		    rowList:[5,7,10],
		    pager: '#userPager',
		    sortname: 'userId',
		    //viewrecords: true,
		    //sortorder: "desc",
		    multiselect: false,
		    loadonce: true,
		    caption: "User Donations"
	    });
	    jQuery("#userGrid").jqGrid('navGrid','#userPager',{add:false,edit:false,del:false});
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
<div id="salesjqGrid">
	<table id="salesGrid"></table>
	<div id="salesPager"></div>
</div>
<br/>

<br/>
<div id="donationjqGrid">
	<table id="donationsGrid"></table>
	<div id="donationsPager"></div>
</div>
<br/>

<br/>
<div id="userjqGrid">
	<table id="userGrid"></table>
	<div id="userPager"></div>
</div>
<br/>

</body>
</html>