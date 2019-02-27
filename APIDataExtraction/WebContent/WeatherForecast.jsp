<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.ArrayList, edu.neu.csye6220.weather.Weather"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="./Shared/Navigator.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='./Shared/API.css'>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyA3cuMvhvz23X-a68vmrOFyJEeHoESIKTo"></script>
<script>
	var autocomplete;
	function initialize() {
		autocomplete = new google.maps.places.Autocomplete(
		/** @type {HTMLInputElement} */
		(document.getElementById('autocomplete')), {
			types : [ '(cities)' ]
		});
		google.maps.event.addListener(autocomplete, 'place_changed',
				function() {
				});
	}

	$(document).ready(function() {
		$('#tblWeather').dataTable({
			"pagingType" : "simple" // "simple" option for 'Previous' and 'Next' buttons only
		});
		$('.dataTables_length').addClass('bs-select');
	});
</script>
</head>
<body onload="initialize()">
	<div>
		<h1 id="wtrTitle">Weather Forecast</h1>
	</div>
	<div>
		<form id="frmWeather" class="form-horizontal" action="WeatherForecast"
			method="POST">
			<div class="form-group" id="locationField">
				<label class="control-label col-sm-2" for="txtCity">City</label>
				<div class="col-sm-5">
					<input id="autocomplete" class="form-control" name="txtCity"
						value="${cityName}" required="required" pattern=".*\S+.*"
						title="This field is required" placeholder="Enter your City"
						onFocus="geolocate()" type="text"></input> <label
						id="noteLanguage">NOTE: Google Autocomplete is enabled. If
						results are not satisfactory, please type in the city name.</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="selLanguage">Language</label>
				<div class="col-sm-5">
					<select class="form-control" name="language">
						<option value="en"
							<c:if test="${'en' eq lang}">selected="selected"</c:if>>English</option>
						<option value="ar"
							<c:if test="${'ar' eq lang}">selected="selected"</c:if>>Arabic</option>
						<option value="bg"
							<c:if test="${'bg' eq lang}">selected="selected"</c:if>>Bulgarian</option>
						<option value="ca"
							<c:if test="${'ca' eq lang}">selected="selected"</c:if>>Catalan</option>
						<option value="cz"
							<c:if test="${'cz' eq lang}">selected="selected"</c:if>>Czech</option>
						<option value="de"
							<c:if test="${'de' eq lang}">selected="selected"</c:if>>German</option>
						<option value="el"
							<c:if test="${'el' eq lang}">selected="selected"</c:if>>Greek</option>
						<option value="fa"
							<c:if test="${'fa' eq lang}">selected="selected"</c:if>>Persian
							(Farsi)</option>
						<option value="fi"
							<c:if test="${'fi' eq lang}">selected="selected"</c:if>>Finnish</option>
						<option value="fr"
							<c:if test="${'fr' eq lang}">selected="selected"</c:if>>French</option>
						<option value="es"
							<c:if test="${'es' eq lang}">selected="selected"</c:if>>Spanish</option>
						<option value="gl"
							<c:if test="${'gl' eq lang}">selected="selected"</c:if>>Galician</option>
						<option value="hr"
							<c:if test="${'hr' eq lang}">selected="selected"</c:if>>Croatian</option>
						<option value="hu"
							<c:if test="${'hu' eq lang}">selected="selected"</c:if>>Hungarian</option>
						<option value="it"
							<c:if test="${'it' eq lang}">selected="selected"</c:if>>Italian</option>
						<option value="ja"
							<c:if test="${'ja' eq lang}">selected="selected"</c:if>>Japanese</option>
						<option value="kr"
							<c:if test="${'kr' eq lang}">selected="selected"</c:if>>Korean</option>
						<option value="nl"
							<c:if test="${'nl' eq lang}">selected="selected"</c:if>>Dutch</option>
						<option value="pt"
							<c:if test="${'pt' eq lang}">selected="selected"</c:if>>Portuguese</option>
						<option value="ru"
							<c:if test="${'ru' eq lang}">selected="selected"</c:if>>Russian</option>
						<option value="zh_cn"
							<c:if test="${'zh_cn' eq lang}">selected="selected"</c:if>>Chinese
							Simplified</option>
						<option value="zh_tw"
							<c:if test="${'zh_tw' eq lang}">selected="selected"</c:if>>Chinese
							Traditional</option>

					</select> <label id="noteLanguage">NOTE: Translation is only applied
						for the "sky status" field.</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="selStandard">Temperature
					Units</label>
				<div class="col-sm-5">
					<select class="form-control" name="standard">
						<option value="imperial"
							<c:if test="${'imperial' eq std}">selected="selected"</c:if>>Fahrenheit</option>
						<option value="metric"
							<c:if test="${'metric' eq std}">selected="selected"</c:if>>Celsius</option>
						<option value="Kelvin"
							<c:if test="${'Kelvin' eq std}">selected="selected"</c:if>>Kelvin</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="selRows">Rows</label>
				<div class="col-sm-5">
					<select class="form-control" name="rows">
						<option value="5"
							<c:if test="${'5' eq rowNum}">selected="selected"</c:if>>Five</option>
						<option value="10"
							<c:if test="${'10' eq rowNum}">selected="selected"</c:if>>Ten</option>
						<option value="20"
							<c:if test="${'20' eq rowNum}">selected="selected"</c:if>>Twenty</option>
						<option value="30"
							<c:if test="${'30' eq rowNum}">selected="selected"</c:if>>Thirty</option>
						<option value="40"
							<c:if test="${'40' eq rowNum}">selected="selected"</c:if>>Forty</option>

					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button id="btnForecast" type="submit" class="btn btn-default"
						name="btnForecast">Get Forecast</button>
				</div>
			</div>

		</form>
	</div>

	<%
		if (session.getAttribute("wer") != null) {
			Weather wObj = (Weather) session.getAttribute("wer");
			if (wObj.getTimePeriodList().size() > 0) {
	%>
	<c:if test="${weReport}">
		<img id="imgWth" alt="WeatherImg" src="./Images/weather.jpeg">
		<label>Weather Report</label>
	</c:if>
	<div id="subContainer">
		<p id="hdrLocation">

			<label id="lblCityValue" for="lblCityValue"><%=wObj.getLocation()%>
			</label>
		</p>
		<div>
			<table class="table table-striped table-dark" id="tblWeather">
				<thead>
					<tr>
						<th scope="col">S.No</th>
						<th scope="col">FROM</th>
						<th scope="col">TO</th>
						<th scope="col">TEMPERATURE</th>
						<th scope="col">HUMIDITY (%)</th>
						<th scope="col">PRESSURE (hpa)</th>
						<th scope="col">SKY STATUS</th>
						<th scope="col">WIND SPEED</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sessionScope.wer.getTimePeriodList()}"
						var="periodItem" varStatus="loop">
						<tr>
							<th scope="row">${loop.index+1}</th>
							<td>${periodItem.getFromDate()}</td>
							<td>${periodItem.getToDate()}</td>
							<td>${periodItem.getTemperature()}</td>
							<td>${periodItem.getHumidity()}</td>
							<td>${periodItem.getPressure()}</td>
							<td>${periodItem.getSkyStatus()}</td>
							<td>${periodItem.getWindSpeed()}</td>
						</tr>
					</c:forEach>
			</table>
		</div>
	</div>
	<%
		}
	}
	%>

</body>
</html>