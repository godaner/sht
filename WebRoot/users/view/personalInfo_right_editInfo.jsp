<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息编辑</title>
</head>
<body>
	<!-- 头部开始 -->
	
	<div class="head">
		<a href="#">基本资料</a><a href="./personal_right_editImg.jsp">头像照片</a>
		<hr />
	</div>
	<br/>
	
	<!-- 头部结束 -->
	
	<!-- 左侧开始 -->
	
	<div class="body_left">
  	<div><lable>我的昵称:</lable></td><td><input type="text" value="" placeholder="${onlineUser.username}"/></div>		
  	<br/>
  	<div><lable>性&nbsp;&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;:</lable>
  		男<input type="radio" name="sex" value="1"/>
  		女<input type="radio" name="sex" value="0"/>
  		保密<input type="radio" name="sex" value="-1" checked/>
  	</div>
  	<br/>
  	<div><lable id="mesg">我的描述:</lable><textarea>${onlineUser.description}</textarea></div>
  	</div>
  	
  	<!-- 左侧结束 -->
  	
  	<!-- 右侧开始 -->
  	<div class="body_right">
  		<div id="score">
  		<p>我的积分</p>
  		<p id="num"></p>
  		</div>
  		<input type="hidden" id="myscore" value="${onlineUser.score}"/>
  	</div>
  	<!-- 右侧结束 -->
  	<button id="save_btn">保存</button>
</body>


<style type="text/css">
.head {
	/* text-align:center; */
	font-size: 16px;
	color: grey;
}

.head a {
	margin-left: 90px;
	/* text-decoration:none; */
	color: grey;
}

input[type="text"] {
	border: solid 1px #8B8B83;
	 ​outline: none;
	border-radius: 3px;
	width: 350px;
}

textarea {
	border: solid 1px #8B8B83;
	​ outline: none;
	border-radius: 5px;
	width: 350px;
	height: 150px;
	resize: none;
}

lable {
	margin-right: 40px;
}

#mesg {
	float: left;
}
/* 保存按钮 */
#save_btn {
	width: 70px;
	height: 35px;
	margin-left: 40%;
	margin-top: 3%;
	border-radius: 5px;
	background-color: rgb(255, 219, 68);
	border: solid 1px rgb(255, 219, 68);
	font-size: 16px;
	cursor: pointer;
}
/* 积分显示 */
#score{
	/* border:solid 1px black; */
	width:249px;
	height:240px;
	position:absolute;
	left:500px;
	top:70px;
	background-color:#FCFCFC;
	box-shadow: 50px 50px 50px #FCFCFC;
	border-radius:70px;
}
#score p{
	margin-left:90px;
}

#num{
	color:green;
	font-size:40px;
	font-weight:bold;
	font-style: italic;
	text-shadow:2px 2px 2px green;
}
</style>
<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.animateNumber.min.js"></script>

<script type="text/javascript">
 var myscore = $("#myscore").val();
$('#num').animateNumber({ number: myscore },1500);

</script>

</html>