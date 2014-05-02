<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>

<%
        String rows=request.getParameter("rows");

        String pageno=request.getParameter("page");
        String cpage=pageno;

        Connection conn = null;
        Statement query = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs= null;
        
	    try{
	    	String mysqldb = "jdbc:mysql://cs336-3.cs.rutgers.edu:3306/cancerforum"; //connection string 
	    	Class.forName("com.mysql.jdbc.Driver"); //loading the driver 
	    	conn = DriverManager.getConnection(mysqldb, "csuser", "csd64f12"); //connect to db
	    	query = conn.createStatement(); //create the thing that will query the db
	    	String insertStatement = "SELECT companyId,name,address FROM company";
	    	rs = query.executeQuery(insertStatement);
	
	        int count=0;
	        rs.last();
	        count=rs.getRow(); 
	
	        int  pageval=0;
	        pageval=(count/Integer.parseInt(rows));
	
	        int limitstart=0;
	
	        limitstart=(Integer.parseInt(rows)*Integer.parseInt(pageno))-Integer.parseInt(rows);
	        int total=count/Integer.parseInt(rows);
	        String totalrow=String.valueOf(total+1);
	
	        rs = query.executeQuery("SELECT companyId,name,address FROM company limit "+limitstart+","+rows);  
	
	
	        JSONObject responcedata = new JSONObject();
	        JSONArray cellarray = new JSONArray();
	
	         responcedata.put("total",totalrow);
	        responcedata.put("page",cpage);
	        responcedata.put("records",count);
	
	        JSONArray cell=new JSONArray();
	        JSONObject cellobj=new JSONObject();
	
	        int i=1;
	       while(rs.next())
	           {
	                cellobj.put("companyId",rs.getString(1));
	                cell.add(rs.getString(1));
	                cell.add(rs.getString(2));
	                cell.add(rs.getString(3));
	
	        cellobj.put("cell",cell);
	        cell.clear();
	        cellarray.add(cellobj);
	        i++;
	       }
	        responcedata.put("rows",cellarray);
	        out.println(responcedata);
        }
        catch(Exception e) {
        	
        }
        finally {
        	conn.close();
        }

%>