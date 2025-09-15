<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Spring Form 表單標籤 -->
<%@ taglib prefix="sp" uri="http://www.springframework.org/tags/form" %>
<sp:form class="pure-form" method="post" modelAttribute="roomDto" action="/room" >
	<fieldset>
		<legend>桌位表單</legend>
		桌號: <sp:input type="number" path="dtableId" />
		<sp:errors path="roomId" style="color: red" />
		<p />
		桌名: <sp:input type="text" path="dtableName" />
		<sp:errors path="dtableName" style="color: red" />
		<p />
		座位數: <sp:input type="number" path="dtableSize" />
		<sp:errors path="dtableSize" style="color: red" />
		<p />
		<button type="submit" class="pure-button pure-button-primary">新增</button>
	</fieldset>
</sp:form>