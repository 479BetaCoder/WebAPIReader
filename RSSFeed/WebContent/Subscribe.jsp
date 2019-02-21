<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Feed subscribe</title>
</head>
<body>
<h1>RK Feed Facility</h1>
<div>
<p>Thank you for visiting RK Feed Facility ! Please subscribe for your favorite feeds</p>
</div>
<div>
<form action="Subscribe">
<label for="txtFeedUrl">Feed URL : </label>
<input type="text" name="txtFeedUrl">
<label for="txtFeedLimit">Feed Limit : </label>
<input type="text" name="txtFeedLimit">
<input type="submit" name="btnSubscribe" value="Subscribe">
</form>
</div>
<div>
<c:forEach items="${rss}" var="feed">
	<h2>${feed.getFeedName()}</h2>
<c:forEach items="${feed.getFeeditemList()}" var="feedItem">	
	<p>${feedItem.getTitle()}</p> 
 	<a href="${feedItem.getLink()}">${feedItem.getLink()}</a>
</c:forEach>
</c:forEach>
</div>
</body>
</html>