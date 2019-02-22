<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.ArrayList, edu.neu.csye6220.assignment3.Weather"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
	<h1>RK Open Weather Service</h1>
	<form action="WeatherForecast" method="get">
		<label for="txtCity">City</label> <input type="text" name="txtCity">
		<label for="txtCountry">Country Code</label> <input type="text"
			name="txtCountry"> <input type="submit" value="Get Forecast">
	</form>
	<%
		if(request.getAttribute("wer")!=null){
		Weather wObj = (Weather) request.getAttribute("wer"); %>
		<label><%=wObj.getLocation() %>  </label>
		<label><%=wObj.getCountry() %>  </label>
		<label><%=wObj.getTemperature() %> </label>
		<label><%=wObj.getHumidity() %>  </label>
		<label><%=wObj.getPressure() %>  </label>
		<label><%=wObj.getSkyStatus() %>  </label>
		<label><%=wObj.getWindSpeed() %>  </label>
		
		<% }%>

</body>
</html>