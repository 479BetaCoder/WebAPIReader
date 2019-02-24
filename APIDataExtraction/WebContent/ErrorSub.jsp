<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="./Shared/Navigator.jsp"  %>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='./Shared/API.css'>
<title></title>
</head>
<body>
<div>
<p id="errMsg"> Sorry the feed you are subscribing to had some issue. </p>
</div>
<div id="divFdValidate">
Please check your internet connection [OR] Please validate your feed <a href="https://validator.w3.org/feed/" target="_blank">here</a>
</div>
<div>
<a id="returnLink" href="Subscribe.jsp" >Return</a>
</div>
</body>
</html>