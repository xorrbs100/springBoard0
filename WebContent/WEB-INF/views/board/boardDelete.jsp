<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>

</head>
<script type="text/javascript">
	var delCnt = ${delCnt}
	 if(delCnt>0){
		alert("���� �Ǿ����ϴ�")
		location.href = "/board/boardList.do?pageNo=1";
	}
	else{
		alert("�̹� ������ ���Դϴ�")
		location.href="/board/boardList.do?pageNo=1";
	} 
	
</script>
<body>
<form class="boardDelete">
	
	<!-- <a href="/board/boardList.do">�̹� ������ �� �Դϴ� List�� ����</a> -->

	
</form>	
</body>
</html>