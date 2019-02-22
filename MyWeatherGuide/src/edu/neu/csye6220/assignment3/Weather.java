package edu.neu.csye6220.assignment3;

import java.util.ArrayList;
import java.util.Date;

public class Weather {
	
	private String location;
	private String country;
	private String skyStatus;
	private String windSpeed;
	private double temperature;
	private double pressure;
	private double humidity;
	private ArrayList<Date> fromDate;
	private ArrayList<Date> toDate;
	
	
	public Weather() {
		fromDate = new ArrayList<Date>();
		toDate = new ArrayList<Date>();
	}
	
	public ArrayList<Date> getFromDate() {
		return fromDate;
	}
	public void setFromDate(ArrayList<Date> fromDate) {
		this.fromDate = fromDate;
	}
	public ArrayList<Date> getToDate() {
		return toDate;
	}
	public void setToDate(ArrayList<Date> toDate) {
		this.toDate = toDate;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getSkyStatus() {
		return skyStatus;
	}
	public void setSkyStatus(String skyStatus) {
		this.skyStatus = skyStatus;
	}
	public String getWindSpeed() {
		return windSpeed;
	}
	public void setWindSpeed(String windSpeed) {
		this.windSpeed = windSpeed;
	}
	public double getTemperature() {
		return temperature;
	}
	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}
	public double getPressure() {
		return pressure;
	}
	public void setPressure(double pressure) {
		this.pressure = pressure;
	}
	public double getHumidity() {
		return humidity;
	}
	public void setHumidity(double humidity) {
		this.humidity = humidity;
	}
	
	public void addFromTime(Date dt) {
		fromDate.add(dt);
	}
	public void addToTime(Date dt) {
		toDate.add(dt);
	}
	

}
