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
<p id="errMsg">
Sorry the city you are searching for is not covered in our weather application or had some issues fetching the data. Please check your internet connection and try again.
</p>
</div>
<div>
<a id="returnLink" href="WeatherForecast.jsp" >Return</a>
</div>
</body>
</html>