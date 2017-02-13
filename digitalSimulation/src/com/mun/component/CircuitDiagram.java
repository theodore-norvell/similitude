package com.mun.component;

import java.util.ArrayList;

/**
 * A circuit diagram have one or more component and one or more links.<br>
 * 
 * @author wanhui
 *
 */
public class CircuitDiagram {
	private ArrayList<Component> componentArrayList;
	private ArrayList<Link> linkArrayList;
	private String name;//the name of this circuit diagram
	
	public ArrayList<Component> getComponentArrayList() {
		return componentArrayList;
	}
	public void setComponentArrayList(ArrayList<Component> componentArrayList) {
		this.componentArrayList = componentArrayList;
	}
	public ArrayList<Link> getLinkArrayList() {
		return linkArrayList;
	}
	public void setLinkArrayList(ArrayList<Link> linkArrayList) {
		this.linkArrayList = linkArrayList;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
