<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
//connecting to the database
String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
Connection conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
Statement query = conn.createStatement(); //create the thing that will query the db
%>
<%
//get parameters

int type = -1, companyId = -1;

	String fileName = "noimage.jpg";
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>"); 
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
           	 	// Get the uploaded file parameters
           	 	String fieldName = fi.getFieldName();
            	fileName = fi.getName();
            	boolean isInMemory = fi.isInMemory();
            	long sizeInBytes = fi.getSize();
            	// Write the file
            	if( fileName.lastIndexOf("\\") >= 0 ){
            		file = new File( filePath + 
            		fileName.substring( fileName.lastIndexOf("\\"))) ;
           		}else{
            		file = new File( filePath + 
            		fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            	}
            	fi.write( file ) ;
            	
            	out.println("Uploaded Filename: " + filePath + fileName + "<br>");
           	 }
            else{ // our other two things 
            	if(fi.getFieldName().equals("companyId")){ 
            		companyId = Integer.parseInt(fi.getString());
            	}
            	if(fi.getFieldName().equals("topictype")){ 
            		type = Integer.parseInt(fi.getString()); 
            	}
            }
         }
         
         //end of while loop lets insert our shit in to the table
         String adInsertString = "INSERT INTO advertisement (adId, approved, imageLink, adType, companyId) VALUES (0, 0, \"" + fileName + "\", " + type + ", " + companyId + ");";
     	try{
     		query.executeUpdate(adInsertString);
     	}
     	catch(Exception e){
     		out.println(e.getMessage());
     		out.println(adInsertString); 
     		response.sendRedirect("index.jsp");
     		return; 
     	}
     	response.sendRedirect("adCreation.jsp");  
     	return;
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
   

%>