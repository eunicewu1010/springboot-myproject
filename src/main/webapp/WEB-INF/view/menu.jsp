<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div style="background-color: #dddddd">
	<div style="padding: 10px">
		${ (userCert eq null) ? "尚未登入" : userCert.username }
		<a href="/login" class="button-secondary pure-button" >Login</a>
		<a href="/dtables" class="button-secondary pure-button" >座位管理系統</a>
	</div>
</div>