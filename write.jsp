
<!DOCTYPE html>
<html>
<title>JOBS_구인/구직 upload</title>
<head>
<link
	href="https://fonts.googleapis.com/css?family=Saira+Semi+Condensed"
	rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css"
	rel="stylesheet">
<link href="maincss.css" type="text/css" rel="stylesheet">

<style type="text/css">
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

#content {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

.write_titles {
	padding: 5px;
	font-size: 13px;
	margin-bottom: 10px;
	font-family: 'Jeju Gothic';
}

.write_option {
	padding: 5px 10px 3px 10px;
	font-size: 13px;
	margin-bottom: 10px;
	border: 1px #a9a9a9 solid;
	font-family: 'Jeju Gothic';
}

.write_content {
	font-family: 'Jeju Gothic';
	font-size: 13px;
	padding: 5px 0 0 5px
}

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

h2 {
	width: 100%;
	text-align: center;
	margin: 60px 0 30px 0
}

</style>
</head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
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

			<form name="writer_form" onsubmit="return form()">
				<input type="text" size="94" name="title" id="title" onchange="validate(this);" placeholder="제목" class="write_titles"><br> 
				<input type="text" size="39" name="writer" id="writer" placeholder="작성자" class="write_titles">
				<input type="text" size="40" name="regdate" id="regdate"  placeholder="작성일" class="write_titles" value="
					<%
                		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
               			String today = formatter.format(new java.util.Date());
                		out.println(today);
           			%>" readonly>
				<select name="type" class="write_option">
					<option value="구인">구인</option>
					<option value="구직">구직</option>
				</select> <br>
				<textarea rows="20" cols="94" name="content" id="content" onchange="validate(this);" placeholder="내용을 입력해주세요" class="write_content"></textarea>

				<div align="center" id="group_of_buttons">
					<button onmouseover="button(this);" type="submit" title="등록" class="change_buttons">등록</button>
					<button onmouseover="button(this);" type="button" title="취소" class="change_buttons" onClick="goback();">취소</button>
					<button onmouseover="button(this);" type="button" title="목록" class="change_buttons" onClick="goboard();">목록</button>
				</div>

			</form>

		</div>
		<!-- content -->

		<div id="footer">
			<h5>2017 웹디파인더 All rights reserved</h5>
		</div>
		<!-- footer -->

	</div>
	<!-- wrap -->


	<script type="text/javascript">  

          function form(){
			//빈칸입력 에러 잡기
	         var length = document.writer_form.length - 3;
             
             for(var i = 0; i < length; i++){
            	
                if(document.forms[0][i].value == null || document.forms[0][i].value == ""){
                   alert("빈칸을 채워주세요. [" + document.forms[0][i].name + "]");
                   document.forms[0][i].focus();
                   return false;
                }
             }
			 //넘기기
			 const send = () =>{
				
				let send_json = {
					title : document.getElementById('title').value,
					writer : document.getElementById('writer').value,
					content : document.getElementById('content').value
				}

				url = "aiaikasa.com/api/post"

				let http = WMLHTTPRequest();
				http.open('post',url,true)

				http.setRequestHeader('content-type',"application/json");

				http.onload = function(){
					if(http.readyState === http.DONE){
						if(http.status === 200){
							window.location.href = "index.html"
						}else{
							switch(http.response.code){
								case 0 :$console.log("title is empty");
							}
						}
					}
				}
				http.open();
			 }
             return true;
          }
          
          function goback(){ //취소버튼
             var r = confirm("글 작성을 취소하시겠습니까?");
             
             if(r == true)
                   location.href="index.jsp";
          }
          
          function goboard(){ //목록버튼
             alert("작성 된 글은 자동 취소됩니다.");
             
             location.href = "index.jsp";
          }
          
          
         function validate(e){ //입력 제어
            const baseRegex = /^[가-힣a-zA-Z]$/
            if(baseRegex.test(e.value)){
               alert('특수문자는 입력 할 수 없습니다!')
               e.value = "";
               return;
            }
         }
         
         function button(e){ //버튼 색 change
            e.style.background="#EAD5DA";
            e.onmouseout = function(){
               e.style.background="#eee";
            }
         }
	</script>
</body>
</html>