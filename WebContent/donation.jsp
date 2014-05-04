<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Donation to company</title>
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp" flush="true" />

 <div id="donation_form">
 <form name="donation" method="post" action="donationInsert.jsp">
   <fieldset>
     <input type="text" name="creditCardNum" id="creditCardNum" size="30" placeholder="Credit Card Number" class="text-input" /> 
     <br/>
     <input type="text" name="address" id="address" size="30" placeholder="Address" class="text-input" />
     <br/>
     <input type="text" name="donationAmt" id=""donationAmt"" size="30" placeholder="Amount" class="text-input" />
     <br/>
   	<br />
     <input type="submit" name="donate" class="button" id="donate_btn" value="Donate" />
   </fieldset>
 </form>
</div>

</body>
</html>