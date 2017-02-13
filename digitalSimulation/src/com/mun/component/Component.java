package com.mun.component;

import java.util.ArrayList;

import com.mun.emun.Orientation;
import com.mun.gates.ComponentKind;

/**
 * Component composite by gates and ports, in this class
 * will composite gates and ports into one entity. 
 * @author wanhui
 *
 */
public class Component {
	private double xPosition;//the x position of the component
	private double yPosition;//the y position of the component
	private Orientation direction;//the orientation of the component
	private ComponentKind componentKind;//the actual gate of this component
	private ArrayList<Port> portArrayList;//the ports for the component
	private String name;//the name of the component
	
	public double getxPosition() {
		return xPosition;
	}
	public void setxPosition(double xPosition) {
		this.xPosition = xPosition;
	}
	public double getyPosition() {
		return yPosition;
	}
	public void setyPosition(double yPosition) {
		this.yPosition = yPosition;
	}
	public Orientation getDirection() {
		return direction;
	}
	public void setDirection(Orientation direction) {
		this.direction = direction;
	}
	public ComponentKind getComponentKind() {
		return componentKind;
	}
	public void setComponentKind(ComponentKind componentKind) {
		this.componentKind = componentKind;
	}
	public ArrayList<Port> getPortArrayList() {
		return portArrayList;
	}
	public void setPortArrayList(ArrayList<Port> portArrayList) {
		this.portArrayList = portArrayList;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
