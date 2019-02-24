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
</script>
</head>
<body onload="initialize()">
	<div>
		<h1 id="wtrTitle">Weather Forecast</h1>
	</div>
	<div>
		<form id="frmWeather" class="form-horizontal" action="WeatherForecast"
			method="get">
			<div class="form-group" id="locationField">
				<label class="control-label col-sm-2" for="txtCity">City</label>
				<div class="col-sm-5">
					<input id="autocomplete" class="form-control" name="txtCity"
						required="required" pattern=".*\S+.*"
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
						<option value="en" selected="selected">English</option>
						<option value="ar">Arabic</option>
						<option value="bg">Bulgarian</option>
						<option value="ca">Catalan</option>
						<option value="cz">Czech</option>
						<option value="de">German</option>
						<option value="el">Greek</option>
						<option value="fa">Persian (Farsi)</option>
						<option value="fi">Finnish</option>
						<option value="fr">French</option>
						<option value="es">Spanish</option>
						<option value="gl">Galician</option>
						<option value="hr">Croatian</option>
						<option value="hu">Hungarian</option>
						<option value="it">Italian</option>
						<option value="ja">Japanese</option>
						<option value="kr">Korean</option>
						<option value="nl">Dutch</option>
						<option value="pt">Portuguese</option>
						<option value="ru">Russian</option>
						<option value="zh_cn">Chinese Simplified</option>
						<option value="zh_tw">Chinese Traditional</option>

					</select> <label id="noteLanguage">NOTE: Translation is only applied
						for the "sky status" field.</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="selStandard">Temperature
					Units</label>
				<div class="col-sm-5">
					<select class="form-control" name="standard">
						<option value="imperial" selected="selected">Fahrenheit</option>
						<option value="metric">Celsius</option>
						<option value="Kelvin">Kelvin</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="selRows">Rows</label>
				<div class="col-sm-5">
					<select class="form-control" name="rows">
						<option value="5" selected="selected">Five</option>
						<option value="10">Ten</option>
						<option value="20">Twenty</option>
						<option value="30">Thirty</option>
						<option value="40">Forty</option>

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
	%>
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
	%>

</body>
</html>