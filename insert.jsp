<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%

	request.setCharacterEncoding("UTF-8");

	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	String type = request.getParameter("type");
	
	String regdate = request.getParameter("regdate");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/webdefinder?useUnicode=true&characterEncoding=utf-8","root","apmsetup");

		out.println("데이터 베이스로 연결했습니다.");

		Statement stmt = conn.createStatement();
		String sql = "INSERT INTO jobs" + "(idx, title, writer, regdate, clicknum, content,file, type)" + "VALUES("+ null +", '"+ title +"', '"+ writer +"', '"+ regdate +"', '0', '"+ content +"','" + null +"', '"+ type +"')";
		stmt.executeUpdate(sql);
		
		conn.close();

		response.sendRedirect("index.jsp");
		
	}catch(Exception ignored){
		out.println("데이터베이스에 연결할 수 없습니다. <hr>");
		out.println(ignored.getMessage());
		ignored.printStackTrace();
	}
	
	
%>