package com.mun.component;

import com.mun.emun.ValueLogic;

public class Outport extends Port {

	@Override
	void setValue(ValueLogic value) {
		this.value = value;
	}

}
