package edu.neu.csye6220.rssFeed;

import java.util.ArrayList;

public class Feed {

	private ArrayList<FeedItem> feeditemList;
	private String feedName;
	private ArrayList<String> lstFeedName;
	private FeedItem fdItem;

	public Feed() {
		feeditemList = new ArrayList<FeedItem>();
		setLstFeedName(new ArrayList<String>());
	}
	public ArrayList<FeedItem> getFeeditemList() {
		return feeditemList;
	}

	public void setFeeditemList(ArrayList<FeedItem> feeditemList) {
		this.feeditemList = feeditemList;
	}

	public FeedItem getFdItem() {
		return fdItem;
	}

	public void setFdItem(FeedItem fdItem) {
		this.fdItem = fdItem;
	}
	
	public String getFeedName() {
		return feedName;
	}
	public void setFeedName(String feedName) {
		this.feedName = feedName;
	}
	public ArrayList<String> getLstFeedName() {
		return lstFeedName;
	}
	public void setLstFeedName(ArrayList<String> lstFeedName) {
		this.lstFeedName = lstFeedName;
	}
	
	public void addFeedItems(FeedItem fd) {
		feeditemList.add(fd);
		
	}
	
	public void addFeedNames(String channel) {
		lstFeedName.add(channel);
	}
}
