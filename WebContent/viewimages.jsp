<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String imagesFolder = "/usr/local/tomcat-archive/apache-tomcat-6.0.24/webapps/336CancerForums/images";
File dir = new File(imagesFolder); 

String list[] = dir.list(); 

for(int i = 0; i<list.length; i++){ 
	out.println("image: --> " + list[i]); 
}

%>
</body>
</html>