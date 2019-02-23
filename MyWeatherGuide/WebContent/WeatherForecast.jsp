<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.ArrayList, edu.neu.csye6220.assignment3.Weather"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body onload="initialize()">
	<h1>RK Open Weather Service</h1>
	<form action="WeatherForecast" method="get">
		<div id="locationField">
			<label for="txtCity">City</label> <input id="autocomplete"
				name="txtCity" placeholder="Enter your City" onFocus="geolocate()"
				type="text"></input>
		</div>
		<div>
			<select name="language">
				<option value="en" selected="selected">English</option>
				<option value="ar" >Arabic</option>
				<option value="bg" >Bulgarian</option>
				<option value="ca" >Catalan</option>
				<option value="cz" >Czech</option>
				<option value="de" >German</option>
				<option value="el" >Greek</option>
				<option value="fa">Persian (Farsi)</option>
				<option value="fi">Finnish</option>
				<option value="fr">French</option>
				<option value="es">Spanish</option>
				<option value="gl" >Galician</option>
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
				  
			</select>
		</div>
		<label>NOTE: Translation is only applied for the "description" field.</label>
		<div>
			<select name="standard">
				<option value="imperial" selected="selected">Fahrenheit</option>
				<option value="Celsius">Celsius</option>
				<option value="Kelvin">Kelvin</option>
			</select>
			<select name="rows">
				<option value="5" selected="selected">Five</option>
				<option value="10" >Ten</option>
				<option value="20">Twenty</option>
				<option value="30">Thirty</option>
				<option value="40">Forty</option>
				
			</select>
		</div>
		<div>
			<select name="days">
				<option value="1" selected="selected">One</option>
				<option value="2">Two</option>
				<option value="3">Three</option>
				<option value="4">Four</option>
				<option value="5">Five</option>
			</select>
		</div>
		<input type="submit" value="Get Forecast">
	</form>
	<%
		 if (session.getAttribute("wer") != null) {
			Weather wObj = (Weather) session.getAttribute("wer"); 
			 
		
	%>
	
	<div>
		<label id="lblCity" for="lblCity"> City </label> <label
			id="lblCityValue" for="lblCityValue"><%=wObj.getLocation()%>
		</label>
	</div>
	<div>
		<table>
			<thead>
				<tr>
					<th>FROM</th>
					<th>TO</th>
					<th>TEMPERATURE</th>
					<th>HUMIDITY</th>
					<th>PRESSURE</th>
					<th>SKY STATUS</th>
					<th>WIND SPEED</th>
				</tr>
			</thead>
			<c:forEach items="${sessionScope.wer.getTimePeriodList()}"
				var="periodItem">
				<tr>
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
	<%
		}
	%>

</body>
</html>