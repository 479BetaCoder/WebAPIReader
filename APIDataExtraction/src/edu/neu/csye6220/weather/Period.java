package edu.neu.csye6220.weather;
import java.util.Date;

public class Period {
	
	private String skyStatus;
	private String windSpeed;
	private Double temperature;
	private Double pressure;
	private Double humidity;
	private Date fromDate;
	private Date toDate;
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
	public Double getTemperature() {
		return temperature;
	}
	public void setTemperature(Double temperature) {
		this.temperature = temperature;
	}
	public Double getPressure() {
		return pressure;
	}
	public void setPressure(Double pressure) {
		this.pressure = pressure;
	}
	public Double getHumidity() {
		return humidity;
	}
	public void setHumidity(Double humidity) {
		this.humidity = humidity;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public Date getToDate() {
		return toDate;
	}
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

}
