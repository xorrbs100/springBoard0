<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userJoin</title>
</head>
<script>


		$j(document).ready(function(){
			
			var userName = document.querySelector('#userName');
			var userId= document.querySelector('#userId');
			var Pwchk = document.querySelector('#userPwchk');
			var postNo = document.querySelector('#userPostNo');
			var chkVal=function(){
				$j("#Idchk").val("N");
			}
			var onlyKorean = function(){
				var pattern =/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
				this.value = this.value.replace(pattern, '');
			};
			var englishNumber = function(){
				var pattern= /[^0-9^a-z^A-Z]/gi;
				this.value = this.value.replace(pattern, '');
				
			}
			var onlyNumber = function(){
				var pattern= /[^0-9|^-]/gi;
				this.value= this.value.replace(pattern,'');
			}
			var pswChk = function(){
				var userPw = $j("#userPw").val();
				var userPwchk = $j("#userPwchk").val();
				
				if(userPw==userPwchk){
					$j("#pwchk").val("��ġ");
				}
				else{
					$j("#pwchk").val("����ġ");
				}
				
			}
			var pswChknull=function(){
				var userPwchk = $j("#userPwchk").val();
				if(userPwchk==""){
					$j("#pwchk").val("���� �Է��ϼ���");
				}
			}
			var postNochk=function(){
				curMsg=$j("#userPostNo").val();
				if($j("#userPostNo").val().length==3){
					$j("#userPostNo").val(curMsg+"-");
				}
			}
			var maxLeng=function(){
				if($j("#userName").val().length>3){
					this.value=this.value.slice(0,3);
				}
			}
			
			Pwchk.addEventListener('keyup', pswChk);		
			Pwchk.addEventListener('focusout',pswChknull);
			userName.addEventListener('keyup', onlyKorean);
			userName.addEventListener('focusout',onlyKorean);
			userName.addEventListener('keyup',maxLeng);
			userName.addEventListener('focusout',maxLeng);
			userId.addEventListener('keyup', englishNumber);
			postNo.addEventListener('keyup', onlyNumber);
			postNo.addEventListener('keypress', postNochk);
			userId.addEventListener('keypress',chkVal);
			
			$j("#submit").on("click", function(){
				if($j("#userId").val()==""){
					alert("���̵� �Է����ּ���.");
					$j("#userId").focus();
					return false;
				}
				if($j("#userPw").val()==""){
					alert("��й�ȣ�� �Է����ּ���.");
					$j("#userPw").focus();
					return false;
				}
				var pwd1=$j("#userPw").val(); 
				var pwd2=$j("#userPwchk").val();
				
				if(pwd1.length<6){
					alert("��й�ȣ�� 6�ڸ� �̻�,12�ڸ������Դϴ�");
					$j("#userPw").focus();
					return false;
				}
				if(pwd2==""){
					alert("Pwchk�� �Է��� �ּ���");
					$j("#userPwchk").focus();
					return false;
				}
				if(pwd1==pwd2){
					$j("#userPwchk").disabled;
				}else{
					alert("��й�ȣ�� ���� �ʽ��ϴ�");
					$j("#userPwchk").focus();
					return false;
				}
				if($j("#userName").val()==""){
					alert("������ �Է����ּ���.");
					$j("#userName").focus();
					return false;
				}
				var userPhone2=$j("#userPhone2").val();
				var userPhone3=$j("#userPhone3").val();
				if(userPhone2==""){
					alert("�ڵ��� ��ȣ�� �Է����ּ���.");
					$j("#userPhone2").focus();
					return false;
				}
				if(userPhone2.length<4){
					alert("4�ڸ� ��ȣ�� �Է��� �ּ���");
					$j("#userPhone2").focus();
					return false;
				}
				if(userPhone3==""){
					alert("�ڵ��� ��ȣ�� �Է����ּ���.");
					$j("#userPhone3").focus();
					return false;
				}
				if(userPhone3.length<4){
					alert("4�ڸ� ��ȣ�� �Է��� �ּ���");
					$j("#userPhone3").focus();
					return false;
				}
				var idChkVal = $j("#Idchk").val();
				if(idChkVal == "N"){
					alert("�ߺ�Ȯ�� ��ư�� �����ּ���.");
					$j("#userId").focus();
					return false;
				}else if(idChkVal=="Y"){
					var ser = $j('form').serialize();
					$j('form').val()=ser;
				} 
				
			})
		})
		
		function idChk(){
			if($j("#userId").val()==""){
				alert("���̵� �Է��ϼ���");
				$j("#userId").focus();
			}else{
			$j.ajax({
				url : "/user/idChk.do",
				type : "post",
				dataType : "json",
				data : {"userId" : $j("#userId").val()},
				success : function(data){
					if(data == 1){
						alert("�ߺ��� ���̵��Դϴ�.");
						$j("#userId").focus();
					}
					if(data == 0){
						$j("#Idchk").val("Y");
						alert("��밡���� ���̵��Դϴ�.");
						$j("#userPw").focus();
						
					}
				}
			})
			}
		}
		function maxlength(object){
			if(object.value.length>4){
				object.value=object.value.slice(0,4);
			}
		}
		/* function insertChk(){
			var resCnt = ${resultCnt};
			if(resCnt==0){
				alert("ȸ������ ����");
			}
			if(resCnt<=1){
				alert("ȸ������ ����");
				location.href='/user/userLogin.do';
			}
		} */
		
	</script>
<body>
<form action="/user/userJoinAction.do" method="post" name="userInfo" id="userInfo" >
	<table align="center">
				
		<tr>

			<td>Id</td>
			<td><input type="text" id="userId" name="userId" maxlength="12" placeholder="����,���� �ִ�12��" ></td>
			<td><button class="Idchk" type="button" id="Idchk" value="N" onclick=idChk(); > �ߺ�Ȯ��</button></td>
		</tr>
		<tr>
			<td>Pw</td>
			<td><input type="password" id="userPw" name="userPw" maxlength="12"></td>
		</tr>
		<tr>
			<td>PwCheck</td>
			<td><input type="password" id="userPwchk" ></td>
			<td><input type="text" size="6" disabled id="pwchk" value="���� �Է��ϼ���"></td>
		</tr>
		<tr>
			<td>Name</td>
			<td><input type="text" id="userName" name="userName"  maxlength="3" ></td>
		</tr>
		<tr>
			<td>Phone</td>
			<td width='30'>
				<select id="userPhone1" name="userPhone1">
					<c:forEach var="item" items="${list}">
						<option>${item}</option>
					</c:forEach>
				</select>-
			</td>
			<td>
			<input type="number" class="userPhone" id="userPhone2" name="userPhone2" oninput="maxlength(this)">-
			</td>
			<td>
			<input type="number" class="userPhone" id="userPhone3" name="userPhone3" oninput="maxlength(this)">
			</td>
		</tr>
		<tr>
			<td>PostNo</td>
			<td><input type="text" id="userPostNo" name="userPostNo" maxlength="7" placeholder="xxx-xxx" pattern="\d{3}-\d{3}" value="123-123"></td><td>ex) xxx-xxx</td>
<!-- 			<td><input type="text" id="userPostNo" name="userPostNo" maxlength="7" placeholder="xxx-xxx" pattern="\d{3}-\d{3}"></td><td>ex) xxx-xxx</td> -->
		</tr>
		<tr>
			<td>Address</td>
			<td><input type="text" id="userAddress" name="userAddress" maxlength="37"></td>
		</tr>
		<tr>
			<td>Company</td>
			<td><input type="text" id="userCompany" name="userCompany" maxlength="15"></td>
		</tr>
		<tr>
			<td align="right">
			<input type="submit" id="submit" name="submit" value="����">
		</tr>
	
	</table>
	</form>
</body>
</html>