<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="net.sf.json.*" %>

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
	    	String selectStatement = " select customer.userId, user.userName, sum(transaction.total) as total from transaction, customer, user where customer.customerId = transaction.customerId and user.userId = customer.userId group by customer.userId;";
	    	rs = query.executeQuery(selectStatement);
	
	        int count=0;
	        rs.last();
	        count=rs.getRow(); 
	
	        int  pageval=0;
	        pageval=(count/Integer.parseInt(rows));
	
	        int limitstart=0;
	
	        limitstart=(Integer.parseInt(rows)*Integer.parseInt(pageno))-Integer.parseInt(rows);
	        int total=count/Integer.parseInt(rows);
	        String totalrow=String.valueOf(total+1);
	
	        rs = query.executeQuery("select customer.userId, user.userName, transaction.total from transaction, customer, user where customer.customerId = transaction.customerId and user.userId = customer.userId limit "+limitstart+","+rows);  
	
	        net.sf.json.JSONObject responsedata = new net.sf.json.JSONObject();
	        net.sf.json.JSONArray cellarray = new net.sf.json.JSONArray();
	        
	        responsedata.put("total",totalrow);
	        responsedata.put("page",cpage);
	        responsedata.put("records",count);

	        net.sf.json.JSONArray cell=new net.sf.json.JSONArray();
	        net.sf.json.JSONObject cellobj=new net.sf.json.JSONObject();
	
	        int i=1;
	       while(rs.next())
	           {
	                cellobj.put("userId",rs.getString(1));
	                cell.add(rs.getString(1));
	                cell.add(rs.getString(2));
	                cell.add(rs.getString(3));
	
	        cellobj.put("cell",cell);
	        cell.clear();
	        cellarray.add(cellobj);
	        i++;
	       }
	        responsedata.put("rows",cellarray);
	        out.println(responsedata);
        }
        catch(Exception e) {
        	System.out.print(e.toString());
        	out.println(e.toString());
        }
        finally {
        	conn.close();
        }
%>