<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page import="java.sql.*"%>


<%
	//DB연결
	Connection conn = null;
	Statement stmt = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost/webdefinder?useUnicode=true&characterEncoding=utf-8", "root",
				"apmsetup");

		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();

		ResultSet countrs = stmt.executeQuery("select count(*) from jobs;");
		//ResultSet : select 문 사용해 얻어온 레코드 값을 테이블의 형태로 만들어 주는 객체

		int count = 0;
		//count : 데이터의 총 개수
		if (countrs.next()) { //데이터를 한줄씩 읽어들임
			count = countrs.getInt(1);
		}

		ResultSet rs = stmt.executeQuery("select * from jobs order by idx desc;"); //정렬
%>


<!DOCTYPE html>
<html>
<head>
	<link
		href="https://fonts.googleapis.com/css?family=Saira+Semi+Condensed"
		rel="stylesheet">
	<link href="maincss.css" type="text/css" rel="stylesheet">
	
	<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
	<title>JOBS_구인/구직</title>
	
	<script type="text/javascript">
		//글 선택 -> 상세 페이지로 이동
		function goToDetail(idx) { //조회 페이지로 넘김
			location.href = "detail.jsp?idx=" + idx; //페이지 이동
		}
	
		function mouseover(e) {
			e.style.background = "#EAD5DA";
			e.onmouseout = function() {
				e.style.background = "white";
			}
		}
	
		function button() {
			writer_button.style.background = "#EAD5DA";
			writer_button.onmouseout = function() {
				writer_button.style.background = "#eee";
			}
		}
	</script>

	<style>
	@media ( max-width :479px) {
		#content {
			margin-left: 1em;
			margin-right: 1em
		}
	}
	
	@media ( min-width : 480px) and (max-width: 767px) {
		#content {
			margin-left: 3em;
			margin-right: 3em
		}
	}
	
	@media ( min-width : 768px) and (max-width: 1023px) {
		#content {
			margin-left: 4em;
			margin-right: 4em
		}
	}
	
	@media ( min-width : 1024px) {
		#content {
			margin-left: 5em;
			margin-right: 5em
		}
	}
	
	h2 {
		width: 100%;
		text-align: center;
		float: left;
		margin: 60px 0 30px 0
	}
	
	.content_board {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		width: 100%;
	}
	
	.content_table {
		margin-bottom: 30px;
		background: white;
		font-size: 13px;
		border-collapse: collapse;
	}
	
	#table_title {
		margin-left: 13%
	}
	
	th {
		font-size: 12px;
		color: #5D5D5D;
		border-bottom: 1px solid #eee;
	}
	
	#writer_button {
		cursor: pointer;
		border: none;
		font-size: 13px;
		font-family: 'Jeju Gothic';
		padding: 8px 15px 8px 15px;
		background-color: #eee;
	}
	
	.bottom_border{
		border-bottom: 1px solid #eee;
	}
	
	.total_count{
		text-align: right;
		font-size: 12px;
		font-family: 'Juju Gothic';
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

		<div id="content">
			<h2>JOBS</h2>
			<div class="content_board">
				
				<table class="content_table" >


					<!-- 수정전 -->
					<!-- <tr height="50">
						<th align="center" width="60">번호</th>
						<th align="center" width="100">구인/구직</th>
						<th align="center" width="300">제목</th>
						<th align="center" width="100">작성자</th>
						<th align="center" width="100">작성일</th>
						<th align="center" width="100">조회수</th>
					</tr> -->
					
					<!-- 수정_혜은언니 -->
					<tr height="40">
						<th align="center" width="40">번호</th>
						<th align="center" width="70">구인/구직</th>
						<th align="center" width="800"><span id="table_title">제목</span></th>
						<th align="center" width="60">작성자</th>
						<th align="center" width="100">작성일</th>
						<th align="center" width="50">조회수</th>
					</tr>


					<%
						int cnt = count + 1;
							if (count == 0) {
								out.print("<tr><td cospan='10'>데이터가 없습니다.</td></tr>");
							} else {
								while (rs.next()) {
									cnt--;
									out.print("<tr id='tr" + cnt
											+ "' onmouseover='mouseover(this)' height='35' style = 'cursor:pointer;' title='글 보기' onClick='goToDetail("
											+ rs.getString(1) + ")'>"); //누르면 detaile페이지로 넘어가도록 설정

									out.print("<td align='center'>" + cnt + "</td>");
									out.print("<td align='center' id='content_type'>" + rs.getString("type") + "</td>");
									out.print("<td>" + rs.getString(2) + "</td>");
									out.print("<td align='center'>" + rs.getString(3) + "</td>");
									out.print("<td align='center'>" + rs.getString(4) + "</td>");
									out.print("<td align='center'>" + rs.getString(5) + "</td>");

									out.print("</tr>");


								}
							}
					%>
				<tr height="1px"><td class="bottom_border" colspan="10"></td></tr>
				<tr><td class="total_count" colspan="10">총 게시글 : <%= count %></td></tr>
				</table>
					
				<!-- 수정전
				<div style="margin: 10px; padding-bottom: 15px;">
					<button id="writer_button" onmouseover="button();"
						style="cursor: pointer; background-color: rgb(0, 0, 0); border: none; color: white; padding: 15px 32px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px;"
						type="button" title="구인/구직 올리기"
						onclick="location.href='write.jsp'">구인/구직 올리기</button>
				</div> -->
				
				<!-- 수정_혜은언니 -->
				<div id="upload_button">
					<button id="writer_button" onmouseover="button();" type="button" title="구인/구직 올리기" onclick="location.href='write.jsp'">구인/구직 올리기</button>
				</div>

			</div>
		</div>
		<!-- content -->



		<%
			conn.close();
			} catch (Exception e) {
				out.println("데이터베이스에 문제가 있습니다.");
				out.println(e.getMessage());
				e.getStackTrace();
			}
		%>

		<div id="footer">
			<h5>2017 웹디파인더 All rights reserved</h5>
		</div>
		<!-- footer -->

	</div>
	<!-- wrap -->



</body>

</html>

