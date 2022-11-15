<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="m-4 font-weight-bold">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<span class="sign-up-subject">ID</span>
			<div class="d-flex mt-2 ml-3">
				<input type="text" name="loginId" class="form-control col-6" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-info ml-3">중복확인</button>
			</div>
			<div class="ml-4 mt-1">
				<div id="idCheckLength" class="text-danger small d-none">ID를 4자 이상 작성해주세요.</div>
				<div id="idCheckDuplicated" class="text-danger small d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="text-success small d-none">사용 가능한 ID 입니다.</div>
			</div>
			<span class="sign-up-subject">password</span>
			<div class="ml-3 mt-1 mb-1">
				<input type="password" name="password" class="form-control col-4" placeholder="****">
			</div>
			<span class="sign-up-subject">confirm password</span>
			<div class="ml-3 mt-1 mb-2">
				<input type="password" name="confirmPassword" class="form-control col-4" placeholder="****">
			</div>
			<span class="sign-up-subject">이름</span>
			<div class="ml-3 mt-1 mb-2">
				<input type="text" name="name" class="form-control col-6" placeholder="이름을 입력해주세요">
			</div>
			<span class="sign-up-subject">이메일</span>
			<div class="ml-3 mt-1 mb-1">
				<input type="text" name="email" class="form-control col-6" placeholder="이메일을 입력해주세요">
			</div>
			<div class="d-flex justify-content-center mt-4">
				<button type="button" id="signUpBtn" class="btn btn-info">가입하기</button>
			</div>
		</form>
	</div>
</div>
<script>
$(document).ready(function() {
	$('#loginIdCheckBtn').on('click', function(e) {
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			return;
		}
		
		$.ajax({
			url:"/user/is_duplicated_id"
			, data:{"loginId":loginId}
			
			, success: function(data) {
				if (data.result == true) {
					$('#idCheckDuplicated').removeClass('d-none');
					$('#idCheckLength').addClass('d-none');
					$('#idCheckOk').addClass('d-none');
				} else {
					$('#idCheckOk').removeClass('d-none');
					$('#idCheckLength').addClass('d-none');
					$('#idCheckDuplicated').addClass('d-none');
				}
			} 
			, error: function(error) {
				alert("중복확인에 실패했습니다. 관리자에게 문의해 주세요.");
			}
		});
	});
	
	$('#signUpBtn').on('click', function(e) {
		e.preventDefault();
		
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		if ($('#idCheckOk').hasClass('d-none') == true) {
			alert("아이디 중복확인을 해주세요.");
			return;
		}
		
		var password = $('input[name=password]').val().trim();
		var confirmPassword = $('input[name=confirmPassword]').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		}
		
		var name = $('input[name=name]').val().trim();
		if (name == '') {
			alert("이름을 입력해주세요.")
			return;
		}
		
		var email = $('input[name=email]').val().trim();
		if (email == '') {
			alert("이메일을 입력해주세요.")
			return;
		}
		
		var url = $('#signUpForm').attr("action");
		var params = $('#signUpForm').serialize();
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다!!! 로그인을 해주세요.");				
				location.href="/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		});
	});
});















<%-- $(document).ready(function() {
	// 아이디 중복 확인
	$('#loginIdCheckBtn').on('click', function(e) {
		
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			return;
		}
		
		$.ajax({
			url:"/user/is_duplicated_id"
			, data:{"loginId": loginId}
		
			, success: function(data) {
				if (data.result == true) {
					$('#idCheckDuplicated').removeClass('d-none');
					$('#idCheckLength').addClass('d-none');
					$('#idCheckOk').addClass('d-none');
				} else {
					$('#idCheckOk').removeClass('d-none');
					$('#idCheckDuplicated').addClass('d-none');
					$('#idCheckLength').addClass('d-none');
				}
			}
			, error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.")
			}
		});
	});
	
	$('signUpBtn').on('click', function(e) {
		e.preventDefault();
		
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요.");
			return;
		}
		
		var password = $('input[name=password]').val().trim();
		var confirmPassword = $('input[name=confirmPassword]').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		}
		
		var name = $('input[name=name]').val().trim();
		if (name == '') {
			alert("이름을 입력하세요.");
			return;
		}
		
		var email = $('input[name=email]').val().trim();
		if (email == '') {
			alert("이메일을 입력하세요.");
			return;
		}
		
		if ($('#idCheckOk').hasClass('d-none') == true) {
			alert("ID를 다시 확인해주세요.");
			return;
		}
		
		var url = $('#signUpForm').attr("action");
		var params = $('#signUpForm').serialize();
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다!!! 로그인을 해주세요.");
				location.href="/user/sign_up_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.")
			}
		});
	});
}); --%>
</script>