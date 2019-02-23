package edu.neu.csye6220.weather;

import java.util.ArrayList;


public class Weather {

	private String location;
	
	private ArrayList<Period> timePeriodList;
	
	public Weather() {
		timePeriodList = new ArrayList<Period>();
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public ArrayList<Period> getTimePeriodList() {
		return timePeriodList;
	}

	public void setTimePeriodList(ArrayList<Period> timePeriodList) {
		this.timePeriodList = timePeriodList;
	}

	public void addToPeriodList(Period p) {
		timePeriodList.add(p);
	}

}
