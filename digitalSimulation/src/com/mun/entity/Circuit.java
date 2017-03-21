package com.mun.entity;

/**
 * Circuit entity. @author MyEclipse Persistence Tools
 */

public class Circuit implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer userId;
	private String circuitFileAddress;
	private String circuitSnapshoot;

	// Constructors

	/** default constructor */
	public Circuit() {
	}

	/** full constructor */
	public Circuit(String name, Integer userId, String circuitFileAddress,
			String circuitSnapshoot) {
		this.name = name;
		this.userId = userId;
		this.circuitFileAddress = circuitFileAddress;
		this.circuitSnapshoot = circuitSnapshoot;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCircuitFileAddress() {
		return this.circuitFileAddress;
	}

	public void setCircuitFileAddress(String circuitFileAddress) {
		this.circuitFileAddress = circuitFileAddress;
	}

	public String getCircuitSnapshoot() {
		return this.circuitSnapshoot;
	}

	public void setCircuitSnapshoot(String circuitSnapshoot) {
		this.circuitSnapshoot = circuitSnapshoot;
	}

}