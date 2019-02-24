<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="./Shared/Navigator.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='./Shared/API.css'>
<title>Feed subscribe</title>
</head>
<body>
	<div>
		<h1 id="wtrTitle">Feed Reader</h1>
	</div>
	<div>
		<form name="feedForm" class="form-horizontal" action="Subscribe">
			<div class="form-group">
				<label class="control-label col-sm-2" for="txtFeedUrl">Feed
					URL : </label>
				<div class="col-sm-5">
					<input id="txtFeedUrl"  class="form-control" type="text" name="txtFeedUrl" placeholder="Enter your feed url" required="required" pattern="https?://.+" title="Include http://" >

					<label for="lnkfeed"> <a
						href="https://www.repeatsoftware.com/help/RSSFeedList.htm"
						title="Find feed links here" target="_blank">Need Feed?</a></label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="txtFeedLimit">Feed
					Limit : </label>
				<div class="col-sm-5">
					<input class="form-control" type="number" name="txtFeedLimit" title="This is a required field" placeholder="Enter your desired feed limit" required="required">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default" name="btnSubscribe">Subscribe</button>
				</div>
			</div>

		</form>
	</div>
	
	
	
	<c:if test="${rss.size()>0}">
	<c:if test="${feedCnt}">
	<img id="imgSubscribe" alt="subImg"
				src="./Images/subscribe.jpg">
	<label>Subscribed successfully</label>
	</c:if>
	<div id="subContainer">
		<p id="hdrLocation">
			<label id="lblCityValue" for="lblCityValue"> Active
				Subscriptions</label> 
		</p>
		<div>
			<table id="subTable" class="table">
				<c:forEach items="${rss}" var="feed">
					<tr>
						<td rowspan="${feed.getFeeditemList().size()+1}">
							<div
								class="list-group-item list-group-item-action flex-column align-items-start active">
								<div class="d-flex w-100 justify-content-between">
									<h5 class="mb-1">${feed.getFeedName()}</h5>
								</div>
							</div>
						</td>
					</tr>

					<c:forEach items="${feed.getFeeditemList()}" var="feedItem">
						<tr>
							<td>
								<div class="list-group">

									<div class="list-group-item list-group-item-action">
										<h5 id="feedtitle" class="mb-1">${feedItem.getTitle()}</h5>
									</div>

									<a class="list-group-item list-group-item-action" id="feedLink"
										target="_blank" href="${feedItem.getLink()}">Get Details</a>
								</div>

							</td>
						</tr>

					</c:forEach>
				</c:forEach>
			</table>

		</div>
		</div>
	</c:if>
</body>
</html>