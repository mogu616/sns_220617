<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header-box bg-info d-flex justify-content-between align-items-center">
	<div class="ml-4">
		<h1 class="text-white"><a href="/timeline/timeline_view" class="text-white">Marondalgram</a></h1>
	</div>
	<div class="mr-5">
		<c:if test="${not empty userName}">
			<span class="text-white">${userName} 님 안녕하세요!</span>
			<a href="/user/sign_out" class="ml-3 text-white font-weight-bold">로그아웃</a>
		</c:if>
		<c:if test="${empty userName}">
			<a href="/user/sign_in_view" class="text-white font-weight-bold">로그인</a>
		</c:if>
	</div>
</div>