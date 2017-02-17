package com.mun.component;

import com.mun.emun.IO;
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
	protected IO portDescription;
	
	
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

	public IO getPortDescription() {
		return portDescription;
	}

	abstract void setPortDescription(IO portDescription);

	public void setValue(ValueLogic value) {
		this.value = value;
	}

}
