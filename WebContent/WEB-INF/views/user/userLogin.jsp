<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
<script type="text/javascript">
	var idC=${resultId}
	var pwC=${resultPw}
	
	if(idC==0&&pwC==0){
		alert("id�� pw�� Ȯ���ϼ���");
		location.href="/user/userLogin.do";
	}else if(idC==0&&pwC==1){
		alert("id�� Ȯ���ϼ���");
		location.href="/user/userLogin.do";
	}else if(idC==1&&pwC==0){
		alert("pw�� Ȯ���ϼ���");
		location.href="/user/userLogin.do";
	}else if(idC==1&&pwC==1){
		alert("�α��� �Ǿ����ϴ�.")
		location.href="/board/boardList.do";
	}
	  
</script>
</head>

<script type="text/javascript">
	var resultCnt=${resultCnt};
	if(resultCnt=!null){
		alert("ȸ�����ԿϷ�");
	}
</script>
<body>
<script type="text/javascript">
	$j(document).ready(function(){
		$j("userId").focus;
		$j("#submit").on("click", function(){
			if($j("#userId").val()==""){
				alert("id�� �Է��� �ּ���")
				$j("userId").focus;
				return false;
			}
			if($j("#userPw").val()==""){
				alert("pw�� �Է��� �ּ���")
				$j("userId").focus;
				return false;
			}
		})
	})

</script>
<form name="userLogin" action="/user/userLoginAction.do" method="post">
<table align="center" border='1'>
	
	<tr>
		<td width='100'>ID</td>
		<td width='300'><input type="text" id="userId" name="userId"></td>
	</tr>
	
	<tr>
		<td>PW</td>
		<td><input type="password" id="userPw" name="userPw"></td>
		<td><input type="submit" id="submit" value="Ȯ��"></td>
	</tr>
</table>
<center>
		
		<a href="/user/userJoin.do">ȸ������</a>
		<br>
		<!-- ���̹� �α��� â���� �̵� -->
		<div id="naver_id_login" style="text-align:center"><a href="${url}">
		<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
		<br>
		
</center>

</form>
</body>
</html>