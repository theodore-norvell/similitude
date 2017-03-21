package com.mun.component;
/**
 * Link consist of two endpoints
 * @author wanhui
 *
 */
public class Link {
	private EndPoints leftEndpoint;
	private EndPoints rightEndPoint;
	
	public Link(EndPoints leftEndpoint, EndPoints rightEndPoint) {
		super();
		this.leftEndpoint = leftEndpoint;
		this.rightEndPoint = rightEndPoint;
	}

	public EndPoints getLeftEndpoint() {
		return leftEndpoint;
	}

	public void setLeftEndpoint(EndPoints leftEndpoint) {
		this.leftEndpoint = leftEndpoint;
	}

	public EndPoints getRightEndPoint() {
		return rightEndPoint;
	}

	public void setRightEndPoint(EndPoints rightEndPoint) {
		this.rightEndPoint = rightEndPoint;
	}
	
	
}
