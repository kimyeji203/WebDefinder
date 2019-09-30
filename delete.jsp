<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>   

<%
	String idx = request.getParameter("idx");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/webdefinder","root","apmsetup");

		Statement stmt = conn.createStatement();
		String sql = "delete from jobs where idx = " + idx;
		stmt.executeUpdate(sql);
		
		conn.close();
	}catch(Exception e){
		out.println("문제가 발생했습니다. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>

<script>
	alert("게시글이 삭제되었습니다.");
	location.href="redirect.jsp";
</script>
<html>
<body></body>
</html>