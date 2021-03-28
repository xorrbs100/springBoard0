<%@page import="java.io.PrintWriter"%>
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

	
	
	
	$j(document).ready(function(){
		/* $j('select[name=Type]').change(function(){
			$j('#boardType').val($j(this).val());
		}); */
		
		$j("#submit").on("click",function(){
			if($j("#boardTitle").val()==""){
				alert("������ �Է����ּ���");
			}else{
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("�ۼ��Ϸ�");
					
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
			}
		});
		
	});
	

</script>
<body>
<%

	String userId =null;
	String userName=null;
	if(session.getAttribute("ses")!=null){
		userId=(String)session.getAttribute("ses");
		userName=(String)session.getAttribute("name");
	}
	if(userId == null){	//userID�� null �϶�
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�α����� �ϼ���.')");
		script.println("location.href='/user/userLogin.do'");
		script.println("</script>");
		
	}
%>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="�ۼ�">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align ="center">
							Type
						</td>
						<td height="20">
							<select name=boardType size='1'>
								<c:forEach var="item" items="${comType}" varStatus="status">
									<option value="${item}">${comName[status.index]}</option>
								</c:forEach>
							</select>
							<%-- ${board.boardType}=$("select[name=Type]").val(); --%>
							
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" id="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						<%=userId %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
	<input type="hidden" value="<%= userId %>" name="creator">
</form>	
</body>
</html>