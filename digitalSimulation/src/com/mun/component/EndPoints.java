package com.mun.component;
/**
 * Every link should have two endpoints
 * @author wanhui
 *
 */
public class EndPoints {
	private double xPosition;//x position for the endpoint
	private double yPosition;//y position for the endpoint
	private Port port;//endpoint may meet port
	
	/**
	 * constructor for the endpont
	 * @param xPosition x position
	 * @param yPosition y position
	 */
	public EndPoints(double xPosition, double yPosition) {
		super();
		this.xPosition = xPosition;
		this.yPosition = yPosition;
	}

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

	public Port getPort() {
		return port;
	}

	public void setPort(Port port) {
		this.port = port;
	}
	
	
}
