<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>    

<%
	Connection conn = null;
	Statement stmt = null;
	
	String idx = request.getParameter("idx");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/webdefinder?useUnicode=true&characterEncoding=utf-8","root","apmsetup");
		
		if(conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
		
		//조회수 증가
		stmt.executeUpdate("update jobs set clicknum = clicknum +1 where idx =" + idx);
		
		ResultSet rs = stmt.executeQuery("select * from jobs where idx =" + idx);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link href="https://fonts.googleapis.com/css?family=Saira+Semi+Condensed" rel="stylesheet">
  <link href="maincss.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JOBS_구인/구직</title>

<script type="text/javascript">
	

	function deletePage(idx){ //글 삭제
		if(confirm("정말 글을 삭제하시겠습니까?")==true){
			location.href= "delete.jsp?idx=" + idx;
		}
	};
	
	function goboard(){ //목록버튼
		location.href = "index.jsp";
	}
	
    function button(e){ //버튼 색 change
        e.style.background="#EAD5DA";
        e.onmouseout = function(){
           e.style.background="#eee";
        }
     }
</script>

<style>
	#group_of_buttons {
		margin-top: 24px;
		margin-bottom: 20px;
	}
	
	.change_buttons {
		cursor: pointer;
		border: none;
		font-size: 13px;
		font-family: 'Jeju Gothic';
		padding: 8px 15px 8px 15px;
		background-color: #eee;
	}
	
	.content_pack{
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}
	
	.content_table{
		margin-top:60px;
		font-size:13px;
		border-collapse: collapse;
	}
	
	.table_td{
		padding-left:20px;
		font-size:12px;
	}
	.title{
		text-align:center;
		width:900px;
		height:50px;
		border-bottom: 2px solid #eee;
		font-size:1.5em	;
		padding-bottom:20px
	}
	.content{
		padding:20px;
		margin:0;
		font-size:12px;
		font-size:13px;
	}
	
	.table_info{
		border-bottom: 1px solid #eee;
	}
</style>
</head>


<body>
<div id="wrap">
	<div id="header">
		<div id="menu">
		<p id="nav_title"><a href="main.html" >웹디파인더</a></p>
		<ul id="nav">
		<li class="nav_item"><a href="discover.html">DISCOVER</a></li>
		<li class="nav_item"><a href="index.jsp">JOBS</a></li>
		<li class="nav_item"><a href="faq.html">FAQ</a></li>
		</ul> 
		</div> <!-- menu -->
		</div> <!-- header --> 


<div class="content_pack">		
<%
		while(rs.next()){
%>	
	
	
	<div>
		<table class="content_table">
		
			<tr height="30"  >
				<th class="title" colspan="10"><%=rs.getString("title")%></th>
			</tr>
			
			<tr height="30" style="border-bottom:1px solid #eee">
				<td class="table_td" align="left"><%= rs.getString("type") %></td>
				<td class="table_td" align="right"><%= rs.getString("regdate") %></td>
				<td class="table_td" align="right" width="80" style="padding-right:20px"><%= rs.getString("writer") %> </td>
			</tr>


			<tr class="talbe_content"> <!--  -->
				<td class="content" ><%= (rs.getString("content")).replace("\r\n","<br>") %></td>
			</tr>
			
			<tr height="1px"><td class="table_info" colspan="10"></td></tr>
		</table>
	</div>
	
	<div align="center" id="group_of_buttons">
	
		<button onmouseover="button(this);" class="change_buttons" type=button title="삭제" onClick="deletePage(<%= rs.getString("idx") %>);">삭제</button>
		<button onmouseover="button(this);" class="change_buttons" type=button title="목록" onClick="goboard();">목록</button>
		
	</div>
	
<%
		}
			conn.close();
	}catch(Exception e){
		out.println("데이터베이스에 문제가 있습니다.");
		out.println(e.getMessage());
		e.getStackTrace();
	}

%>
</div>
</div><!-- content -->

		<div id="footer">
			<h5>2017 웹디파인더 All rights reserved</h5>
		</div> <!-- footer --> 
		
</div><!-- warp -->
</body>
</html>