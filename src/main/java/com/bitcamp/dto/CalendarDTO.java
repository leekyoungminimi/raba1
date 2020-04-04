package com.bitcamp.dto;

public class CalendarDTO {
	private int calno;
	private String title;
	private String start;
	private String end;
	public int getCalno() {
		return calno;
	}
	public void setCalno(int calno) {
		this.calno = calno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "CalendarDTO [calno=" + calno + ", title=" + title + ", start=" + start + ", end=" + end + "]";
	}
	
	
	
}
