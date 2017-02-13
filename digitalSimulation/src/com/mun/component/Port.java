package com.mun.component;

import com.mun.emun.ValueLogic;
/**
 * Every gate should have port to access the logic value
 * @author wanhui
 *
 */
public abstract class Port {
	protected double xPosition;
	protected double yPosition;
	protected ValueLogic value;
	
	
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


	public ValueLogic getValue() {
		return value;
	}


	/**
	 * set the port value
	 * @param value
	 */
	abstract void setValue(ValueLogic value);
}
