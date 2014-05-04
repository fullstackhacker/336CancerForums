<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ad Image Uploading Form</title>
<!-- stylesheets -->
<link rel="stylesheet" type="text/css" href="global.css">
<!-- jquery script -->
<script src="jquery-2.1.0.min.js"></script>
</head>
<body>
 <jsp:include page="header.jsp" flush="true" />
<h3>File Upload:</h3>
Select a file to upload: <br />
<form action="uploadAd.jsp" method="post" enctype="multipart/form-data">
<input type="file" name="file" size="50" />
<br />
<select>
<option value=1>lung</option>
<option value=2>stomach</option>
<option value=3>bowel</option>
<option value=4>prostate</option>
<option value=5>breast</option>
<option value=6>other</option>
</select>
<br />
<input type="submit" value="Upload File" />
</form>
</body>
</html>