<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center">
	<div class="contents-box">
		<%-- 글쓰기 영역 --%>
		<%-- 로그인 된 사람만 보이게 조건 --%>
		<c:if test="${not empty userId}">
		<div class="write-box border rounded m-3">
			<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
				
			<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
			<div class="d-flex justify-content-between">
				<div class="file-upload d-flex">
					<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
					<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
					<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
					<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>

					<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
					<div id="fileName" class="ml-2">
					</div>
				</div>
				<button id="writeBtn" class="btn btn-info">게시</button>
			</div>
		</div>
		</c:if>
		<%--// 글쓰기 영역 끝 --%>
		
		<%-- 타임라인 영역 --%>
		<div class="timeline-box my-5">
			<c:forEach items="${cardList}" var="card">
			<%-- 카드1 --%>
			<div class="card border rounded mt-3">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="p-2 d-flex justify-content-between">
					<span class="font-weight-bold">${card.user.loginId}</span>
					<%-- 내가 쓴 글일 때만 더보기 노출 --%>
					<c:if test="${userId eq card.user.id}">
					<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
						<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
					</a>
					</c:if>
				</div>
				
				<%-- 카드 이미지 --%>
				<div>
					<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
				</div>
				
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#" class="like-btn" data-user-id="${userId}" data-post-id="${card.post.id}">
						<img src="https://www.iconninja.com/files/527/809/128/heart-icon.png" width="18px" height="18px" alt="filled heart">
						<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18px" height="18px" alt="empty heart">
						좋아요 10개
					</a>
				</div>
				
				<%-- 글 --%>
				<div class="card-post m-3">
					<span class="font-weight-bold">${card.user.loginId}</span>
					<span>${card.post.content}</span>
				</div>
				
				<%-- 댓글 --%>
				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				<div class="card-comment-list m-2">
					<%-- 댓글 목록 --%>
					<c:forEach items="${card.commentList}" var="commentView">
					<div class="card-comment m-1">
						<span class="font-weight-bold">${commentView.user.loginId}:</span>
						<span>${commentView.comment.content}</span>
						
						<%-- 댓글 삭제 버튼 --%>
						<a href="#" class="commentDelBtn">
							<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
						</a>
					</div>
					</c:forEach>
					<%-- 댓글 쓰기 --%>
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
						<button type="button" class="comment-btn btn btn-light" data-post-id="${post.id}">게시</button>
					</div>
				</div>
			</div> <%--// 카드1 닫기 --%>
			</c:forEach>
		</div> <%--// 타임라인 영역 닫기  --%>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="modal">
	<%-- modal-dialog-centered: 모달창을 수직 가운데 정렬, modal-sm: 작은 모달창 --%>
	<div class="modal-dialog modal-dialog-centered modal-sm">
		<div class="modal-content">
      		<%-- 모달 창 안에 내용 넣기 --%>
      		<div class="text-center">
      			<div class="py-3 border-bottom">
      				<a href="#" id="delPostBtn">삭제하기</a>
      			</div>
      			<div class="py-3">
      				<%-- data-dismiss="modal" 모달창 닫힘 --%>
      				<a href="#" data-dismiss="modal">취소</a>
      			</div>
      		</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	// 파일 업로드 이미지(a) 클릭 => 파일 선택 창이 떠야함
	$('#fileUploadBtn').on('click', function(e) {
		e.preventDefault();	// a태그의 기본 동작 멈춤(화면이 위로 올라가는 것 방지)
		$('#file').click(); // input file의 클릭한 것과 같은 효과
	});
	
	// 사용자가 파일업로드를 했을 때, 유효성 확인 및 업로드 된 파일 이름 노출
	$('#file').on('change', function(e) {
		// alert("체인지");
		
		let fileName = e.target.files[0].name; // ex) cat-g4c8e76014_640.jpg
		// alert(fileName);
		let ext = fileName.split('.').pop().toLowerCase();
		
		// 확장자 유효성 확인
		if (fileName.split('.').length < 2 ||
				(ext != 'gif'
						&& ext != 'png'
							&& ext != 'jpg'
								&& ext != 'jpeg')) {
			alert("이미지 파일만 업로드 할 수 있습니다.");
			$(this).val(''); // 파일 태그에 실제 파일 제거
			$('#fileName').text(''); // 파일 이름 비우기
			return;
		}
		
		// 상자에 업로드 된 이름 노출
		$('#fileName').text(fileName);
	});
	
	$('#writeBtn').on('click', function() {
		
		let content = $('#writeTextArea').val();
		if (content.length < 1) {
			alert("글 내용을 입력해주세요.");
			return;
		}
		
		let file = $('#file').val();
		if (file == '') {
			alert("이미지를 넣어주세요.");
			return;
		}
		
		let ext = file.split('.').pop().toLowerCase();
		if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
			alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
			$('file').val('');
			return;
		}
		
		let formData = new FormData();
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			type:"POST"
			, url:"/post/create"
			, data:formData
			, encrypt:"multipart/form-data"
			, processData: false
			, contentType: false
			, success: function(data) {
				if (data.code == 100) {
					location.reload();
				} else if (data.code == 300) {
					location.href = "/user/sign_in_view";
				} else {
					alert(data.errorMessage);
				}
			}
			, error: function(e) {
				alert("글 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// 댓글 개시버튼 클릭
	$('.comment-btn').on('click', function() {
		// alert("개시버튼 클릭")
		let postId = $(this).data('post-id'); // data-post-id
		//alert(postId);
		// 지금 클릭된 게시 버튼의 형제인 input 태그를 가져온다. (siblings)
		let comment = $(this).siblings('input').val().trim();
		//alert(comment);
		
		let formData = new FormData();
		formData.append("postId", postId);
		formData.append("comment", comment);
		
		$.ajax({
			type:"POST"
			, url:"/comment/create"
			, data:formData
			, enctype:"multipart/form-data"
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 100) {
					location.reload();
				} else if (data.code == 300) {
					location.href = "/user/sign_in_view";
				} else {
					alert(data.errorMessage);
				}
			}
			, error: function(e) {
				alert("댓글 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>